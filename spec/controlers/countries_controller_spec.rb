require 'rails_helper'

describe Api::V1::CountriesController, type: :controller do
  describe 'index' do
    it 'should return list of countries' do
      get :index
      expect(JSON.parse(response.body).size).to eq(249)
    end
  end

  describe 'get_sities' do
    it 'should return list of cities for US' do
      get :get_sities, params: { country_name: 'United States' }
      expect(JSON.parse(response.body).size).to eq(60)
    end
  end
end