class CallCheckServiceWorker
  include Sidekiq::Worker
  sidekiq_options retry: 5, dead: false

  def perform(unchecked_document_id)
    return unless ENV['CHECK_ENDPOINT_URL']

    HTTParty.put(ENV['CHECK_ENDPOINT_URL'], body:
      { unchecked_document_id: unchecked_document_id }, headers: { 'Authorization' => ENV['AUTH_TOKEN'] })
  end
end
