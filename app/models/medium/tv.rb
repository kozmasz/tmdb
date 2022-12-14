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
class Medium::Tv < Medium
  # ALIASES

  alias_attribute :original_name,  :original_title
  alias_attribute :name,           :title
  alias_attribute :first_air_date, :release_date
end
