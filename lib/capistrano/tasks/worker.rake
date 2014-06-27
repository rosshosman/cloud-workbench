namespace :worker do
  DEFAULT_WORKER_NUMBER = 1;

  # Example: restart all workers with 'worker:restart_all'
  RUNIT_COMMANDS.each do |command|
    task = "#{command}_all"
    desc "#{task} delayed_job workers 1-#{fetch(:delayed_job_workers).to_s}"
    task task do
      on roles(:app), in: :sequence, wait: 5 do
        all_workers(command)
      end
    end
  end

  # Example: start the first worker with 'worker:up[1]'
  RUNIT_COMMANDS.each do |command|
    desc "#{command} worker[WORKER_NUMBER] (the first worker has the number 1)"
    task command, [:worker_number] do |task, args|
      on roles(:app), in: :sequence, wait: 5 do
        worker_number = args[:worker_number] || DEFAULT_WORKER_NUMBER
        worker(command, worker_number.to_i)
      end
    end
  end

  def all_workers(command)
    num_workers = fetch(:delayed_job_workers).to_i
    num_workers.times do |worker|
      worker(command, worker.to_i + 1)
    end
  end

  def worker(command, worker_number)
    sudo "sv #{command} delayed_job#{worker_number}"
  end
end