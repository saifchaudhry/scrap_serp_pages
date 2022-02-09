class ProxyCrawlWorker
  include Sidekiq::Worker
  sidekiq_options retry: false
  def perform
    ProxyCrawl.run
  end
end