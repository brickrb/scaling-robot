#HEROKU
#=============
workers Integer(ENV['WEB_CONCURRENCY'] || 2)
threads_count = Integer(ENV['MAX_THREADS'] || 16)
threads threads_count, threads_count

preload_app!

rackup      DefaultRackup
port        ENV['PORT']     || 3000
environment ENV['RACK_ENV'] || 'development'

on_worker_boot do
  ActiveRecord::Base.establish_connection
end

#VPS
#=============
#workers 1

# Min and Max threads per worker
#threads 1, 6
#
#shared_dir = "/home/deployer/brick/shared"
#
# Default to production
#rails_env = ENV['RAILS_ENV'] || "production"
#environment rails_env
#
# Logging
#stdout_redirect "#{shared_dir}/log/puma.stdout.log", "#{shared_dir}/log/puma.stderr.log", true
#
# Set master PID and state locations
#state_path "#{shared_dir}/pids/puma.state"
#activate_control_app
#
#on_worker_boot do
#  require "active_record"
#  ActiveRecord::Base.connection.disconnect! rescue ActiveRecord::ConnectionNotEstablished
#  ActiveRecord::Base.establish_connection(YAML.load_file("#{shared_dir}/config/database.yml")[rails_env])
#end
