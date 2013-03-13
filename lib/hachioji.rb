require 'open-uri'
require 'kconv'
require 'nokogiri'

module Hachioji; end 

Dir[File.join(File.dirname(__FILE__), 'hachioji', '*.rb')].sort.each { |f| require f }
