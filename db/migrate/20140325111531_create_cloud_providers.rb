class CreateCloudProviders < ActiveRecord::Migration
  def change
    create_table :cloud_providers do |t|
      t.string :name
      t.string :credentials_path
      t.string :ssh_key_path

      t.timestamps
    end
  end
end
