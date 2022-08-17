class TmdbClient::Genre::Movie < TmdbClient
  class << self
    def path
      "genre/movie/list"
    end

    def all(params = {})
      get(params) do |response_body|
        response_body[:genres]
      end
    end

    def default_params
      super.merge(language: "en-US")
    end

    def permitted_params
      super << :language
    end
  end
end

