class DeliveryManifestsController < ApplicationController
  respond_to :html
  skip_before_filter :verify_authenticity_token 
  #def create
    #@manifest = DeliveryManifest.new(params[:delivery_manifest])
    #@manifest.save
    #respond_with(@manifest)
  #end

  def update
    @manifest = DeliveryManifest.find(params[:id])
    if params[:delivery_manifest][:delivery_secret] == @manifest.delivery_secret
      if @manifest.update_attributes(params[:delivery_manifest])
        flash[:success] = "Your emails should arrive shortly."
      else
        flash[:error] = "There was an error trying to send your emails, sorry!"
      end
    else
      flash[:error] = "Error sending emails!"
    end
    redirect_to root_path
  end
end
