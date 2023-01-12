require "spec_helper"
require "rack/test"
require_relative '../../app'

RSpec.describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }


  context "GET /artists" do 
    it 'returns a list of artists' do 
      response = get("/artists", names: "Pixies, ABBA, Taylor Swift, Nina Simone")

      expect(response.status).to eq(200)
      expect(response.body).to eq "Pixies, ABBA, Taylor Swift, Nina Simone"
    end
  end  
  context 'POST /artists' do 
    it 'creates new artist' do 
      response = post('/artists',
      name: 'Wild nothing',
      genre: 'Indie' 
      )

      
      expect(response.status).to eq(200)

      response = get('/artists')

      expect(response.body).to include('Wild nothing')
    end
  end 
end 