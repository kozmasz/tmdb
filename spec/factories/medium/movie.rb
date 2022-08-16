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
FactoryBot.define do
  factory :movie, class: "Medium::Movie", parent: :medium do
    media_type { "Medium::Movie" }
    sequence(:title) { |n| "Fast & Furious #{n}." }
    sequence(:original_title) { |n| "Fast & Furious #{n}." }
  end
end
