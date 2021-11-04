require 'rails_helper'

RSpec.describe Reservation, type: :model do
  it { is_expected.to validate_presence_of(:code) }
  it { is_expected.to validate_uniqueness_of(:code) }
  it { is_expected.to validate_presence_of(:start_date) }
  it { is_expected.to validate_presence_of(:end_date) }
  it { is_expected.to validate_numericality_of(:nights).is_greater_than_or_equal_to(1) }
  it { is_expected.to validate_numericality_of(:guests).is_greater_than_or_equal_to(1) }
  it { is_expected.to validate_numericality_of(:adults).is_greater_than_or_equal_to(1) }
end
