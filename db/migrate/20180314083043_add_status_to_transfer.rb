class AddStatusToTransfer < ActiveRecord::Migration[5.0]
  def change
    add_column :transfers, :status, :string, default: :pending
  end
end
