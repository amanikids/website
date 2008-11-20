class Document < ActiveRecord::Base
  has_attached_file :document, :url => '/:attachment/:id/:basename.:extension', :path => ":rails_root/public/:attachment/:id/:basename.:extension"
end
