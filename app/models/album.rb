class Album < ActiveRecord::Base
  has_many :photos
  belongs_to :user
  mount_uploader :thumbnail, ThumbnailUploader

  def get_photos
    Photo.where("album_id = ?", id)
  end
end
