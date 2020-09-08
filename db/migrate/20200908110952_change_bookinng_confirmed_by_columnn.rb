class ChangeBookinngConfirmedByColumnn < ActiveRecord::Migration[6.0]
  def change
    rename_column :bookings, :confirmed_by, :confirmed_by_id
  end
end
