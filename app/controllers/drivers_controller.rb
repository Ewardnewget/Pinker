class DriversController < ApplicationController
 # before_action :logged_in_user, only: [:index ,:edit, :update]
 # before_action :correct_user,   only: [:edit, :update]
  def index
  end
  
  def show
    @user = Driver.find(params[:id])
    @head = @user.head
    @id_card = @user.id_card
    @license = @user.license
    @car = @user.car
  end
  def new
    @user = Driver.new
  end
  def edit
    @user = Driver.find(current_user.id)
    @head = @user.head
    @id_card = @user.id_card
    @license = @user.license
    @car = @user.car
  end
  
  def update
    @user = Driver.find(params[:id])
    @user.update_attribute(:name, params[:driver][:name])
    @user.update_attribute(:sex, params[:driver][:sex])
    @user.update_attribute(:phone, params[:driver][:phone])
    Car.create(number: "xxxxxx",person_number: 0, driver_id:@user.id, picture: "cars/example.png")
    flash[:success] = '成功更新个人信息'
    redirect_to root_url
  end
  def update_carinfo
    @user = Driver.find(params[:id])
    @user.car.update_attribute(:number, params[:car][:number])
    @user.car.update_attribute(:person_number, params[:car][:person_number])
    flash[:success] = '成功更新车辆信息'
    redirect_to root_url
  end
  def update_head
    if params[:file].nil?
      return 
    end
    head = params[:file][:head]
    path = uploadHead(head)
    current_user.update_attribute(:head, path)
    flash[:success] = "成功上传头像"
    redirect_to root_url
  end
  
  def update_idcard
    if params[:file].nil?
      return
    end
    idcard = params[:file][:id_card]
    path =  uploadIdCard(idcard)
    current_user.update_attribute(:id_card, path)
    flash[:success] = "成功上传身份证"
    redirect_to root_url
  end
  
  def update_carlicense
    if params[:file].nil?
      return
    end
    carlicense = params[:file][:license]
    path = uploadLicense(carlicense)
    current_user.update_attribute(:license,path)
    flash[:success] = "成功上传驾照"
    redirect_to root_url
  end
  def update_carpicture
    if params[:file].nil?
      return
    end
    carpicture = params[:file][:carpicture]
    path = uploadCarPicture(carpicture)
    current_user.car.update_attribute(:picture,path)
    flash[:success] = "成功上传车辆图片"
    redirect_to root_url
  end
  
  def uploadHead(head)
    filename = current_user.email + '.' + head.original_filename.split('.')[-1]
    path = Rails.root.join('public',  'upload','driver','head', filename)
    File.open(path, 'wb') do |file|
      file.write head.read
    end
    "/upload/driver/head/"+filename
  end
  
  def uploadIdCard(head)
    filename = current_user.email + '.' + head.original_filename.split('.')[-1]
    filepath = Rails.root.join('public', 'upload','driver','id_card', filename)
    
    File.open(filepath, 'wb') do |file|
      file.write head.read
    end
    "/upload/driver/id_card/"+filename
  end
  
  def uploadLicense(head)
    filename = current_user.email + '.' + head.original_filename.split('.')[-1]
    filepath = Rails.root.join('public', 'upload','driver','license', filename)
    
    File.open(filepath, 'wb') do |file|
      file.write head.read
    end
    "/upload/driver/license/"+filename
  end
  
  def uploadCarPicture(head)
    filename = current_user.email + '.' + head.original_filename.split('.')[-1]
    filepath = Rails.root.join('public', 'upload','driver','car', filename)

    
    File.open(filepath, 'wb') do |file|
      file.write head.read
    end
    "/upload/driver/car/"+filename
  end
  
  def create
    param = driver_params
    
    @user = Driver.new(param)
    if !check_email_only(param[:email])
      flash[:danger] = "该邮箱已注册"
      redirect_to action: 'new'
      return 
    end
    @user[:pass] = false
    @user[:id_card] = @@driver_id_card_default
    @user[:license] = @@driver_license_default
    @user[:head] = @@driver_head_default
    
    if @user.save
      Car.create(number: "xxxxxx",person_number: 0, driver_id: @user.id, picture: "cars/example.png")
      flash[:success] = "成功注册"
      log_in @user
      redirect_to root_url
    else
      flash[:danger] = @user.errors.full_messages.first
      redirect_to action: 'new'
    end
  end
  
  def driver_params
    params.require(:driver).permit(:name,:sex,:phone,:password,
      :email,:password_confirmation,:bond)
  end
  
  def take_order
    @order = Order.find(params[:id])
    @order.update_attribute(:driver_id, current_user.id)
    flash[:success] = '成功接单'
    redirect_to root_url
  end
  
  def accept_orders
    @key = Search.new
     @content = NlpSearch.new
    @controller = 'drivers'
    @action = 'taken_order'
    @orders = current_user.orders.where(driver_finished: false).paginate(page: params[:page],per_page: 5)
    @orders = search @orders
    
  end
  
  def finished_orders
    @key = Search.new
     @content = NlpSearch.new
    @controller = 'drivers'
    @action = 'finished_order'
    @orders = current_user.orders.where(driver_finished: true,student_finished:false).paginate(page: params[:page],per_page: 5)
    @orders = search @orders
    
  end
  
  def history_orders
    @key = Search.new
     @content = NlpSearch.new
    @controller = 'drivers'
    @action = 'history_orders'
    @orders = current_user.orders.where(driver_finished: true,student_finished:true).paginate(page: params[:page],per_page: 5)
    @orders = search @orders
  end
  def order_params
    params.require(:order).permit(
      :number, :time, :destination
      )
  end
  
  def finish_order
    @order = Order.find(params[:id])
    @order.update_attribute(:driver_finished,true)
    flash[:success] = "成功完成！"
    redirect_to root_url
  end 
  
  
  def logged_in_user
      unless logged_in?
        flash[:danger] = "请登录！"
        redirect_to login_url
      end
  end
  
  def correct_user
      @user = Driver.find(params[:id])
      redirect_to(root_url) unless @user == current_user
  end
  
  def student_info
    sos = StudentOrder.where(order_id: params[:id], is_creator: true).first
    if sos.nil?
      flash[:danger] = "找不到该用户"
      redirect_to root_url
      return
    end
    @user = Student.find(sos.student_id)
    
  end
  
end
