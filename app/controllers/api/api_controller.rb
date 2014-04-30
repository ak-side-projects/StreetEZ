module Api
  class ApiController < ApplicationController
    before_filter :require_signed_in!
  end
end
