ActiveAdmin.register Designer do

  index do 
    selectable_column
    column :id
    column :firstname
    column :lastname
    column :email
    column :city
    column :country
    column :phone_number
    column :comment
    column :website_url
    column :created_at
    column :file_1 do |designer|
      link_to "File", designer.file_1.url
    end
    column :file_2 do |designer|
      link_to "File", designer.file_2.url
    end
    column :file_3 do |designer|
      link_to "File", designer.file_3.url
    end
    actions
  end

end
