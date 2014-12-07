class CreateSecretSantas < ActiveRecord::Migration
  def change
    create_table :secret_santas do |t|
      t.integer :santa_id
      t.integer :receiver_id

      t.timestamps
    end
  end
end
