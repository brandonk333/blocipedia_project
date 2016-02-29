class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :wikis
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  after_initialize :set_role
  
  def admin?
    role == "admin"
  end
  
  def standard_user?
    role == "standard_user"
  end
  
  def premium_user?
    role == "premium_user"
  end
  
  def set_role
    self.role ||= 'standard_user'  
  end
end
