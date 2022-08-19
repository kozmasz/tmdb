# == Schema Information
#
# Table name: media
#
#  id                :bigint           not null, primary key
#  tmdb_id           :integer          not null
#  media_type        :string           not null
#  adult             :boolean          default(FALSE), not null
#  release_date      :date             not null
#  title             :string           not null
#  original_title    :string           not null
#  original_language :string           not null
#  overview          :text             not null
#  poster_path       :string           not null
#  vote_average      :float            not null
#  vote_count        :integer          not null
#  popularity        :float
#  backdrop_path     :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class Medium < ApplicationRecord
  # MODULE INITIALIZERS

  self.inheritance_column = "media_type"

  # CONSTANTS

  MANDATORY_ATTRIBUTES = [
    "tmdb_id", "media_type", "release_date", "title", "original_title",
    "original_language", "overview", "poster_path", "vote_average", "vote_count"
  ].freeze

  WHITELISTED_PARAMS = (MANDATORY_ATTRIBUTES + ["genre_ids", "popularity", "backdrop_path", "original_name", "name", "first_air_date"]).freeze

  # VALIDATIONS

  validates *MANDATORY_ATTRIBUTES, presence: true

  # ASSOCIATIONS

  has_many :media_genres, primary_key: :tmdb_id, foreign_key: :tmdb_medium_id, dependent: :destroy
  has_many :genres, through: :media_genres

  # CLASS METHODS

  class << self
    def normalize_response hash
      hash["tmdb_id"] = hash.delete("id")
      hash.slice(*WHITELISTED_PARAMS)
    end
  end

end
