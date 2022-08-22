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
class Medium::Movie < Medium
end
