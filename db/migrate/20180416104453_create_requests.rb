class CreateRequests < ActiveRecord::Migration[5.2]
  def up
    create_table :requests do |t|
      t.integer :reason
      t.string  :status, default: 'PENDING', :limit => 15
      t.integer :user_id

      t.timestamps null: false
    end
  end

  def down
    drop_table :requests
  end
end
