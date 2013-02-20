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
      if results = get("/lookup", :query => query)["results"]
        results[0]
      end
    end
  end
end
