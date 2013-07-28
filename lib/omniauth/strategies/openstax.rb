require 'omniauth'
require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Openstax < OAuth2
      option :name, :openstax

      option :client_options, {
        :site => "http://localhost:3000", # TODO make services.openstax.org in production at least
        :authorize_url => "/oauth/authorize"
      }

      uid { raw_info["uid"] }

      info do
        {
          :username => raw_info["username"]
          # and anything else you want to return to your API consumers
        }
      end

      def raw_info
        @raw_info ||= access_token.get('/api/v1/me.json').parsed
      end
    end
  end
end