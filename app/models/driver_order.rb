class DriverOrder < ApplicationRecord
    belongs_to :driver
    belongs_to :order
end