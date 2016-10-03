gryphon/controllers/users/registrations_controller.rb
class RegistrationsController < Devise::RegistrationsController
  # skip_before_filter :verify_authenticity_token, :only => :create

  protected
    def after_sign_up_path_for(resource)
      signed_in_root_path(resource)
    end
    
    def after_update_path_for(resource)
      signed_in_root_path(resource)
    end
end
