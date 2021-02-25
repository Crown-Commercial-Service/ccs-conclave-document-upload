require 'rails_helper' 
require 'sidekiq/testing'
include ActiveSupport::Testing::TimeHelpers

RSpec.describe FileRemovalWorker, type: :worker do
  describe 'File removal worker' do
    tmp_dir = Rails.root.join 'public/uploads/tmp'

    it 'should respond to #perform' do
      expect(FileRemovalWorker.new).to respond_to(:perform)
    end

    it 'should delete temp files older than 5 minutes' do
      expect(tmp_dir).not_to be_empty
      travel(6.minutes)
      FileRemovalWorker.new.perform
      expect(tmp_dir).to be_empty
    end
  end
end
