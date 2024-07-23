# frozen_string_literal: true

require 'http'
require 'base64'
require 'openssl'
require 'date'

module DevOps
  class Bastion < Base
    def users
      url = "#{ENV['BASTION_URL']}/api/v1/users/users/"

      response = HTTP.headers(headers(url)).get(url)
      puts response.body
    end

    def hosts
      url = "#{ENV['BASTION_URL']}/api/v1/assets/assets/"

      response = HTTP.headers(headers(url)).get(url)
      puts response.body

      # File.open('host.json', 'w') do |f|
      #   f.write(response.body)
      # end
    end

    private

    def headers(url)
      date = DateTime.now.strftime('%a, %d %b %Y %H:%M:%S GMT')
      headers = {
        'Accept' => 'application/json',
        'X-JMS-ORG' => '00000000-0000-0000-0000-000000000002',
        'Date' => date
      }
      signature_string = "(request-target): get #{URI(url).path}\naccept: #{headers['Accept']}\ndate: #{date}"
      hmac = OpenSSL::HMAC.digest(OpenSSL::Digest.new('sha256'), ENV['BASTION_SECRET_ID'], signature_string)
      signature = Base64.strict_encode64(hmac)
      headers['Authorization'] =
        "Signature keyId=\"#{ENV['BASTION_KEY_ID']}\",algorithm=\"hmac-sha256\",headers=\"(request-target) accept date\",signature=\"#{signature}\""

      headers
    end
  end
end

