require 'httparty'

class ITunesSearchAPI
  include HTTParty
  base_uri 'http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/wa'
  format :json

  class << self
    def search(query={})
      get("/wsSearch", :query => query)["results"]
    end

    def lookup(query={})
      if results = get("/wsLookup", :query => query)["results"]
        results[0]
      end
    end
  end
end