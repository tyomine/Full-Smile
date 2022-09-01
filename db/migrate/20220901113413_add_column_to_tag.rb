class AddColumnToTag < ActiveRecord::Migration[6.1]
  def change
    add_reference :tags, :post, foreign_key: true
  end
end
