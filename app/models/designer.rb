require 'file_size_validator'
class Designer < ActiveRecord::Base
  mount_uploader :file_1, FileUploader
  mount_uploader :file_2, FileUploader
  mount_uploader :file_3, FileUploader
  validates :file_1, 
    :presence => true, 
    :file_size => { 
      :maximum => 80.megabytes.to_i 
    } 
  validates :file_2, 
    :presence => true, 
    :file_size => { 
      :maximum => 80.megabytes.to_i 
    } 
  validates :file_3, 
    :presence => true, 
    :file_size => { 
      :maximum => 80.megabytes.to_i 
    } 
end