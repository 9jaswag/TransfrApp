# frozen_string_literal: true

class Upload < ApplicationRecord
  has_many_attached :files

  before_save :remove_duplicates
  attr_accessor :flash_notice

  private

  def remove_duplicates
    duplicate_count = 0
    files.attachments.each do |file|
      files = [].tap do |list|
        Upload.with_attached_files.each do |upload|
          upload.files.select { |existing_file| list << existing_file.blob.filename }
        end
      end
      if files.include?(file.blob.filename)
        file.purge
        duplicate_count += 1
      end
    end
    if duplicate_count > 0
      self.flash_notice = "#{duplicate_count} uploaded #{'file'.pluralize(duplicate_count)} already exists & #{duplicate_count <= 1 ? 'was' : 'were'} not uploaded"
    end
  end
  # ActiveStorage::Blob.service.exist?((file.blob.key))
end
