class PaymentsController < ApplicationController
  include Resourceful

  respond_to :html

  before_action :load_and_authorize_gig!, only: %i[new create]
  before_action :load_and_authorize_resource!, only: %i[edit update]
  before_action :save_previous_url, only: %i[new edit]

  def new
    @payment = Payment.new received_at: Time.zone.today
  end

  def create
    @payment = @gig.payments.create! model_params
    respond_with @payment, location: previous_url
  end

  def edit
  end

  def update
    @payment.update! model_params
    respond_with @payment, location: previous_url
  end

  private

  def load_and_authorize_gig!
    @gig = Gig.find params[:gig_id] # TODO: use policy_scope?
    authorize @gig, :update?
  end

  def save_previous_url
    session[:previous_url] = request.headers['referer']
  end

  def previous_url
    session.delete(:previous_url) || gigs_path
  end
end
