class TmdbClient::Search::Tv < TmdbClient
  class << self
    def path
      "search/tv"
    end

    def default_params
      super.merge(language: "en-US", page: 1, include_adult: false)
    end

    def permitted_params
      super + [ :language, :page, :include_adult, :query, :first_air_date_year]
    end
  end
end
