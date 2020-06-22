class Favorite < ActiveRecord::Base
    belongs_to :breed
    belongs_to :user




    def favorite(user, breed)
        arguments = Twitter::Arguments.new(args)
        pmap(arguments) do |tweet|
          begin
            perform_post_with_object('/1.1/favorites/create.json', arguments.options.merge(id: extract_id(tweet)), Twitter::Tweet)
          rescue Twitter::Error::AlreadyFavorited, Twitter::Error::NotFound
            next
          end
        end.compact
      end






end