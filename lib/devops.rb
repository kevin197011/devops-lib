module DevOps
  class Error < StandardError; end
  # Your code goes here...
end

Dir.glob(File.join(File.dirname(__FILE__), 'devops/*.rb')).each do |r|
  require_relative "devops/#{File.basename(r, '.rb')}"
end
