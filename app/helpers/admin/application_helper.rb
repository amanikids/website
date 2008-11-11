module Admin::ApplicationHelper
  # TODO clean this up!
  def parents
    Section.ordered.inject([]) do |options, section|
      options << [section.title, section.id]

      section.children.each do |child|
        options << ['- ' + child.title, child.id]
      end

      options
    end
  end
end
