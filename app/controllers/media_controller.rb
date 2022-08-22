class MediaController < ApplicationController
  before_action :set_media_type, only: [:index]

  def index
    model = "Medium::#{params[:media_type]}".constantize
    response = model.search_and_create(search_params)

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
