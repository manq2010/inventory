require 'rails_helper'

all_tags = [
  { name: 'Authentication', description: 'Operations related to users' },
  { name: 'Search', description: 'Operations searching' },
  { name: 'Users', description: 'Operations related to users' }
  # { name: 'Items', description: 'Operations related to items' },
  # { name: 'Sales', description: 'Operations related to Sales' },
  # { name: 'Orders', description: 'Operations related to Orders' },
  # { name: 'Sales-Items', description: 'Operations related to Sales - Items join table' },
  # { name: 'Customers', description: 'Operations related to Customers' }
]

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.swagger_root = Rails.root.join('swagger').to_s

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:swaggerize' rake task, the complete Swagger will
  # be generated at the provided relative path under swagger_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a swagger_doc tag to the
  # the root example_group in your specs, e.g. describe '...', swagger_doc: 'v2/swagger.json'
  config.swagger_docs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'API V1',
        version: 'v1'
      },
      # paths: {},
      components: {
        securitySchemes: {
          bearer_auth: {
            type: :http,
            scheme: :bearer,
            bearerFormat: JWT
          }
        },
        schemas: {
          user_registration: {
            type: :object,
            properties: {
              first_name: {
                type: :string, default: 'James'
              },
              last_name: {
                type: :string, default: 'Smith'
              },
              username: {
                type: :string, default: 'developer'
              },
              email: {
                type: :string, default: 'developer@inventory.com'
              },
              password: {
                type: :string, default: 'password'
              },
              password_confirmation: {
                type: :string, default: 'password'
              }
            },
            required: [ 'first_name', 'last_name', 'username' ]
          },
          user_login: {
            type: :object,
            properties: {
              email: { type: :string, default: 'developer@inventory.com' },
              password: { type: :string, default: 'password' }
            }
          }
        }
      },
      tags: all_tags,
      security: [{ bearerAuth: [] }],
      paths: {
        '/api/v1/auth/signup': {
          post: {
            tags: ['Authentication'],
            summary: 'Creates a new user',
            consumes: ['application/json'],
            produces: ['application/json'],
            parameters: [
              {
                in: :body,
                name: :user,
                schema: {
                  type: :object,
                  properties: {
                    user: {
                      type: :object,
                      '$ref': '#/components/schemas/user_registration'
                    }
                  }
                },
                required: true
              }
            ],
            responses: {
              '200': {
                description: 'User created'
              },
              '401': {
                description: 'User already exists'
              },
              '422': {
                description: 'Invalid request'
              },
              '500': {
                description: 'Internal server error'
              }
            }
          }
        },
        '/api/v1/auth/login': {
          post: {
            tags: ['Authentication'],
            summary: 'Logs in a user',
            consumes: ['application/json'],
            produces: ['application/json'],
            parameters: [
              {
                in: :body,
                name: :user,
                schema: {
                  type: :object,
                  properties: {
                    user: {
                      type: :object,
                      '$ref': '#/components/schemas/user_login'
                    }
                  }
                },

                required: true
              }
            ],
            responses: {
              '200': {
                description: 'User created'
              }
            }
          }
        },
        '/api/v1/auth/logout': {
          delete: {
            tags: ['Authentication'],
            security: [{ bearer_auth: [] }],
            summary: 'Logs out current logged in user',
            description: '',
            operationId: 'logout',
            parameters: [],
            responses: {
              default: {
                description: 'Success'
              }
            }
          }

        },
        '/api/v1/users': {
          get: {
            tags: ['Users'],
            security: [{ bearer_auth: [] }],
            summary: 'Returns all users',
            description: '',
            operationId: 'getUsers',
            parameters: [],
            responses: {
              default: {
                description: 'Success'
              }
            }
          }
        },
        '/api/v1/auth/me': {
          get: {
            tags: ['Users'],
            security: [{ bearer_auth: [] }],
            summary: 'Returns current logged in user',
            description: '',
            operationId: 'me',
            parameters: [],
            responses: {
              default: {
                description: 'Success'
              }
            }
          }
        },
        '/api/v1/users/show/{username}': {
          get: {
            tags: ['Users'],
            security: [{ bearer_auth: [] }],
            summary: 'Returns user by username',
            description: '',
            operationId: 'getUser',
            parameters: [
              {
                name: 'username',
                in: :path,
                description: 'Username of user',
                required: true,
                schema: {
                  type: :string
                }
              }
            ],
            responses: {
              default: {
                description: 'Success'
              }
            }
          }
        },
        '/api/v1/search?username={username}': {
          get: {
            tags: ['Search'],
            security: [{ bearer_auth: [] }],
            summary: 'Searches for a user by username',
            description: '',
            operationId: 'searchUser',
            parameters: [
              {
                in: :query,
                name: :username,
                description: 'Username to search for',
                required: true,
                schema: {
                  type: :string
                }
              }
            ],
            responses: {
              default: {
                description: 'Success'
              }
            }
          }
        }
      },
      servers: [
        {
          url: 'http://{localhost}',
          variables: {
            localhost: {
              default: '127.0.0.1:4000'
            }
          }
        }
      ]
    }
  }

  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  # The swagger_docs configuration option has the filename including format in
  # the key, this may want to be changed to avoid putting yaml in json files.
  # Defaults to json. Accepts ':json' and ':yaml'.
  config.swagger_format = :yaml
end
