# == Schema Information
#
# Table name: media_finders
#
#  id                :bigint           not null, primary key
#  url               :string           not null
#  search_class_name :string           not null
#  search_params     :jsonb
#  view_count        :integer          default(0)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class MediaFinder < ApplicationRecord

  # VALIDATIONS

  validates :url, :search_class_name, presence: true

  # INSTANCE METHODS

  def search_and_create
    search_class = search_class_name.constantize
    response = search_class.get(search_params)
    if response[:success]
      { media: related_model.find_or_create_from_api(response[:results]), total_count: response[:total_results] }
    else
      { media: [], total_count: 0 }
    end
  end

  def related_model
    "Medium::#{search_class_name.demodulize}".constantize
  end

  def seen!
    increment!(:view_count)
  end
end
