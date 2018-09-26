module ApiAuthentication
  class Engine < Rails::Engine
    isolate_namespace ApiAuthentication

    initializer "ApiSessionRecovering.extend_active_record" do
      #
    end
  end
end
