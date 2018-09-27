module ApiAuthentication
  class SessionDocs
    require 'swagger/blocks'
    require 'apidocs/unprocessable_entity'

    include Swagger::Blocks

    swagger_path '/session' do
      operation :post do
        key :description, 'session'
        key :summary, 'create session'
        key :tags, ['session']
        key :consumes, ['multipart/form-data']
        parameter do
          key :name, 'session[email]'
          key :in, :formData
          key :required, true
          key :type, :string
        end
        parameter do
          key :name, 'session[password]'
          key :in, :formData
          key :required, true
          key :type, :string
          key :format, :password
        end
        response '201' do
          key :description, 'Session'
          schema do
            key :'$ref', :ApiAuthenticationOutputSession
          end
        end
        response '422' do
          key :description, 'UnprocessableEntity'
          schema do
            key :'$ref', :UnprocessableEntity
          end
        end
      end
    end

    swagger_path '/session' do
      operation :delete do
        key :description, 'session'
        key :summary, 'delete session'
        key :tags, ['session']
        key :consumes, ['multipart/form-data']
        parameter do
          key :name, 'Authorization'
          key :in, :header
          key :default, 'Token token="ACCESS_TOKEN"'
          key :required, true
          key :type, :string
        end
        response '201' do
          key :description, 'Session'
        end
        response '401' do
          key :description, 'NotAuthorize'
        end
      end
    end

    swagger_schema :ApiAuthenticationOutputSession do
      property :token do
        key :type, :string
      end
      property :user do
        key :'$ref', :ApiAuthenticationOutputProfile
      end
    end

    swagger_schema :ApiAuthenticationOutputProfile do
      key :required, [:id]
      property :id do
        key :type, :string
        key :description, 'See Profile model for GET /profile'
        key :default, 'See Profile model for GET /profile'
      end
    end
  end
end
