class Upload < ApplicationRecord
  has_many_attached :files

  before_save :remove_duplicates

  def remove_duplicates
    files.attachments.each do |file|
      files = [].tap do |list|
        Upload.with_attached_files.each do |upload|
          upload.files.select { |existing_file| list << existing_file.blob.filename }
        end
      end
      if files.include?(file.blob.filename)
        file.purge
      end
    end
  end
  # ActiveStorage::Blob.service.exist?((file.blob.key))
end
