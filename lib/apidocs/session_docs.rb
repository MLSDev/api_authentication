class ApiAuthentication::SessionDocs
  require 'apidocs/unprocessable_entity'
  include Swagger::Blocks

  swagger_path '/session' do
    operation :post do
      key :description, 'session'
      key :summary, 'session'
      key :tags, ['Create new session']
      key :consumes, ['multipart/form-data']
      # security do
      #   key :api_key, []
      # end
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
      end
      response '422' do
        key :description, 'UnprocessableEntity'
        schema do
          key :'$ref', :UnprocessableEntity
        end
      end
    end
  end
end
