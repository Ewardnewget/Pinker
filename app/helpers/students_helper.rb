module StudentsHelper
  

  def find_order order
    @current_user.orders.find_by(id: order.id)
  end
  def can_join order
    find_order(order).nil?
  end
  def is_creator order
    so = StudentOrder.find_by(student_id: current_user.id , order_id: order.id)
    !so.nil? and so.is_creator?
  end
  def can_edit order
    is_creator(order) and order.cur_number < order.number
  end
  def can_delete order
    is_creator(order) and order.cur_number == 1
  end
  
  def can_quit order
    order.driver_id.nil? and !StudentOrder.find_by(student_id: current_user.id , order_id: order.id).nil?
  end
  
  def is_passed
    current_user.pass
  end
  
  def accepted order
    !order.driver_id.nil? 
  end
  
  def sex_present sex
    if sex == 0
      '男'
    else
      '女'
    end
  end
  def pass_present pass
    if pass
      '验证已通过'
    else
      '验证中...'
    end
  end
  def can_finished order
    !order.student_finished and !order.driver_id.nil? and is_creator order
  end
end
