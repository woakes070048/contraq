module Resourceful
  extend ActiveSupport::Concern
  included do
    include Pundit
    after_action :verify_authorized, except: :index
    after_action :verify_policy_scoped, only: :index
  end
end
