class FriendshipsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user, only: [:create]
    before_action :set_friendship, only: [:destroy, :accept]
    
    def create
        #build our create friendship action using our previously created request_friendship method
        @friendship = current_user.request_friendship(@user)
        respond_to do |format|
            format.html {redirect_to users_path, notice: "Friendship Created"}
        end
    end

	def destroy
		@friendship.destroy
		respond_to do |format|
			format.html {redirect_to users_path, notice: "Friendship Deleted"}
		end
	end

	def accept
	    #create accept action which allows us to add the accept link to our users helper
		@friendship.accept_friendship
		
		#create activity in user feed to display accepted friendships
		@friendship.create_activity key: 'friendship.accepted', owner: @friendship.user, recipient: @friendship.friend
		@friendship.create_activity key: 'friendship.accepted', owner: @friendship.friend, recipient: @friendship.user
		
		respond_to do |format|
			format.html {redirect_to users_path, notice: "Friendship Accepted"}
		end
	end
    
    private
    
    def set_user
        @user = User.find(params[:user_id])
    end

	def set_friendship
		@friendship = Friendship.find(params[:id])
	end

end