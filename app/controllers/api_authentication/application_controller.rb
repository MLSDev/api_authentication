# frozen_string_literal: true

module ApiAuthentication
  class ApplicationController < ApiAuthentication.configuration.controller_to_inherit_from.constantize
  end
end
