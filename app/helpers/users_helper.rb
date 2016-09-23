module UsersHelper
    #we now have the method to check the different friendships status.
    #We can now build a view helper that displays the respective action buttons according the friendship status. 
    #In this helper we'll make a method called action_buttons passing the other user as an argument.
    
    def action_buttons(user)
        #defines actions for buttons in ./app/views/users/_user.html.erb from methods in ./app/models/user.rb
		case current_user.friendship_status(user) when "friends"
			"Remove Friendship"
		when "pending"
			"Cancel Request"
		when "requested"
			"Accept or Deny"
		when "not_friends"
			"Add as a Friend"
		end
	end
end
