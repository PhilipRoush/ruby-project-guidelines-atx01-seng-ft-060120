class Breed < ActiveRecord::Base
   has_many :favorites
   has_many :users, through: :favorites

    
      
end


# Breed.all.map.with_index do |breed, index|
#    print "#{index + 1}. #{breed.name}"

# Breed.all.find_or_create_by(name: "#{@names}") 
#    print "#{@names}"