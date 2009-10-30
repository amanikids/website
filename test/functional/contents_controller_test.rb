require 'test_helper'

class ContentsControllerTest < ActionController::TestCase
  should_route :get, '/', :action => 'index'

  context 'with a simple site in place' do
    setup do
      @home = Factory.create(:home)
    end

    context 'GET index' do
      setup { get :index }

      should_respond_with :ok

      should 'set the etag' do
        assert_equal(etag_for(@home), @response.etag)
      end

      should 'set the last modified timestamp' do
        assert_equal(@home.updated_at.httpdate, @response.last_modified.httpdate)
      end

      should 'stay fresh for 15 minutes and allow public caching' do
        assert_equal('max-age=900, public', @response.headers['Cache-Control'])
      end
    end

    context 'GET index with the current etag' do
      setup do
        @request.if_none_match = etag_for(@home)
        get :index
      end

      should_respond_with :not_modified
    end

    context 'GET index with last modified since' do
      setup do
        @request.if_modified_since = @home.updated_at.httpdate
        get :index
      end

      should_respond_with :not_modified
    end
  end

  private

  def etag_for(record)
    response = ActionController::Response.new
    response.etag = record
    response.etag
  end
end
