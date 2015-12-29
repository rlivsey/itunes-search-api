require_relative 'spec_helper'

API_URL    = "https://itunes.apple.com"
SEARCH_URL = "#{API_URL}/search"
LOOKUP_URL = "#{API_URL}/lookup"

describe ITunesSearchAPI do
  describe ".search" do
    it "should perform a GET request to /search with the parameters passed" do
      stub_request(:get, /#{SEARCH_URL}.*/).to_return(:body => fixture("search-no-results.json"))
      ITunesSearchAPI.search(:term => "The Killers")
      WebMock.should have_requested(:get, SEARCH_URL).with(:query => {:term => "The Killers"})
    end

    it "should return an empty array if the search returns no results" do
      stub_request(:get, SEARCH_URL).with(:query => {:term => "The Killers"}).to_return(:body => fixture("search-no-results.json"))
      ITunesSearchAPI.search(:term => "The Killers").should be_empty
    end

    it "should return an array containing one result if the search returns one result" do
      stub_request(:get, SEARCH_URL).with(:query => {:term => "The Killers"}).to_return(:body => fixture("search-one-result.json"))
			ITunesSearchAPI.search(:term => "The Killers").size.should == 1
    end

    it "should return an array containing all the results if the search returns multiple results" do
      stub_request(:get, SEARCH_URL).with(:query => {:term => "The Killers"}).to_return(:body => fixture("search-many-results.json"))
      ITunesSearchAPI.search(:term => "The Killers").size.should == 2
    end
  end

  describe ".lookup" do
    it "should perform a GET request to /lookup with the parameters passed" do
      stub_request(:get, /#{LOOKUP_URL}.*/).to_return(:body => fixture("lookup-no-results.json"))
      ITunesSearchAPI.lookup(:id => "284910350")
      WebMock.should have_requested(:get, LOOKUP_URL).with(:query => {:id => "284910350"})
    end

    it "should return nil if the lookup returns no results" do
      stub_request(:get, LOOKUP_URL).with(:query => {:id => "284910350"}).to_return(:body => fixture("lookup-no-results.json"))
      ITunesSearchAPI.lookup(:id => "284910350").should be_empty
    end

    it "should return the result if the lookup returns a result" do
      stub_request(:get, LOOKUP_URL).with(:query => {:id => "284910350"}).to_return(:body => fixture("lookup-result.json"))
      result = ITunesSearchAPI.lookup(:id => "284910350")
      result.class.should eq(Array)
      result.first["artistName"].should == "Jack Johnson"
    end
  end
end
