# frozen_string_literal: true

class AddColmnToReports < ActiveRecord::Migration[6.1]
  def change
    add_column :reports, :is_checked, :boolean, null: false, default: false
  end
end
