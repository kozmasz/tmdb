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
class MediaGenre < ApplicationRecord

  # VALIDATIONS

  validates :tmdb_medium_id, :tmdb_genre_id, presence: true

  # ASSOCIATIONS

  belongs_to :medium, foreign_key: :tmdb_medium_id, primary_key: :tmdb_id
  belongs_to :genre,  foreign_key: :tmdb_genre_id,  primary_key: :tmdb_id
end
