require 'rails_helper'

RSpec.describe TmdbClient::Search::Movie, type: :model do

  describe "CLASS METHODS" do

    it ".url" do
      expect(described_class.url).to eq("https://api.themoviedb.org/3/search/movie")
    end

    it ".permitted_params" do
      params = [:api_key, :language, :page, :include_adult, :query, :region, :year, :primary_release_year]
      expect(described_class.permitted_params).to match_array(params)
    end

    it ".path" do
      expect(described_class.path).to eq("search/movie")
    end

    describe "When authenticated with API KEY" do
      before do
        allow(Rails.configuration).to receive(:tmdb_auth_type).and_return('api_key')
        allow(Rails.configuration).to receive(:tmdb_api_key).and_return('secret_api_key')
      end

      it ".default_params" do
        expect(described_class.default_params).to eq({"api_key"=>"secret_api_key", "include_adult"=>false, "language"=>"en-US", "page"=>1})
      end

      context ".get" do
        let(:query_params) { {query: "test", language: "hu-HU", page: 59} }
        let(:expected_response) {
          {
            "page" => 59,
            "results" =>
              [{ "adult" => false,
                "backdrop_path" => "/7Lifoyyagv3gJ9WuyN9iqrmuu8R.jpg",
                "genre_ids" => [18, 9648],
                "id" => 104343,
                "original_language" => "ja",
                "original_title" => "東京战争戦後秘話",
                "overview" => "",
                "popularity" => 0.666,
                "poster_path" => "/x9Zm80FhJEH57yZ6t7S26KUuNJo.jpg",
                "release_date" => "1970-06-27",
                "title" => "東京战争戦後秘話",
                "video" => false,
                "vote_average" => 5.9,
                "vote_count" => 18 }],
            "success" => true,
            "total_pages" => 59,
            "total_results" => 1161
          }
        }

        it "returns with the results of the query" do
          VCR.use_cassette("movies_api_key") do
            expect(described_class.get(query_params)).to eq(expected_response)
          end
        end
      end
    end

    describe "When authenticated with Bearer Token" do
      before do
        allow(Rails.configuration).to receive(:tmdb_auth_type).and_return('bearer_token')
        allow(Rails.configuration).to receive(:tmdb_bearer_token).and_return('secret_token')
      end

      it ".default_params" do
        expect(described_class.default_params).to eq({"include_adult"=>false, "language"=>"en-US", "page"=>1})
      end

      context ".get" do
        let(:query_params) { {query: "test", language: "hu-HU", page: 59} }
        let(:expected_response) {
          {
            "page" => 59,
            "results" =>
              [{ "adult" => false,
                "backdrop_path" => "/7Lifoyyagv3gJ9WuyN9iqrmuu8R.jpg",
                "genre_ids" => [18, 9648],
                "id" => 104343,
                "original_language" => "ja",
                "original_title" => "東京战争戦後秘話",
                "overview" => "",
                "popularity" => 0.666,
                "poster_path" => "/x9Zm80FhJEH57yZ6t7S26KUuNJo.jpg",
                "release_date" => "1970-06-27",
                "title" => "東京战争戦後秘話",
                "video" => false,
                "vote_average" => 5.9,
                "vote_count" => 18 }],
            "success" => true,
            "total_pages" => 59,
            "total_results" => 1161
          }
        }

        it "returns with the results of the query" do
          VCR.use_cassette("movies_bearer") do
            expect(described_class.get(query_params)).to eq(expected_response)
          end
        end
      end
    end
  end
end
