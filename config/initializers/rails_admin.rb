require "nested_form/engine"
require "nested_form/builder_mixin"

RailsAdmin.config do |config|
  config.main_app_name = ["GuarichERP", "Admin"]

  #Auntenficia si hay un usuario logeado
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)
  #########################################

  #Esconder el modelo del navegador a la izquierda
  config.model 'Role' do
    visible false
  end

  # mostrar campos de creacion y edicion de rails admin
config.model 'User' do
  edit do
    field :username
    field :email
    field :password
    field :role_id
    end
end

  #Autoriza acceso si tiene rol admin (acomodar en un futuro)
  config.authorize_with do
    redirect_to main_app.root_path unless current_user.role_id==1
  end
##########################################

  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == CancanCan ==
  # config.authorize_with :cancancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new do
      except ['Role', 'Sale']
    end
    export
    bulk_delete
    show 
    edit do
      except ['Role']
    end
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
