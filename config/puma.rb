threads_count = ENV.fetch("RAILS_MAX_THREADS", 5).to_i
threads threads_count, threads_count

port        ENV.fetch("PORT", 3000)
environment ENV.fetch("RAILS_ENV", "development")

plugin :tmp_restart
plugin "heroku"

#before_fork do
  #require 'puma_worker_killer'

  #PumaWorkerKiller.enable_rolling_restart
#end

