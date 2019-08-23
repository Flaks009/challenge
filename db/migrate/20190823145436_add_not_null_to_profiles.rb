class AddNotNullToProfiles < ActiveRecord::Migration[6.0]
  def change
    change_column_null :profiles, :name, false
  end
end
