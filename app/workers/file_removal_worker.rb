require 'sidekiq-scheduler'

class FileRemovalWorker
  include Sidekiq::Worker

  def perform
    Rails.logger.info 'Deleting temp files.'
    CarrierWave.clean_cached_files!(60 * 5)
    Rails.logger.info 'File deletion done.'
  end
end
