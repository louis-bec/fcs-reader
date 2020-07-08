class CreateS3Files < ActiveRecord::Migration[6.0]
  def change
    create_table :s3_files do |t|
      t.string :name
      t.string :url

      t.timestamps
    end
  end
end
