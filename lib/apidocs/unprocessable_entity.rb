# frozen_string_literal: true

module ApiAuthentication
  class UnprocessableEntity
    include Swagger::Blocks

    swagger_schema :UnprocessableEntity do
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
end
