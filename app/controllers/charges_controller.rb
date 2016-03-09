class ChargesController < ApplicationController
    
def create
  # Creates a Stripe Customer object, for associating with the charge
  customer = Stripe::Customer.create(
    email: current_user.email,
    card: params[:stripeToken]
  )
 
  charge = Stripe::Charge.create(
    customer: customer.id,
    amount: Amount.default,
    description: "Blocipedia Premium Membership - #{current_user.email}",
    currency: 'usd'
    )
  
  flash[:notice] = "Thanks for subscribing, #{current_user.email}! Feel free to pay me again."
  redirect_to user_path(current_user) # or wherever
end
 
# Stripe will send back CardErrors, with friendly messages
# when something goes wrong.
# This `rescue block` catches and displays those errors.
rescue Stripe::CardError => e
  flash.now[:alert] = e.message
  redirect_to new_charge_path
end

def new
  @stripe_btn_data = {
    key: "#{ Rails.configuration.stripe[:publishable_key] }",
    description: "Blocipedia Premium Membership - #{current_user.name}",
    amount: Amount.default
  }
end

class Amount
  def default
    self.amount = 15_00
  end  
end



