require 'httpclient'

class ITunesSearchAPI
  class << self
    def search(query={})
      JSON.parse(HTTPClient.new.get("https://itunes.apple.com/search", :query => query).body)["results"]
    end

    def lookup(query={})
      JSON.parse(HTTPClient.new.get("https://itunes.apple.com/lookup", :query => query).body)["results"]
    end
  end
end
