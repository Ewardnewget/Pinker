require 'date'
class IndexController < ApplicationController
  
  
  def index
    user = current_user.class.to_s
    time = Time.now
    @orders = nil
    if user == 'Student' or user == 'NilClass'
      @orders = Order.paginate(:page=>params[:page],:per_page=>5).where("cur_number != number and time >= \'#{time}\'")
    elsif user == 'Driver'
      @orders = Order.paginate(:page=>params[:page],:per_page=>5).where(driver_id: nil).where("cur_number = number  and time >= \'#{time}\'")
    elsif user == 'Manager'
      @orders = Order.paginate(:page=>params[:page],:per_page=>5).where("time >=\' #{time}\'")
    else
      flash[:danger] = @orders.errors.full_messages.first
      redirect_to root_url
    end
    @key = Search.new
    @content = NlpSearch.new
    @orders = search @orders
    @controller = 'index'
    @action = 'index'
   
    
  end
  def search_params
    params.require(:search).permit(
      :time,:destination
      )
  end
  def search_empty?
    params[:search].nil? or ( params[:search][:time].empty? and params[:search][:destination].empty?)
  end
  def nlp_search_params
    params.require(:nlp_search).permit(
      :content
      )
  end
  def nlp_search_empty?
    params[:nlp_search].nil? or (params[:nlp_search][:content].empty?)
  end
  def new
  end
  def orders
   
  end
end
