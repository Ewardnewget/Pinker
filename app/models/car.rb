class Car < ApplicationRecord
  belongs_to :driver
  validates :number,presence: true,length:{maximum:10}
  validates :person_number, presence: true,length:{minimum:0}
  
  
  
end
