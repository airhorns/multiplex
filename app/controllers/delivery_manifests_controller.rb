class DeliveryManifestsController < ApplicationController
  respond_to :html
  skip_before_filter :verify_authenticity_token 

  def update
    @manifest = DeliveryManifest.find(params[:id])
    if params[:delivery_manifest][:delivery_secret] == @manifest.delivery_secret
      if @manifest.update_attributes(params[:delivery_manifest])
        if mobile_device?
          render 'delayedclose'
        else
          render 'autoclose'
        end
        return
      else
        flash[:error] = "There was an error trying to send your emails, sorry!"
      end
    else
      flash[:error] = "Error sending emails!"
    end
    redirect_to faq_path
  end
end
