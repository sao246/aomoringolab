class RemovePolymorphicFromComments < ActiveRecord::Migration[6.1]
  def change
    remove_column :comments, :commenter_type, :string
    remove_column :comments, :commenter_id, :integer
  end
end
