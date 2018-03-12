class CreateTransfers < ActiveRecord::Migration[5.0]
  def change
    create_table :transfers do |t|
      t.integer   :user_id
      t.string    :from
      t.bigint    :amount
      t.integer   :target_id
      t.string    :to
      t.string    :signature
      t.integer   :nonce
      t.bigint    :fee
      t.string    :token_contract

      t.timestamps
    end
  end
end
