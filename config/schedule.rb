# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

env :PATH, ENV['PATH']
set :output, "#{path}/log/cron_log.log"
env :GEM_PATH, ENV['GEM_PATH']
env :GEM_HOME, ENV['GEM_HOME']

every 1.day, at: '1:30 am' do
    starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    rake "decidim:metrics:all"
    ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    elapsed = ending - starting
    command "echo $(date)' - Metrics calculation in #{elapsed} seconds'"
    # command "echo 'OpenData generation...'"
    # rake "decidim:open_data:export"
end