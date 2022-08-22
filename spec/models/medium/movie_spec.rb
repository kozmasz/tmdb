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
require 'rails_helper'

RSpec.describe Medium::Movie, type: :model do
  describe "ATTRIBUTES" do
    it { is_expected.not_to have_attribute :original_name }
    it { is_expected.not_to have_attribute :name }
    it { is_expected.not_to have_attribute :first_air_date }
  end
end
