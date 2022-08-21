class MediaController < ApplicationController
  def index
    response = TmdbClient::Search::Movie.get(query: "casino", page: params[:page])

    if response[:success]
      media = Medium::Movie.find_or_create_from_api(response[:results])
      @media = Kaminari.paginate_array(media, total_count: response[:total_results]).page(params[:page])
    else

    end
  end
end
