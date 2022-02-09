namespace :product do
  desc "Make non subscribed users to free membership plan."
  task crawler: :environment do
    ProxyCrawlWorker.perform_async
  end
end
  