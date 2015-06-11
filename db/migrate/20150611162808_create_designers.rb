class CreateDesigners < ActiveRecord::Migration
  def change
    create_table :designers do |t|
      t.string :firstname
      t.string :lastname
      t.string :email
      t.string :city
      t.string :country
      t.string :phone_number
      t.text :comment
      t.string :website_url

      t.timestamps
    end
  end
end
