require 'rails_helper'

RSpec.describe Medium, type: :model do

  describe "ATTRIBUTES" do
    it { is_expected.to have_attribute :tmdb_id }
    it { is_expected.to have_attribute :media_type }
    it { is_expected.to have_attribute :adult }
    it { is_expected.to have_attribute :release_date }
    it { is_expected.to have_attribute :title }
    it { is_expected.to have_attribute :original_title }
    it { is_expected.to have_attribute :original_language }
    it { is_expected.to have_attribute :overview }
    it { is_expected.to have_attribute :poster_path }
    it { is_expected.to have_attribute :vote_average }
    it { is_expected.to have_attribute :vote_count }
  end

  describe "VALIDATIONS" do
    it { is_expected.to validate_presence_of :tmdb_id }
    it { is_expected.to validate_presence_of :media_type }
    it { is_expected.to validate_presence_of :release_date }
    it { is_expected.to validate_presence_of :title }
    it { is_expected.to validate_presence_of :original_title }
    it { is_expected.to validate_presence_of :original_language }
    it { is_expected.to validate_presence_of :overview }
    it { is_expected.to validate_presence_of :poster_path }
    it { is_expected.to validate_presence_of :vote_average }
    it { is_expected.to validate_presence_of :vote_count }
  end

  describe "ASSOCIATIONS" do
    it { is_expected.to have_many(:media_genres).dependent(:destroy) }
    it { is_expected.to have_many(:genres) }
  end
end
