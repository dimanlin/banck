module Core
  def self.account_information
    url = ENV['CORE_API_DOMAIN'] + '/api/v1/account'
    RestClient.get(url, headers={'Authorization' => "core #{ENV['CORE_API_KEY']}"})
  end
end