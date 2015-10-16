class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :user_teams, dependent: :destroy
  has_many :teams, through: :user_teams

  scope :players, -> {where(is_admin: false)}

  private
  def email_required?
    false
  end 
  def password_required?
    !new_record? ? super : false
  end  
end
