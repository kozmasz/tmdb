# == Schema Information
#
# Table name: genres
#
#  id         :bigint           not null, primary key
#  tmdb_id    :integer          not null
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Genre, type: :model do
  describe "ATTRIBUTES" do
    it { is_expected.to have_attribute :tmdb_id }
    it { is_expected.to have_attribute :name }
  end

  describe "VALIDATIONS" do
    it { is_expected.to validate_presence_of :tmdb_id }
    it { is_expected.to validate_presence_of :name }
  end

  describe "ASSOCIATIONS" do
    it { is_expected.to have_many(:media_genres).dependent(:destroy) }
    it { is_expected.to have_many(:media) }
  end
end
