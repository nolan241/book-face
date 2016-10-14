class UsersController < ApplicationController
  
  before_action :authenticate_user!, only:[:index]
  before_action :set_user, only:[:show]
  before_action :get_counts, only: [:index]
  
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
  
  # should be able to see a counter over the links on the People's page displaying how many requests we have pending in each one.
  def get_counts
    #1 - @friend_count -> gets the number of current friends you have.
    @friend_count = current_user.active_friends.size
    
    #2 - @pending_count -> gets the number of pending friend requests you have.
    @pending_count = current_user.pending_friend_requests_to.map(&:friend).size
  end

  def set_user
    @user = User.find_by(username: params[:id])
  end
  
end
