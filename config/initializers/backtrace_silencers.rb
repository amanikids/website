# Be sure to restart your server when you modify this file.

# You can add backtrace silencers for libraries that you're using but don't wish to see in your backtraces.
# Rails.backtrace_cleaner.add_silencer { |line| line =~ /my_noisy_library/ }

# You can also remove all the silencers if you're trying do debug a problem that might steem from framework code.
# Rails.backtrace_cleaner.remove_silencers!

# It's nice to remove the filters when running in TextMate so that we get clickable stack traces.
class ActiveSupport::BacktraceCleaner
  def remove_filters!
    @filters = []
  end
end

if ENV['TM_PROJECT_DIRECTORY']
  Rails.backtrace_cleaner.remove_filters!
end
