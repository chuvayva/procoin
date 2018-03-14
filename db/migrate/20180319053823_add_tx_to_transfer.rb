class AddTxToTransfer < ActiveRecord::Migration[5.0]
  def change
    add_column :transfers, :tx, :string
  end
end
