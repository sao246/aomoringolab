class AddCommenterToComments2 < ActiveRecord::Migration[6.1]
  def change
    add_reference :comments, :commenter, polymorphic: true, null: false
  end
end
