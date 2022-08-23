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
class Medium < ApplicationRecord
  # MODULE INITIALIZERS

  self.inheritance_column = "media_type"

  # CONSTANTS

  WHITELISTED_PARAMS = [
    "tmdb_id", "media_type", "release_date", "title", "original_title",
    "original_language", "overview", "vote_average", "vote_count",
    "genre_ids", "popularity", "backdrop_path", "original_name", "name", "first_air_date", "poster_path"
  ].freeze

  # VALIDATIONS

  validates :tmdb_id, :media_type, presence: true

  # ASSOCIATIONS

  has_many :media_genres, primary_key: :tmdb_id, foreign_key: :tmdb_medium_id, dependent: :destroy
  has_many :genres, through: :media_genres

  # CLASS METHODS

  class << self
    def find_or_create_from_api hashes
      Array.wrap(hashes).map do |hash|
        hash["tmdb_id"] = hash.delete("id")
        hash.slice!(*WHITELISTED_PARAMS)
        genre_ids = hash.delete("genre_ids")
        transaction do
          movie = create_with(hash).find_or_create_by(tmdb_id: hash["tmdb_id"])
          movie.genre_ids = genre_ids
          movie
        end
      end
    end
  end

  # INSTANCE_METHODS

  # size can be: [:w92, :w154, :w185, :w342, :w500, :w780, :original]
  def poster_url(size = :original)
    if poster_path
      [ Configuration.instance.secure_base_image_url, size, poster_path ].join
    else
      "no-image-icon.png"
    end
  end

  def title_with_year
    "#{title} (#{year})"
  end

  def year
    release_date.try(:year)
  end

  def genre_names
    genres.pluck(:name).join(", ")
  end
end
