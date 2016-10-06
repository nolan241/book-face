class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
    
    validates_presence_of :username
    validates_uniqueness_of :username
    has_many :posts, dependent: :destroy

    has_many :friendships, dependent: :destroy
    has_many :inverse_friendships, class_name: "Friendship", foreign_key: "friend_id", dependent: :destroy
    
    def request_friendship(user_2)
      self.friendships.create(friend: user_2)
    end
    
    def pending_friend_requests_to
      self.friendships.where(state: "pending")
    end

    def pending_friend_requests_from
      self.inverse_friendships.where(state: "pending")
    end    

    def active_friends
      self.friendships.where(state: "active").map(&:friend) + self.inverse_friendships.where(state: "active").map(&:user)
    end
    
    def friendship_status(user_2)
      #First we find the friendship where the user_id is either myself or the other user and where the friend_id, again, is either myself or the other user. 
      friendship = Friendship.where(user_id: [self.id,user_2.id], friend_id: [self.id,user_2.id])
      
      #Then, we must find out if we're friends or not.
      unless friendship.any? #define not friends. If you're not a friend, return "not friends" 
        return "not_friends"
      else #if you're friends then there's 3 possibilities.
        if friendship.first.state == "active" #You're accepted and active friends.

          else #friendship not active but is pending or requested
            if friendship.first.user == self #You're waiting approval from a friendship request you've made.
              return "pending"
            else #You a have pending friendship request from another user.
              return "requested"
            end
          end
        end
    end

    def friendship_relation(user_2)
      #finds the friendship relatinship for the destroy method for the friendship_controller
      Friendship.where(user_id: [self.id,user_2.id], friend_id: [self.id,user_2.id]).first
    end
    
end
