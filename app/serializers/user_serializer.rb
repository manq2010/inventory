# class UserSerializer < BaseSerializer
#   attributes :id, :email, :first_name, :last_name
#   attributes :username, :created_at, :updated_at
#   attribute :avatar

#   attribute :created_date do |user|
#     user.created_at&.strftime('%d/%m/%Y')
#   end

#   DEFAULT_AVATAR = 'https://res-2.cloudinary.com/dhatgaadw/image/upload/v1661765174/e0eiopj9eqt5dwnt5n2v.jpg'.freeze

#   def avatar
#     if object.avatar.url.present?
#       object.avatar.url
#     else
#       DEFAULT_AVATAR
#     end
#   end
# end

module Api
  module V1
    class UserSerializer
      include JSONAPI::Serializer
      attributes :id, :email, :first_name, :last_name
      attributes :username, :created_at, :updated_at
      attribute :avatar

      attribute :created_date do |user|
        user.created_at&.strftime('%d/%m/%Y')
      end

      DEFAULT_AVATAR = 'https://res-2.cloudinary.com/dhatgaadw/image/upload/v1661765174/e0eiopj9eqt5dwnt5n2v.jpg'.freeze

      def avatar
        if object.avatar.url.present?
          object.avatar.url
        else
          DEFAULT_AVATAR
        end
      end
    end
  end

  module V2
    class UserSerializer
      include JSONAPI::Serializer
      attribute :name
    end
  end
end
