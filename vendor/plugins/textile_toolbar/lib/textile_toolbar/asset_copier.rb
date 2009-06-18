# Generated by the asset_copier plugin
# http://github.com/pelargir/asset_copier

require 'find'
require 'digest/md5'

module TextileToolbar
  class AssetCopier
    @source = File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'files'))
    @destination = RAILS_ROOT
    @deleted_files = File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'deleted_files'))
    class << self
      attr_accessor :source, :destination, :deleted_files
    end

    def self.copy(plugin_name)
      begin
        each_path do |path, dest_path, short_path|
          if File.directory?(path)
            unless File.exists?(dest_path)
              FileUtils.mkdir_p(dest_path)
              log "Creating directory #{short_path} for #{plugin_name}"
            end
          elsif !compare(path, dest_path)
            FileUtils.cp(path, dest_path)
            log "Copying #{short_path} from #{plugin_name}"
          end
        end
      rescue Exception => e
        log "Error trying to copy files: #{e.inspect}"
        raise e
      end
      print_deletion_warnings(plugin_name)
    end

    def self.warn(plugin_name)
      each_path do |path, dest_path, short_path|
        next if File.directory?(path)
        reinstall = false
        if File.exists?(dest_path)
          unless compare(path, dest_path)
            log "WARNING: #{short_path} is out of date and needs to be reinstalled"
            reinstall = true
          end
        else
          reinstall = true
          log "WARNING: #{short_path} is missing and needs to be installed"
        end
        log "WARNING: Please run rake #{plugin_name}:install" if reinstall
      end
      print_deletion_warnings(plugin_name)
    end

    def self.compare(file1, file2)
      File.exists?(file1) && File.exists?(file2) &&
        Digest::MD5.hexdigest(File.read(file1)) == Digest::MD5.hexdigest(File.read(file2))
    end

    def self.print_deletion_warnings(plugin_name)
      File.open(deleted_files, "r") do |f|
        f.readlines.reject { |l| l =~ /^#/ || l.strip.blank? }.each do |l|
          log "WARNING: #{l} is no longer required by the #{plugin_name} plugin " <<
              "and can can be safely removed" if File.exists?(l)
        end
      end
    end

    def self.paths
      returning [] do |paths|
        Find.find(source) do |path|
          Find.prune if path =~ /\/\..+/
          Find.prune if path =~ /(CVS|.svn|.git)/
          paths << path
        end
      end
    end

    def self.each_path
      paths.each do |path|
        dest_path = path.gsub(source, destination)
        short_path = dest_path.gsub("#{destination}/", "")
        yield path, dest_path, short_path
      end
    end

    def self.log(msg)
      puts msg
    end
  end
end
