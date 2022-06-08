class CallCheckServiceWorker
  include Sidekiq::Worker
  sidekiq_options retry: 5, dead: false, queue: :upload

  def perform(unchecked_document_id, api_key, auth_token)
    return unless ENV['CHECK_ENDPOINT_URL']

    HTTParty.put(ENV['CHECK_ENDPOINT_URL'] + "/#{document_id(unchecked_document_id)}",
                 headers: { 'x-api-key' => api_key, 'Authorization' => auth_token })
  end

  private

  def document_id(unchecked_document_id)
    UncheckedDocument.find(unchecked_document_id).document_id
  end
end
