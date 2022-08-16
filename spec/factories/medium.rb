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
  factory :medium, class: "Medium" do
    sequence(:tmdb_id)
    release_date { rand(Date.new(1970, 1, 1)..Date.today) }
    original_language { "en" }
    overview { Faker::Lorem.sentences(number: rand(4..10)).join(" ") }
    poster_path { "poster_path.jpg" }
    vote_average { rand(1.0..10.0) }
    vote_count { rand(1..10000) }
    popularity { rand(100.0..10000.0) }
    backdrop_path { "backdrop_path.jpg" }

    trait :with_genres do
      after(:create) do |medium, _evaluator|
        genres = Genre.all.sample(3)
        medium.genres = genres.present? ? genres : build_list(:genre, 5)
      end
    end
  end
end
