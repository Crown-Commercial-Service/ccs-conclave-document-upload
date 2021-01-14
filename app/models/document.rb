class Document < ApplicationRecord
  before_create :set_initial_state

  private

  def set_initial_state
    self.state = 'processing'
  end
end
