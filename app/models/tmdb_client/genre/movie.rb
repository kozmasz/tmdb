class TmdbClient::Genre::Movie < TmdbClient
  class << self
    def path
      "genre/movie/list"
    end

    def all(params = {})
      get(params)[:genres]
    end

    def default_params
      super.merge(language: "en-US")
    end

    def permitted_params
      super << :language
    end
  end
end

