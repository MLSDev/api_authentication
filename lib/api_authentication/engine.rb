module ApiAuthentication
  class Engine < Rails::Engine
    isolate_namespace ApiAuthentication

    initializer "ApiAuthentication.extend_active_record" do
      #
    end
  end
end
