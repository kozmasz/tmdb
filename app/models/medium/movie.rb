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
class Medium::Movie < Medium

  # CLASS METHODS

  class << self
  end
end
