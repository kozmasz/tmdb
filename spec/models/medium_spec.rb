# == Schema Information
#
# Table name: media
#
#  id                :bigint           not null, primary key
#  tmdb_id           :integer          not null
#  media_type        :string           not null
#  adult             :boolean          default(FALSE), not null
#  release_date      :date
#  title             :string
#  original_title    :string
#  original_language :string
#  overview          :text
#  vote_average      :float
#  vote_count        :integer
#  poster_path       :string
#  popularity        :float
#  backdrop_path     :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
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
  end

  describe "ASSOCIATIONS" do
    it { is_expected.to have_many(:media_genres).dependent(:destroy) }
    it { is_expected.to have_many(:genres) }
  end
end
