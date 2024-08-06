# frozen_string_literal: true

require 'aws-sdk-s3'


module DevOps
  class AwsS3 < Base
    def initialize
      super
      @instance = instance
    end

    def upload(file_path, bucket_name, object_key)
      begin
        File.open(file_path, 'rb') do |file|
          @instance.put_object(bucket: bucket_name, key: object_key, body: file)
          puts "File #{object_key} uploaded successfully to bucket #{bucket_name}."
        end
      rescue Aws::S3::Errors::ServiceError => e
        puts "Error uploading file: #{e.message}"
      end
    end

    private

    def instance
      Aws.config.update({
        region: ENV['AWS_REGION'],
        credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY'])
      })
      Aws::S3::Client.new(region: ENV['AWS_REGION'])
    end
  end
end
