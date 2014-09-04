class Slide < ActiveRecord::Base
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>"}, :default_url => "missing.png"
  validates_attachment :image, content_type: { content_type: [ "image/jpg", "image/jpeg", "image/png", "image/gif" ] }
  validates :image, presence: true
end
