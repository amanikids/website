class CacheSweeper < ActiveRecord::Observer
  observe :content, :newsletter, :article, :photo

  def after_save(record)
    expire_entire_cache
  end

  def after_destroy(record)
    expire_entire_cache
  end

  private

  def expire_entire_cache
    FileUtils.rm_rf(cached_files, :verbose => true) if ActionController::Base.perform_caching
  end

  def cached_files
    files('**', '*.{atom,html}') - files('[0-9][0-9][0-9].html')
  end

  def files(*args)
    Dir.glob(File.join(ActionController::Base.page_cache_directory, *args))
  end
end
