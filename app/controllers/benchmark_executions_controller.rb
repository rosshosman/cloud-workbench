class BenchmarkExecutionsController < ApplicationController
  before_action :set_benchmark_definition, only: [:new, :create]
  before_action :set_benchmark_execution, only: [:show, :edit, :update, :destroy, :prepare_log, :release_resources_log]

  # GET /benchmark_definition/:id/benchmark_executions
  # GET /benchmark_executions
  def index
    if params[:context] == :benchmark_definition
      set_benchmark_definition
      @benchmark_executions = @benchmark_definition.benchmark_executions.paginate(page: params[:page])
      @metric_definitions = @benchmark_definition.metric_definitions
    else
      @benchmark_executions = BenchmarkExecution.paginate(page: params[:page])
    end
  end

  # GET /benchmark_executions/1
  def show
    @benchmark_definition = @benchmark_execution.benchmark_definition
  end

  def prepare_log
    respond_to do |format|
      format.text { render(text: @benchmark_execution.prepare_log) }
    end
  end

  def release_resources_log
    respond_to do |format|
      format.text { render(text: @benchmark_execution.release_resources_log) }
    end
  end

  # GET /benchmark_definition/:id/benchmark_executions/new
  def new
    @benchmark_execution = @benchmark_definition.benchmark_executions.build
  end

  # GET /benchmark_executions/1/edit
  def edit
  end

  # POST /benchmark_executions
  def create
    @benchmark_execution = @benchmark_definition.start_execution_async
    flash[:success] = "Benchmark execution for
                       #{view_context.link_to @benchmark_definition.name, @benchmark_definition, class: 'alert-link'}
                       was successfully started asynchronously.".html_safe
    redirect_to @benchmark_execution
  rescue => e
    flash[:error] = "Benchmark execution couldn't be started asynchronously.<br>
                     <i class='fa-times'></i>Error: #{e.message}".html_safe
    redirect_to :back
  end

  # PATCH/PUT /benchmark_executions/1
  def update
    if @benchmark_execution.update(benchmark_execution_params)
      redirect_to @benchmark_execution, notice: 'Benchmark execution was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /benchmark_executions/1
  def destroy
    @benchmark_execution.destroy
      redirect_to benchmark_executions_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_benchmark_definition
      @benchmark_definition = BenchmarkDefinition.find(params[:benchmark_definition_id])
    end

    def set_benchmark_execution
      @benchmark_execution = BenchmarkExecution.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def benchmark_execution_params
      params.require(:benchmark_execution).permit(:benchmark_definition_id, :status, :start_time, :end_time)
    end
end
