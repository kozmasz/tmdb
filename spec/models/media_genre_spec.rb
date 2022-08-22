# == Schema Information
#
# Table name: media_genres
#
#  id             :bigint           not null, primary key
#  tmdb_medium_id :integer          not null
#  tmdb_genre_id  :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
require 'rails_helper'

RSpec.describe MediaGenre, type: :model do
  describe "ATTRIBUTES" do
    it { is_expected.to have_attribute :tmdb_medium_id }
    it { is_expected.to have_attribute :tmdb_genre_id }
  end

  describe "VALIDATIONS" do
    it { is_expected.to validate_presence_of :tmdb_medium_id }
    it { is_expected.to validate_presence_of :tmdb_genre_id }
  end

  describe "ASSOCIATIONS" do
    it { is_expected.to belong_to :medium }
    it { is_expected.to belong_to :genre }
  end
end
