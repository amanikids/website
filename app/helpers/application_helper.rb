module ApplicationHelper
  def breadcrumbs(page)
    parents = []

    parent = page.parent
    until parent.is_a?(Home)
      parents.unshift(parent)
      parent = parent.parent
    end

    parents.map! do |parent|
      link_to_if(parent.path, parent.title, parent.path) + ':'
    end

    parents.join(' ')
  end

  class FormBuilder < ActionView::Helpers::FormBuilder
    def error_messages
      if object.errors.any?
        @template.content_tag(:p, @object.errors.full_messages.to_sentence + '.', :class => 'errorExplanation', :id => 'errorExplanation')
      end
    end
  end
end