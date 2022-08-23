class MediaController < ApplicationController
  before_action :set_media_type, only: [:index]

  def index
    search_class_name = "TmdbClient::Search::#{params[:media_type]}"
    search_class      = search_class_name.constantize
    url               = search_class.url_with(search_params)
    media_finder      = MediaFinder.create_with(url: url, search_class_name: search_class_name, search_params: search_params)
                                   .find_or_create_by!(url: url)
    media_finder.seen!
    response = media_finder.search_and_create

    @media = Kaminari.paginate_array(response[:media], total_count: response[:total_count]).page(permitted_params[:page])
  end

  private
  def permitted_params
    params.permit(:query, :page, :media_type, :search)
  end

  def search_params
    permitted_params.slice(:query, :page)
  end

  def set_media_type
    params[:media_type] ||= "Movie"
  end
end
