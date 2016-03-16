class UsersController < ApplicationController
  def downgrade 
    current_user.update_attribute(:role, 'standard_user')
  end
end
