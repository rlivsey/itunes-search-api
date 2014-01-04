require 'httparty'

class ITunesSearchAPI
  include HTTParty
  base_uri 'https://itunes.apple.com'
  format :json

  class << self
    def search(query={})
      get("/search", :query => query)["results"]
    end

    def lookup(query={})
      get("/lookup", :query => query)["results"]
    end
  end
end
