class TmdbClient::Genre::Tv < TmdbClient
  class << self
    def path
      "genre/tv/list"
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
