class SubscribersController < ApplicationController
  def new
  	@subscriber = Subscriber.new
  end

  def create
  	@subscriber = Subscriber.new(params:subscriber_params)
  	if @subscriber.save
  		flash[:success] = "Merci !"
  		redirect_to root_path
  	else
  		redirect_to root_path
  	end
  end

  private

  def subscriber_params
  	params.permit(:name, :email)
  end

end
