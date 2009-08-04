class CompositePage < Page
  # override so we don't show links to each individual segment
  def next_page
    in_order_traversal
  end
end
