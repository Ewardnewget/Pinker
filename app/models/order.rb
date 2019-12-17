class Order < ApplicationRecord
  has_many :student_orders
  has_many :students, :through => :student_orders
  belongs_to :driver, :optional => true
  
  
  def self.search(datetime, destination)
    if search
      find(:all, conditions: ['time < #{datetime}', 'destination = #{destination}'])
    else
      find(:all)
    end
  end
  
  validates :number,presence: true,length:{minimum:0}
  validates :cur_number, presence: true, length:{minimum:0}
  validates :destination,presence: true, length:{maximum:50}
  
end
