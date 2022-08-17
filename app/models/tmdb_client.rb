require "net/http"

class TmdbClient

  URL         = "https://api.themoviedb.org"
  API_VERSION = 3

  class << self
    def url
      "#{URL}/#{API_VERSION}/#{path}"
    end

    def url_with params = {}
      "#{url}?#{safe_params(params).to_query}"
    end

    def get(params = {}, &block)
      url = url_with(params)
      Rails.logger.info("GET #{url}")
      response = Rails.cache.fetch(url) { Net::HTTP.get_response(URI(url), headers) }
      response_handler(response, &block)
    rescue => e
      Rails.logger.debug(e)
      { status_code: 500, status_message: "Something went wrong.", success: false }
    end

    def response_handler response
      body = JSON.parse(response.body).with_indifferent_access
      case response.code
      when "200"
        block_given? ? yield(body) : body
      when "401", "404"
        body
      else
        { status_code: response.code.to_i, status_message: "Errors: #{body.fetch(:errors, []).join(', ')}", success: false }
      end
    end

    def headers
      return {'Content-Type' => 'application/json;charset=utf-8'} if use_api_key?
      {
        'Content-Type' => 'application/json;charset=utf-8',
        'Authorization' => "Bearer #{Rails.configuration.tmdb_bearer_token}"
      }
    end

    def safe_params params = {}
      default_params.merge(params).slice(*permitted_params)
    end

    def use_api_key?
      Rails.configuration.tmdb_auth_type == "api_key"
    end

    # @override
    def default_params
      (use_api_key? ? { api_key: Rails.configuration.tmdb_api_key } : {}).with_indifferent_access
    end

    # @override
    def permitted_params
      [:api_key]
    end

    # @override
    def path
      ""
    end
  end
end
