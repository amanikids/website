class Document < ActiveRecord::Base
  has_attached_file :document, :url => '/system/:attachment/:id/:filename' # Don't put :style in the filename.
end
