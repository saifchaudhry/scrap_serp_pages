# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
set :environment, "development"
set :output, "log/cron_log.log"
#
every :monday, :at => '10pm' do
  rake 'product:crawler'
end
#/Users/mac/Documents/workspace/crawl_serp_pages/scrap_serp_pages/app/services/config/schedule.rb
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
