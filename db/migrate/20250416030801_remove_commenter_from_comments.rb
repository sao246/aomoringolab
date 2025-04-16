class RemoveCommenterFromComments < ActiveRecord::Migration[6.1]
  def change
    remove_reference :comments, :commenter, polymorphic: true, null: false
  end
end
