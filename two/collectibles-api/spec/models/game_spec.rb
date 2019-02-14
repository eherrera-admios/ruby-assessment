require 'rails_helper'

RSpec.describe Game, type: :model do
  it { should belong_to :user }

  it { should validate_presence_of :title }
  it { should validate_presence_of :pg }
  it { should validate_presence_of :rating }
end
