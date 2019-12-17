require 'uri'
require 'faraday'
require 'json'
module ApplicationHelper
    def user_edit_url
        if current_user.class.to_s == 'Student'
            edit_student_path(current_user)
        elsif current_user.class.to_s == 'Driver'
            edit_driver_path(current_user)
        else
            edit_manager_path(current_user)
        end
    end
    
    def parse content
        content += '。'
        content = URI::encode(content)
        rep = Faraday.get 'http://39.96.86.242:1314/'+content
        JSON.parse(rep.body)
    end
    
    def check_email_only email
        driver = Driver.find_by(email: email)
        student = Student.find_by(email: email)
        manager = Manager.find_by(email: email)
        
        driver.nil? and student.nil? and manager.nil?
    end
end
