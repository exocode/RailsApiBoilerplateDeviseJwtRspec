class Auth::SessionsController < Devise::SessionsController
  include ActionController::Flash
  # GET /resource/sign_in
  def new
    self.resource = resource_class.new(sign_in_params)
    clean_up_passwords(resource)
    yield resource if block_given?
    render status: :unauthorized,
           json: {
             info: "invalid",
             errors: resource.errors.messages,
             data: serialize_options(resource)
           }
  end

  # POST /resource/sign_in
  def create
    super
  end

  # DELETE /resource/sign_out
  def destroy
    flash
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    notice = :signed_out if signed_out
    yield if block_given?
    respond_to_on_destroy
  end

  protected

  def respond_to_on_destroy
    render status: :no_content
  end
end
