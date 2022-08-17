require 'rails_helper'

RSpec.describe TmdbClient::Search::Tv, type: :model do

  describe "CLASS METHODS" do

    it ".url" do
      expect(described_class.url).to eq("https://api.themoviedb.org/3/search/tv")
    end

    it ".permitted_params" do
      params = [:api_key, :first_air_date_year, :include_adult, :language, :page, :query]
      expect(described_class.permitted_params).to match_array(params)
    end

    it ".path" do
      expect(described_class.path).to eq("search/tv")
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
        let(:query_params) { {query: "test", language: "hu-HU", page: 9} }
        let(:expected_response) {
          {
            "page" => 9,
            "results" =>
              [{ "backdrop_path" => nil,
                "first_air_date" => "2015-05-05",
                "genre_ids" => [99],
                "id" => 156789,
                "name" => "Die Diät-Tester",
                "origin_country" => ["DE"],
                "original_language" => "de",
                "original_name" => "Die Diät-Tester",
                "overview" => "",
                "popularity" => 0.6,
                "poster_path" => nil,
                "vote_average" => 0,
                "vote_count" => 0 }],
            "success" => true,
            "total_pages" => 9,
            "total_results" => 161
          }
        }

        it "returns with the results of the query" do
          VCR.use_cassette("tv_series_api_key") do
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
        let(:query_params) { {query: "test", language: "hu-HU", page: 9} }
        let(:expected_response) {
          {
            "page" => 9,
            "results" =>
              [{ "backdrop_path" => nil,
                "first_air_date" => "2015-05-05",
                "genre_ids" => [99],
                "id" => 156789,
                "name" => "Die Diät-Tester",
                "origin_country" => ["DE"],
                "original_language" => "de",
                "original_name" => "Die Diät-Tester",
                "overview" => "",
                "popularity" => 0.6,
                "poster_path" => nil,
                "vote_average" => 0,
                "vote_count" => 0 }],
            "success" => true,
            "total_pages" => 9,
            "total_results" => 161
          }
        }

        it "returns with the results of the query" do
          VCR.use_cassette("tv_series_bearer") do
            expect(described_class.get(query_params)).to eq(expected_response)
          end
        end
      end
    end
  end
end
