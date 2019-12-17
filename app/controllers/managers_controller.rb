class ManagersController < ApplicationController
  def show
    @user = Manager.find(params[:id])
  end
  
  def validate_driver
    @users = Driver.where(pass: false).all
    
  end
  
  def validate_student
    @users = Student.where(pass: false).all
  end
  
  def driver_pictures
    @user = Driver.find(params[:id])
    pp @user
    @head = @user.head
    @id_card = @user.id_card
    @license = @user.license
    @car = @user.car
  end
  def student_pictures
    @user = Student.find(params[:id])
    @head = @user.head
    @id_card = @user.id_card
    
  end
  def driver_pass
    @user = Driver.find(params[:id])
    @user.update_attribute(:pass,true)
    redirect_to root_url
  end
  def student_pass
    @user = Student.find(params[:id])
    @user.update_attribute(:pass,true)
    redirect_to root_url
  end
end
