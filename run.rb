# frozen_string_literal: true

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'lib'))

require 'devops'

c = DevOps::Bastion.new
c.hosts
