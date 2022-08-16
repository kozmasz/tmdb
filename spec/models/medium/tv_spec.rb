require 'rails_helper'

RSpec.describe Medium::Tv, type: :model do
  
  describe "ATTRIBUTES" do
    it { is_expected.to have_attribute :original_name }
    it { is_expected.to have_attribute :name }
    it { is_expected.to have_attribute :first_air_date }
  end
end
