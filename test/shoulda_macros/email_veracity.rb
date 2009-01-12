class Test::Unit::TestCase
  def self.should_validate_email_veracity_of(*attributes)
    attributes.each do |attribute|
      should_require_attributes attribute
      should_allow_values_for attribute, 'foo@example.com'
      should_not_allow_values_for attribute, 'not an email address'
    end
  end
end