class Admin::SegmentsController < Admin::ApplicationController
  before_filter :load_new_segment, :only => %w[new create]
  before_filter :load_segment,     :only => %w[edit update destroy]

  def create
    if @segment.save
      redirect_to @segment.continue_editing ? edit_admin_segment_path(@segment) : edit_admin_composite_page_path(@segment.parent)
    else
      render :action => 'new'
    end
  end

  def update
    if @segment.update_attributes(params[:segment])
      redirect_to @segment.continue_editing ? edit_admin_segment_path(@segment) : edit_admin_composite_page_path(@segment.parent)
    else
      render :action => 'edit'
    end
  end

  def destroy
    @segment.destroy
    redirect_to edit_admin_composite_page_path(@segment.parent)
  end

  private

  def load_new_segment
    @segment = Segment.new(params[:segment])
  end

  def load_segment
    @segment = Segment.find(params[:id])
  end
end
