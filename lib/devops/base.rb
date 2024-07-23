# frozen_string_literal: true

require 'dotenv'

module DevOps
  class Base
    def initialize
      Dotenv.load
    end
  end
end
