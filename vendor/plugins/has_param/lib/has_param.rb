module HasParam
  module ClassMethods
    def has_param(name)
      module_eval(<<-EOS, "(__HAS_PARAM__)", 1)
        def to_param
          #{name}
        end

        def self.find_by_param(param)
          first(:conditions => { '#{name}' => param }) || raise(ActiveRecord::RecordNotFound)
        end
      EOS
    end
  end
end