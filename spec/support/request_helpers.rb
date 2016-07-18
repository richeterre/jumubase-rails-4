module Requests
  module JSONHelpers
    def json
      JSON.parse(response.body)
    end
  end
end

RSpec.configure do |config|
  config.include Requests::JSONHelpers, type: :request
end
