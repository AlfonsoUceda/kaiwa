class AddTypeToComments < ActiveRecord::Migration[8.0]
  def change
    add_column :comments, :comment_type, :string
  end
end
