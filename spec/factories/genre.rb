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
FactoryBot.define do
  factory :genre, class: "Genre" do
    sequence(:tmdb_id)
    name { Faker::Book.genre }
  end
end
