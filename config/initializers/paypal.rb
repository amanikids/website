PayPal = Struct.new(:url).new
PayPal.url = Rails.env.production? ? 'https://www.paypal.com/cgi-bin/webscr' : 'https://www.sandbox.paypal.com/cgi-bin/webscr'
