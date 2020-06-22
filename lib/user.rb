class User < ActiveRecord::Base
    has_many :favorites
    has_many :breeds, through: :favorites

     

    def self.create_user
        Views.banner_willave
        new_user = User.get_name
        new_user.password = User.set_password
        new_user.save
        new_user
    end

    def self.get_name
        given_name = PROMPT.ask("What do you want your new User Name to be?", required: true)
        confirm_name = PROMPT.yes?("#{given_name} is what you entered. Are you sure?") do |q|
          q.suffix 'Y/N'
        end
        if confirm_name
           if User.find_by(name: given_name) == nil
                User.create(name: given_name)           
            else
                puts "#{given_name} is already taken. Please choose a different name."
                 self.get_name 
            end
        else exit
            self.get_name
        end
    end

    def self.set_password
        given_password = PROMPT.mask("Please enter your password", required: true) do |q|
        q.validate(/^(?=.*[a-zA-Z])(?=.*[0-9]).{6,}$/)
        q.messages[:valid?] = 'Your password must be at least 6 characters and include one number and one letter'
      end        
        confirm_password = PROMPT.mask("Please confirm password", required: true)
        if given_password == confirm_password
            puts "\n" * 35
            given_password
        else
            puts "\n" * 35
            puts "Those didn't match. Please try again!"
            self.set_password
        end
    end 



    
   
    end
    