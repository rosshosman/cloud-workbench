class RemoveAttributesFromBenchmarkExecutions < ActiveRecord::Migration[5.0]
  def change
    remove_column :benchmark_executions, :status
    remove_column :benchmark_executions, :start_time
    remove_column :benchmark_executions, :end_time
  end
end
