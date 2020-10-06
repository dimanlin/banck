class Api::V1::CountriesController < ActionController::API
  def index
    render json: ISO3166::Country.all_translated('EN')
  end

  def get_sities
    cities = ISO3166::Country.find_country_by_name(params[:country_name]).states.map { |a| a.last.name }
    render json: cities
  end
end
