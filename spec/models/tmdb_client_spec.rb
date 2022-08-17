require 'rails_helper'

RSpec.describe TmdbClient, type: :model do

  describe "CLASS METHODS" do

    it ".url" do
      expect(described_class.url).to eq("https://api.themoviedb.org/3/")
    end

    it ".permitted_params" do
      expect(described_class.permitted_params).to eq([:api_key])
    end

    it ".path" do
      expect(described_class.path).to eq("")
    end

    describe ".response_handler" do
      let(:response_class) { Struct.new(:code, :body) }

      context "when the response status is 200 OK" do
        let(:body)     { "{\"page\":1,\"results\":[1,2,3],\"success\":true}" }
        let(:response) { response_class.new("200", body) }

        context "and given a block" do
          it "returns with the customized response body" do
            expect(described_class.response_handler(response){|resp| resp[:results]}).to eq([1,2,3])
          end
        end

        context "and no block given" do
          let(:expected_error) { JSON.parse(body) }
          it "returns with the response body" do
            expect(described_class.response_handler(response)).to eq(expected_error)
          end
        end
      end

      context "when the response status is 401 UNAUTHORIZED" do
        let(:body)     { "{\"status_code\":7,\"status_message\":\"Invalid API key: You must be granted a valid key.\",\"success\":false}" }
        let(:response) { response_class.new("401", body) }
        let(:expected_error) { JSON.parse(body) }

        it "returns with error" do
          expect(described_class.response_handler(response)).to eq(expected_error)
        end
      end

      context "when the response status is 404 NOT FOUND" do
        let(:body)     { "{\"success\":false,\"status_code\":34,\"status_message\":\"The resource you requested could not be found.\"}" }
        let(:response) { response_class.new("404", body) }
        let(:expected_error) { JSON.parse(body) }

        it "returns with error" do
          expect(described_class.response_handler(response)).to eq(expected_error)
        end
      end

      context "when the response status is 4XY (Y is not 1 or 4)" do
        let(:body)     { "{\"errors\":[\"query must be provided\"]}" }
        let(:response) { response_class.new("422", body) }
        let(:expected_error) { {status_code: 422, status_message: "Errors: query must be provided", success: false} }

        it "returns with error" do
          expect(described_class.response_handler(response)).to eq(expected_error)
        end
      end
    end

    describe ".get" do
      context "when any error raises" do
        let(:expected_error) { { status_code: 500, status_message: "Something went wrong.", success: false } }

        before do
          allow(Net::HTTP).to receive(:get_response).and_raise("!!!BOOM!!!")
        end

        it "returns with 500 Internal Server Error" do
          expect(described_class.get).to eq(expected_error)
        end
      end
    end

    describe "When authenticated with API KEY" do
      before do
        allow(Rails.configuration).to receive(:tmdb_auth_type).and_return('api_key')
        allow(Rails.configuration).to receive(:tmdb_api_key).and_return('secret_api_key')
      end

      context ".url_with" do
        let(:expected_url) { "https://api.themoviedb.org/3/?api_key=secret_api_key" }

        it "returns the original url" do
          expect(described_class.url_with).to eq(expected_url)
        end

        it "returns the url with query params" do
          expect(described_class.url_with(query: "test")).to eq(expected_url)
        end
      end

      it ".headers" do
        expect(described_class.headers).to eq({'Content-Type' => 'application/json;charset=utf-8'})
      end

      it ".default_params" do
        expect(described_class.default_params).to eq({ "api_key" => "secret_api_key" })
      end

      it ".use_api_key?" do
        expect(described_class.use_api_key?).to eq(true)
      end

      context ".safe_params" do
        context "when params empty" do
          it "returns with the default params" do
            expect(described_class.safe_params).to eq({ "api_key" => "secret_api_key" })
          end
        end

        context "when api_key is overwritten" do
          it "returns with the new api_key params" do
            expect(described_class.safe_params(api_key: "test")).to eq({ "api_key" => "test" })
          end
        end

        context "when the params contains unpermitted params" do
          it "returns with the api_key params" do
            expect(described_class.safe_params(foo: :bar)).to eq({ "api_key" => "secret_api_key" })
          end
        end
      end
    end

    describe "When authenticated with Bearer Token" do
      before do
        allow(Rails.configuration).to receive(:tmdb_auth_type).and_return('bearer_token')
        allow(Rails.configuration).to receive(:tmdb_bearer_token).and_return('secret_token')
      end

      context ".url_with" do
        let(:expected_url) { "https://api.themoviedb.org/3/?" }

        it "returns the original url" do
          expect(described_class.url_with).to eq(expected_url)
        end

        it "returns the url with query params" do
          expect(described_class.url_with(query: "test")).to eq(expected_url)
        end
      end

      it ".headers" do
        headers = {
          'Content-Type' => 'application/json;charset=utf-8',
          'Authorization' => "Bearer secret_token"
        }

        expect(described_class.headers).to eq(headers)
      end

      it ".default_params" do
        expect(described_class.default_params).to eq({})
      end

      it ".use_api_key?" do
        expect(described_class.use_api_key?).to eq(false)
      end

      context ".safe_params" do
        context "when params empty" do
          it "returns with the default params" do
            expect(described_class.safe_params).to eq({})
          end
        end

        context "when api_key is overwritten" do
          it "returns with the new api_key params" do
            expect(described_class.safe_params(api_key: "test")).to eq({ "api_key" => "test" })
          end
        end

        context "when the params contains unpermitted params" do
          it "returns with the api_key params" do
            expect(described_class.safe_params(foo: :bar)).to eq({})
          end
        end
      end
    end
  end
end
