module UsersHelper
    #we now have the method to check the different friendships status.
    #We can now build a view helper that displays the respective action buttons according the friendship status. 
    #In this helper we'll make a method called action_buttons passing the other user as an argument.
    
    def action_buttons(user)
        #defines actions for buttons in ./app/views/users/_user.html.erb from methods in ./app/models/user.rb
		case current_user.friendship_status(user) when "friends"
			#Cancel friendship link
			link_to "Cancel Friendship", friendship_path(current_user.friendship_relation(user)), method: :delete
		when "pending"
			#Cancel Request link
			link_to "Cancel Request", friendship_path(current_user.friendship_relation(user)), method: :delete
		when "requested"
			#Accept or Deny looks at friendships_controller
			link_to "Accept", accept_friendship_path(current_user.friendship_relation(user)), method: :put
		when "not_friends"
			#looks at friendships resource in routes
			link_to "Add as Friend", friendships_path(user_id: user.id), method: :post
		end
	end
end
