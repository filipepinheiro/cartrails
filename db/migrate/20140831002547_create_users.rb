class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.date :birthdate
      t.string :address
      t.string :credit_card
      t.string :phone
      t.string :email
      t.string :password
      t.boolean :confirmed
      t.boolean :newsletter

      t.timestamps
    end
  end
end
