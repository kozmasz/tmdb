require 'singleton'

class Configuration
  include Singleton

  attr_accessor :data

  def initialize
    @data = TmdbClient::Config.get.with_indifferent_access
  end

  def base_image_url
    data[:images][:base_url]
  end

  def secure_base_image_url
    data[:images][:secure_base_url]
  end

  def backdrop_sizes
    data[:images][:backdrop_sizes]
  end

  def logo_sizes
    data[:images][:logo_sizes]
  end

  def poster_sizes
    data[:images][:poster_sizes]
  end

  def profile_sizes
    data[:images][:profile_sizes]
  end

  def still_sizes
    data[:images][:still_sizes]
  end
end
