class Screenshot < ActiveRecord::Base

  validates_presence_of :file

  belongs_to :project
  validates_associated :project

  default_scope { order("position ASC") }

  mount_uploader :file, ScreenshotUploader

end
