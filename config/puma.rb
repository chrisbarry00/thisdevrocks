# Fetch the number of threads to use
threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
threads threads_count, threads_count

# Specifies the `port` that Puma will listen on to receive requests.
port ENV.fetch("PORT") { 3000 }

# Specifies the environment Puma will run in.
environment ENV.fetch("RACK_ENV") { "development" }

# Specifies the number of workers to run. Render auto-scales this, but we can set a default.
workers ENV.fetch("WEB_CONCURRENCY") { 2 }

# Preload the application before forking to take advantage of Copy-On-Write (COW)
preload_app!

# Use the `tmp_restart` plugin to allow `bin/rails restart` to work correctly
plugin :tmp_restart

# Ensure ActiveRecord connections are re-established when workers boot
on_worker_boot do
  ActiveRecord::Base.establish_connection if defined?(ActiveRecord)
end

pidfile ENV.fetch("PIDFILE") { "tmp/pids/server.pid" }
