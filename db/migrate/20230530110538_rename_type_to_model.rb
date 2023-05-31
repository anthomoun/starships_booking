class RenameTypeToModel < ActiveRecord::Migration[7.0]
  def change
    rename_column :starships, :type, :starship_type
  end
end
