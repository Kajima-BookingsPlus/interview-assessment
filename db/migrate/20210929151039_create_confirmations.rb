class CreateConfirmations < ActiveRecord::Migration[6.0]
  def change
    create_table :confirmations do |t|
      t.references :booking, null: false, foreign_key: true
      t.boolean :send_confirmation_msg
      t.string :type

      t.timestamps
    end
  end
end
