class AlterTableAttachmentsAddFileType < ActiveRecord::Migration[5.1]
  def change
    add_column :attachments, :file_type, :string
  end
end
