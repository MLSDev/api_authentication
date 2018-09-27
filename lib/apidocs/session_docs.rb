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
            key :'$ref', :OutputSession
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

    swagger_schema :OutputSession do
      property :token do
        key :type, :string
      end
      property :user do
        key :'$ref', :OutputProfile
      end
    end

    swagger_schema :OutputProfile do
      key :required, [:id]
      property :id do
        key :type, :string
        key :description, 'See Profile model'
        key :default, 'See Profile model'
      end
    end
  end
end
