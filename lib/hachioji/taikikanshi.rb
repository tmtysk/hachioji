module Taikikanshi; end
Dir[File.join(File.dirname(__FILE__), 'taikikanshi', '*.rb')].sort.each { |f| require f }
