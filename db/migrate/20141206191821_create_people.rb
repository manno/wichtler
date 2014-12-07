class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name
      t.string :email
      t.string :state, default: 'new'
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
