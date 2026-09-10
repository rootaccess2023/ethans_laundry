class CardsController < ApplicationController
  def show
    @customer = Customer.find_by!(public_token: params[:token])
    @card = @customer.active_card
  end
end
