class AddFilesToUsers < ActiveRecord::Migration
  def change
    add_column :designers, :file_1, :string
    add_column :designers, :file_2, :string
    add_column :designers, :file_3, :string
  end
end
