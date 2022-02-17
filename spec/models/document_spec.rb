require 'rails_helper'

RSpec.describe Document, type: :model do
  describe 'set_initial_state' do
    let(:document) { create(:document) }

    context 'when the record is first created' do
      it 'should set state to processing' do
        expect(document.state).to eq 'processing'
      end
    end

    context 'when the record is updated' do
      it 'should not change the state' do
        document.update(state: 'safe')
        expect(document.state).to_not eq 'processing'
      end
    end
  end
end
