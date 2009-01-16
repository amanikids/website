class Admin::ContentsController < Admin::ApplicationController
  protected

  def pages
    @pages = Content.all.reject { |content| content.class == Section || content.class == Blog }
  end

  def pages_without_text
    @pages_without_text ||= pages.select { |content| content.body.to_s.length < 50 }
  end

  def pages_without_photos
    @pages_without_photos ||= pages.select { |content| content.photos.count.zero? }
  end

  def pages_matching_expression
    @pages_matching_expression ||= pages.select { |content| content.any_text_matches? /#{expression}/i }
  end

  def expression
    @expression ||= params[:expression] || 'todo|link'
  end

  helper_method :pages_without_text, :pages_without_photos, :pages_matching_expression, :expression
end
