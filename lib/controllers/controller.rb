class Willave
    
    def intro
        Views.banner_willave
        Willave.greeting
    end

    def self.greeting
        yes_or_no = PROMPT.yes?("Are you a new user 🐶?".colorize(:blue))
        puts "\n" * 35
        if yes_or_no
            @@current_user = User.create_user
            Willave.main_menu
        else
            Willave.login
            Willave.main_menu
        end
    end

    def self.login
        Views.banner_willave
        login_or_exit = PROMPT.select("", %w(Login Exit Back))
        case login_or_exit
        when "Login"
            self.find_user
            self.enter_password
        when "Exit"
            sleep(3)
            exit   
        else "Back"  
        Willave.greeting
                
        end       
    end

    def self.find_user
        Views.banner_willave
        # puts "\n" * 35
        find_user = PROMPT.ask("What is your username?", default: 'Type in your username', required: true)
        @@current_user = User.find_by(name: find_user)
        if @@current_user == nil
            puts "User not found"
            puts "Please try again!"
            self.login
        end
    end

    def self.enter_password
        Views.banner_willave
        # dog_emoji = PROMPT.decorate('')
        enter_password = PROMPT.mask('password:', echo: true, required: true)
        if enter_password == @@current_user.password
            @@current_user
        else
            puts "\n" * 35
            puts "Woof Woof... That was an incorrect response."
            puts "Please try again!"
            self.enter_password
        end

    end


    def self.main_menu
        Views.banner_willave   
        print "Welcome to Willave" 
        selection = PROMPT.select("Please make a selection", %w(RandomDogBreeds MyFavs SearchByBreeds EditMyInfo))
    case selection
        when "RandomDogBreeds"
        Willave.random_breed
        when "SearchByBreeds"
        Willave.search_breeds
        when "MyFavs"
            Favorite.my_favs
        else "EditMyInfo"
        Willave.edit_my_info    
        end
    end

    def self.random_breed
        #add a banner
        #need to make table bigger
        #need to remove "would you like..."
        random = Breed.all
        @return_breed = random.sample(random: Random.new)
        print tp @return_breed
        self.another_random
    end

    def self.another_random
        #add a banner
        puts "\n" * 10   
        second_random = PROMPT.select("Would you like to view another random breed?", %w(Yes FavBreed MainMenu))
        case second_random 
        when "Yes"
            Willave.random_breed
        when "FavBreed"
            Favorite.save_fav
        when "MainMenu"
            self.main_menu 
        end 
    end

    def self.search_breeds
        Views.banner_willave 
        search = PROMPT.select("What would you like to search by?", %w(BreedNames Temperament LifeSpan Back))
    case search
        when "BreedNames"
            self.all_b
        when "Temperament"
            self.breed_temp
        when "lifeSpan"
            self.breed_life_span
        else "Back"
            self.main_menu
        end
    end

    def self.all_b
        # @name = PROMPT.ask("Type in the number of the breed you want to see!", required: true)
        # please = Breed.all.select(:id, :name, :temperament, :life_span).map { |id, name, temperament, life_span| { id: id, name: name, temperament: temperament, life_span: life_span } }
        # print tp pray
        
        puts "\n" * 15
        Breed.all.map.with_index do |breed, index|
        list =  "#{index + 1}. #{breed.name}"
        print tp list
        Willave.users_selection
        end
    end

    def users_selection
    @breed = PROMPT.ask("Enter the number of the breed you would like to leaarn more about!", default: "Enter # here...")
    end

    #  breed_temp
    #     # I want to find the breed the user selected in the database and return it to terminal
    #     Breed.all.find_by
    #     all_temp = Breed.all.pluck("name", "Temperament")
    

    #print "Nice! You Favorited a "#{@names}"! Would you like to see all of your favorite breeds?"
    
    def self.edit_my_info
        puts "\n" * 35
        pick_an_edit = PROMPT.select("Change Username or Password?", %w(Username Password Back))
        case pick_an_edit
           when "Username"
                self.change_username
                Willave.main_menu
           when "Password"
                self.change_password
                puts "Your password was successfully changed"
                Willave.main_menu
           else "Back"
            Willave.main_menu
        end
    end

    def self.change_username
        given_username = PROMPT.ask("Alright #{@@current_user.name}, what do you want your new User Name to be?", required: true)
        confirm_username = PROMPT.yes?("#{given_username} is what you entered. Are you sure?") do |q|
                q.suffix 'Y/N'
        end
        if confirm_username
            if User.find_by(name: given_username) == nil 
                @@current_user.name = nil   
                @@current_user.name = given_username
                @@current_user.save
            else
                puts "#{given_username} is already taken. Please choose a different username."
                self.change_username
            end
        else 
            self.edit_my_info
        end
    end

    def self.change_password
        old_password = PROMPT.mask("Please enter your old password", required: true)
        if old_password == @@current_user.password
            new_password = PROMPT.mask("Please enter your new password", required: true) do |q|
            q.validate(/^(?=.*[a-zA-Z])(?=.*[0-9]).{6,}$/)
            q.messages[:valid?] = 'Your passowrd must be at least 6 characters and include one number and one letter'
          end        
            confirm_password = PROMPT.mask("Please confirm your new password", required: true)
            if new_password == confirm_password
                puts "\n" * 35
                @@current_user.password = nil
                @@current_user.password = new_password
            else
                puts "\n" * 35
                puts "Grrrrr...Those didn't match. Please try again!"
                self.change_password
            end
        else
            puts "Grrrrr...That was not right."
            puts "Please try again"
            self.change_password
        end
    end

    def create_fav


    end
 
    def self.save_fav

        attr_reader :user_id

        @@current_user = []

        if current_user.exists? == true
        fav = Favorite.find_or_create_by(user: @current_user.id, breed_id: @breed.id).push
        
        
            
        end
    end
    
        
    def destroy
        # breed = Breed.find(params[:breed_id])
        # @favorite = @@current_user.favorites.find(params[:id])
    
  end
 
  def my_favs
    
  end
    

    

end
















