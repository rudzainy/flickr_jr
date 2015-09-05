class Photo < ActiveRecord::Base
  # Remember to create a migration!
  validates :file, presence: true

  belongs_to :user
  belongs_to :album

  mount_uploader :file, ImageUploader 
end
