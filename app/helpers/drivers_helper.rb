module DriversHelper
  def can_accept order
    order.driver_id.nil?
  end
  def is_passed
    current_user.pass
  end
  def dcan_finished order
    order.driver_id == current_user.id and !order.driver_finished
  end
end
