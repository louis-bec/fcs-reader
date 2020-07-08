class S3File < ApplicationRecord
  validates :name, presence: true # Make sure the owner's name is present.
end
