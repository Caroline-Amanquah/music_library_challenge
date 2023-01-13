require "spec_helper"
require "rack/test"
require_relative '../../app'

def reset_music_library_test
  artist_sql = File.read('spec/seeds/artists_seeds.sql')
  album_sql = File.read('spec/seeds/albums_seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
  connection.exec(artist_sql)
  connection.exec(album_sql)
end


RSpec.describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  before(:each) do 
    reset_music_library_test
  end


  context "GET /artists" do 
    it 'returns a list of artists' do 
      response = get("/artists")

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
      expect(response.body).to eq('')

      response = get('/artists')

      expect(response.body).to include("Wild nothing")
    end
  end  
end
