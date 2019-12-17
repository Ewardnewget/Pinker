class OrdersController < ApplicationController
  def new
    @order = Order.new
  end
  def create
    @order = Order.new(order_params)
    if @user.save
      flash[:success] = "Success create order!"
      redirect_to root_url
    else
      render 'error'
    end
  end
  def order_params
    params.require(:order).permit(
      :number, :time, :destination
      )
  end
  
end