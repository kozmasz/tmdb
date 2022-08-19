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
class Genre < ApplicationRecord

  # VALIDATIONS

  validates :tmdb_id, :name, presence: true

  # ASSOCIATIONS

  has_many :media_genres, primary_key: :tmdb_id, foreign_key: :tmdb_genre_id, dependent: :destroy
  has_many :media, through: :media_genres

  # CLASS METHODS

  class << self
    def all_from_api
      genres = (TmdbClient::Genre::Movie.all + TmdbClient::Genre::Tv.all).uniq
      genres.map do |genre|
        genre["tmdb_id"] = genre.delete("id")
        genre
      end
    end

    def seed_data!
      all_from_api.each { |genre_attrs| find_or_create_by(genre_attrs) }
    end

  end
end
