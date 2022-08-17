class TmdbClient::Search::Movie < TmdbClient
  class << self
    def path
      "search/movie"
    end

    def where(params = {})
      get(params) do |response_body|
        response_body
      end
    end

    def default_params
      super.merge(language: "en-US", page: 1, include_adult: false)
    end

    def permitted_params
      super + [ :language, :page, :include_adult, :query, :region, :year, :primary_release_year ]
    end
  end
end
