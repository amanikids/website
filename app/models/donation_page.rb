class DonationPage < Content
  validates_presence_of :title, :body, :sidebar, :footer
end
