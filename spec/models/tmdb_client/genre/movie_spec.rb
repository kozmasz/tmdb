require 'rails_helper'

RSpec.describe TmdbClient::Genre::Movie, type: :model do

  describe "CLASS METHODS" do

    it ".url" do
      expect(described_class.url).to eq("https://api.themoviedb.org/3/genre/movie/list")
    end

    it ".permitted_params" do
      expect(described_class.permitted_params).to match_array([:api_key, :language])
    end

    it ".path" do
      expect(described_class.path).to eq("genre/movie/list")
    end

    describe "When authenticated with API KEY" do
      before do
        allow(Rails.configuration).to receive(:tmdb_auth_type).and_return('api_key')
        allow(Rails.configuration).to receive(:tmdb_api_key).and_return('secret_api_key')
      end

      it ".default_params" do
        expect(described_class.default_params).to eq({"api_key"=>"secret_api_key", "language"=>"en-US"})
      end

      context ".all" do
        let(:expected_response) { [{"id"=>28, "name"=>"Action"}, {"id"=>12, "name"=>"Adventure"}] }

        it "returns with the list of genres" do
          VCR.use_cassette("movie_genres_api_key") do
            expect(described_class.all).to eq(expected_response)
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
        expect(described_class.default_params).to eq({"language"=>"en-US"})
      end

      context ".all" do
        let(:expected_response) { [{"id"=>28, "name"=>"Action"}, {"id"=>12, "name"=>"Adventure"}] }

        it "returns with the list of genres" do
          VCR.use_cassette("movie_genres_bearer") do
            expect(described_class.all).to eq(expected_response)
          end
        end
      end
    end
  end
end
