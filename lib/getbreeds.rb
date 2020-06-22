require 'net/http'
require 'open-uri'
require 'json'
 
class GetBreeds < ActiveRecord::Base
 
  URL = "https://api.thedogapi.com/v1/breeds?attach_breed=0"
 
  def get_all_breeds 
    
    uri = URI.parse(URL)
    response = Net::HTTP.get_response(uri)
    response.body
  end

  def create_breeds
    everything = get_all_breeds
    all_breeds = JSON.parse(everything)
    all_breeds.each do |dog_hash|
    name = dog_hash["name"]
    life_span = dog_hash["life_span"]
    temperament = dog_hash["temperament"]
    Breed.find_or_create_by(name: name, life_span: life_span, temperament: temperament)

      end
  end
end

class GetFavs < ActiveRecord::Base 

  def create_favs
        

  
end






