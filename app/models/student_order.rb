class StudentOrder < ApplicationRecord
  belongs_to :student
  belongs_to :order
end
