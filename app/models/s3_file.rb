class S3File < ApplicationRecord
  mount_uploader :url, AttachmentUploader # Tells rails to use this uploader for this model.
  validates :name, presence: true # Make sure the owner's name is present.
end
