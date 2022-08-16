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
FactoryBot.define do
end
