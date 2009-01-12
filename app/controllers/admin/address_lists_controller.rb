class Admin::AddressListsController < Admin::ApplicationController
  def index
    @address_lists = AddressList.all(:order => 'created_at desc')
  end

  def new
    @address_list = AddressList.new(params[:address_list])
  end

  def create
    @address_list = AddressList.new(params[:address_list].merge(:subscriptions => Subscription.all))
    if @address_list.save
      redirect_to admin_address_lists_path
    else
      render :action => 'new'
    end
  end

  def show
    @address_list = AddressList.find(params[:id])

    respond_to do |format|
      format.text { render :text => @address_list.addresses.join("\n") }
    end
  end

  def destroy
    @address_list = AddressList.find(params[:id])
    @address_list.destroy
    redirect_to admin_address_lists_path
  end
end
