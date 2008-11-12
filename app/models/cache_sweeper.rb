class CacheSweeper < ActiveRecord::Observer
  observe :content

  def after_save(record)
    expire_entire_cache
  end

  def after_destroy(record)
    expire_entire_cache
  end

  private

  def expire_entire_cache
    FileUtils.rm_rf(ActionController::Base.page_cache_directory) if ActionController::Base.perform_caching
  end
end
