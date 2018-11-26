require 'rails_helper'

RSpec.describe Upload, type: :model do
  it { should validate_presence_of(:name) }
end
