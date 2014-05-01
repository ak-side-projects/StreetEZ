class Photo < ActiveRecord::Base

  validates :rental, presence: :true

  has_attached_file :file, :styles => {
    :big => "600x600",
    :thumb => "100x100"
  }

  validates_attachment_content_type :file, :content_type => /\Aimage\/.*\Z/

  belongs_to :rental, inverse_of: :photos
  
  def picture_from_url(url)
    self.file = url
  end
  
end
