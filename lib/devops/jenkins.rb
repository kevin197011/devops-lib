# frozen_string_literal: true

require 'jenkins_api_client'
require 'rbconfig'
require 'logger'


module DevOps
  class Jenkins < Base
    def initialize
      super
      @url = ENV['JENKINS_URL']
      @username = ENV['JENKINS_USERNAME']
      @password = ENV['JENKINS_TOKEN']
      @logger = Logger.new(RbConfig::CONFIG['host_os'] =~ /linux|bsd/ ? '/dev/null' : 'NUL')
      @logger.level = Logger::UNKNOWN
    end

    def jobs
      instance.job.list_all
    end

    def match(filter)
      instance.job.list(filter)
    end

    def delete(job)
      instance.job.delete(job)
    end

    def config(job)
      instance.job.get_config(job)
    end
    
    private

    def instance
      JenkinsApi::Client.new(
        server_url: @url,
        username: @username,
        password: @password,
        logger: @logger
      )
    end
  end
end

