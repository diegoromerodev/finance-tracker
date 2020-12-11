class User < ApplicationRecord
  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  has_many :friendships
  has_many :friends, through: :friendships
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable



   def no_tracking_limit?
   	stocks.count < 10	
   end

   def already_tracking?(ticker_symbol)
   	stock = Stock.find_existing(ticker_symbol)
   	return false unless stock
   	stocks.where(id: stock.id).exists?
   end

   def can_track?(ticker_symbol)
   	no_tracking_limit? && !already_tracking?(ticker_symbol)
   end

   def full_name
   	return "#{first_name} #{last_name}" if first_name || last_name
   	"Anonymous"
   end

   def self.search(param)
    param.strip!
    results = (first_name_search(param) + last_name_search(param) + email_search(param)).uniq
    return nil unless results
    results
   end

   def self.first_name_search(param)
     matches("first_name", param)
   end

   def self.last_name_search(param)
     matches("last_name", param)
   end

   def self.email_search(param)
     matches("email", param)
   end

   def self.matches(field_name, param)
     where("#{field_name} like ?", "%#{param}%")
   end

   def except_current(users)
    users.reject { |user| user.id == self.id }
   end

   def not_friends_with(friend_ide)
     !self.friends.where(id: friend_ide).exists?
   end

end
