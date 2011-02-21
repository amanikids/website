require 'test_helper'

class RedirectorTest < ActiveSupport::TestCase
  def setup
    @app = lambda { |env| :response }
  end

  subject do
    Redirector.new(@app, '/bounce' => 'http://example.com/')
  end

  should 'redirect a configured path to its specified url' do
    assert_equal [301, {'Location' => 'http://example.com/'}, []],
      subject.call('PATH_INFO' => '/bounce')
  end

  should 'forward other requests on to the wrapped application' do
    assert_equal :response, subject.call('PATH_INFO' => '/other')
  end
end
