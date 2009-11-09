# DO NOT MODIFY THIS FILE
module Bundler
 file = File.expand_path(__FILE__)
 dir = File.dirname(file)

  ENV["PATH"]     = "#{dir}/bin:#{ENV["PATH"]}"
  ENV["RUBYOPT"]  = "-r#{file} #{ENV["RUBYOPT"]}"

  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/xml-simple-1.0.12/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/xml-simple-1.0.12/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/builder-2.1.2/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/builder-2.1.2/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/factory_girl-1.2.3/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/factory_girl-1.2.3/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/rack-1.0.1/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/rack-1.0.1/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/mime-types-1.16/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/mime-types-1.16/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/aws-s3-0.6.2/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/aws-s3-0.6.2/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/shoulda-2.10.2/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/shoulda-2.10.2/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/rack-canonical-host-0.0.1/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/rack-canonical-host-0.0.1/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/authlogic-2.1.2/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/authlogic-2.1.2/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/haml-2.2.12/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/haml-2.2.12/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/mocha-0.9.8/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/mocha-0.9.8/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/paperclip-2.3.1.1/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/paperclip-2.3.1.1/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/fastercsv-1.5.0/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/fastercsv-1.5.0/lib")

  @gemfile = "#{dir}/../../Gemfile"

  require "rubygems"

  @bundled_specs = {}
  @bundled_specs["xml-simple"] = eval(File.read("#{dir}/specifications/xml-simple-1.0.12.gemspec"))
  @bundled_specs["xml-simple"].loaded_from = "#{dir}/specifications/xml-simple-1.0.12.gemspec"
  gem "RedCloth", "4.1.9"
  gem "activesupport", "2.3.4"
  @bundled_specs["builder"] = eval(File.read("#{dir}/specifications/builder-2.1.2.gemspec"))
  @bundled_specs["builder"].loaded_from = "#{dir}/specifications/builder-2.1.2.gemspec"
  @bundled_specs["factory_girl"] = eval(File.read("#{dir}/specifications/factory_girl-1.2.3.gemspec"))
  @bundled_specs["factory_girl"].loaded_from = "#{dir}/specifications/factory_girl-1.2.3.gemspec"
  @bundled_specs["rack"] = eval(File.read("#{dir}/specifications/rack-1.0.1.gemspec"))
  @bundled_specs["rack"].loaded_from = "#{dir}/specifications/rack-1.0.1.gemspec"
  gem "actionpack", "2.3.4"
  gem "actionmailer", "2.3.4"
  @bundled_specs["mime-types"] = eval(File.read("#{dir}/specifications/mime-types-1.16.gemspec"))
  @bundled_specs["mime-types"].loaded_from = "#{dir}/specifications/mime-types-1.16.gemspec"
  @bundled_specs["aws-s3"] = eval(File.read("#{dir}/specifications/aws-s3-0.6.2.gemspec"))
  @bundled_specs["aws-s3"].loaded_from = "#{dir}/specifications/aws-s3-0.6.2.gemspec"
  @bundled_specs["shoulda"] = eval(File.read("#{dir}/specifications/shoulda-2.10.2.gemspec"))
  @bundled_specs["shoulda"].loaded_from = "#{dir}/specifications/shoulda-2.10.2.gemspec"
  @bundled_specs["rack-canonical-host"] = eval(File.read("#{dir}/specifications/rack-canonical-host-0.0.1.gemspec"))
  @bundled_specs["rack-canonical-host"].loaded_from = "#{dir}/specifications/rack-canonical-host-0.0.1.gemspec"
  @bundled_specs["authlogic"] = eval(File.read("#{dir}/specifications/authlogic-2.1.2.gemspec"))
  @bundled_specs["authlogic"].loaded_from = "#{dir}/specifications/authlogic-2.1.2.gemspec"
  @bundled_specs["haml"] = eval(File.read("#{dir}/specifications/haml-2.2.12.gemspec"))
  @bundled_specs["haml"].loaded_from = "#{dir}/specifications/haml-2.2.12.gemspec"
  gem "rake", "0.8.7"
  @bundled_specs["mocha"] = eval(File.read("#{dir}/specifications/mocha-0.9.8.gemspec"))
  @bundled_specs["mocha"].loaded_from = "#{dir}/specifications/mocha-0.9.8.gemspec"
  gem "activerecord", "2.3.4"
  @bundled_specs["paperclip"] = eval(File.read("#{dir}/specifications/paperclip-2.3.1.1.gemspec"))
  @bundled_specs["paperclip"].loaded_from = "#{dir}/specifications/paperclip-2.3.1.1.gemspec"
  gem "activeresource", "2.3.4"
  gem "rails", "2.3.4"
  @bundled_specs["fastercsv"] = eval(File.read("#{dir}/specifications/fastercsv-1.5.0.gemspec"))
  @bundled_specs["fastercsv"].loaded_from = "#{dir}/specifications/fastercsv-1.5.0.gemspec"

  def self.add_specs_to_loaded_specs
    Gem.loaded_specs.merge! @bundled_specs
  end

  def self.add_specs_to_index
    @bundled_specs.each do |name, spec|
      Gem.source_index.add_spec spec
    end
  end

  add_specs_to_loaded_specs
  add_specs_to_index

  def self.require_env(env = nil)
    context = Class.new do
      def initialize(env) @env = env && env.to_s ; end
      def method_missing(*) ; yield if block_given? ; end
      def only(*env)
        old, @only = @only, _combine_only(env.flatten)
        yield
        @only = old
      end
      def except(*env)
        old, @except = @except, _combine_except(env.flatten)
        yield
        @except = old
      end
      def gem(name, *args)
        opt = args.last.is_a?(Hash) ? args.pop : {}
        only = _combine_only(opt[:only] || opt["only"])
        except = _combine_except(opt[:except] || opt["except"])
        files = opt[:require_as] || opt["require_as"] || name
        files = [files] unless files.respond_to?(:each)

        return unless !only || only.any? {|e| e == @env }
        return if except && except.any? {|e| e == @env }

        if files = opt[:require_as] || opt["require_as"]
          files = Array(files)
          files.each { |f| require f }
        else
          begin
            require name
          rescue LoadError
            # Do nothing
          end
        end
        yield if block_given?
        true
      end
      private
      def _combine_only(only)
        return @only unless only
        only = [only].flatten.compact.uniq.map { |o| o.to_s }
        only &= @only if @only
        only
      end
      def _combine_except(except)
        return @except unless except
        except = [except].flatten.compact.uniq.map { |o| o.to_s }
        except |= @except if @except
        except
      end
    end
    context.new(env && env.to_s).instance_eval(File.read(@gemfile), @gemfile, 1)
  end
end

module Gem
  @loaded_stacks = Hash.new { |h,k| h[k] = [] }

  def source_index.refresh!
    super
    Bundler.add_specs_to_index
  end
end
