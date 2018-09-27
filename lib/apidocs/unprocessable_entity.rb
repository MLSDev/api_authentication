# frozen_string_literal: true

class ApiAuthentication::UnprocessableEntity
  include Swagger::Blocks

  swagger_schema :UnprocessableEntity do
    schema do
      key :'$ref', :OutputUnprocessableEntity
    end
  end

  swagger_schema :OutputUnprocessableEntity do
    property :errors do
      key :'$ref', :OutputErrors
    end
  end

  swagger_schema :OutputErrors do
    property :base do
      key :type, :array
      items do
        key :type, :string
      end
    end
    property :error_field do
      key :type, :array
      items do
        key :type, :string
      end
    end
  end
end
