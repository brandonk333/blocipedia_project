class ChargesController < ApplicationController
  DEFAULT_AMOUNT = 15_00


  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Blocipedia Premium Membership - #{current_user.email}",
      amount: DEFAULT_AMOUNT
    }
  end

  def create
    # Creates a Stripe Customer object, for associating with the charge
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )
 
    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: DEFAULT_AMOUNT,
      description: "Blocipedia Premium Membership - #{current_user.email}",
      currency: 'usd'
    )
    
    #current_user.update_attributes(role: 'premium_user', stripe_customer_id: customer_id , stripe_subscription_id: customer.subscriptions.first.id)
  
    flash[:notice] = "Thanks for subscribing, #{current_user.email}! Feel free to pay me again."
    redirect_to root_url
  end
 
  # Stripe will send back CardErrors, with friendly messages
  # when something goes wrong.
  # This `rescue block` catches and displays those errors.
  rescue Stripe::CardError => e
    flash.now[:alert] = e.message
    redirect_to new_charge_path
end





