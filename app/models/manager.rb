class Manager < ApplicationRecord
    before_save {self.email = self.email.downcase}
    validates :name,presence: true,length:{maximum:50}
    validates :sex, presence: true, length:{is:1}
    validates :phone, presence: true,length:{is:11}
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email,presence: true,length:{maximum:255},format:{ with: VALID_EMAIL_REGEX }, uniqueness:{case_sensitive: false}
    
    validates :password, presence:true, length: { minimum: 6 }
    has_secure_password
end
