class UsersController < ApplicationController
  
  before_action :authenticate_user!, only:[:index]
    #require user to be signed in to view index
  
  before_action :set_user, only:[:show]
  
  def index
    case params[:people] 
      when "friends"
        #If the url is ->  localhost:3000/users?friends  it will display your friends.
        @users = current_user.active_friends
      
      when "requests"
        #If the url is ->  localhost:3000/users?requests  it will display your requests.
        @users = current_user.pending_friend_requests_from.map(&:friend)
      
      when "pending"
        #If the url is ->  localhost:3000/users?pending  it will display the request that are pending for your approval.
        @users = current_user.pending_friend_requests_to.map(&:friend)
      
      else
        #all users except for the current user
        @users = User.where.not(id: current_user.id)
    end
  end
  
  def show
    #create new post on users/show.html.erb
    @post = Post.new
    #display previously created posts on the users/show.html.erb page
    @posts = @user.posts.order('created_at DESC')
    
    #shows activities 
     @activities = PublicActivity::Activity.where(owner_id: @user.id).order('created_at DESC')

  end
  
  private
  
  def set_user
    @user = User.find_by(username: params[:id])
  end
  
end
