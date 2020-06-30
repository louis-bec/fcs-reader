class CreateFcsFiles < ActiveRecord::Migration[6.0]
  def change
    create_table :fcs_files do |t|
      t.string :name
      t.string :attachment

      t.timestamps
    end
  end
end
