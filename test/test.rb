#  vim: set autoindent encoding=utf-8 et filetype=ruby sts=2 sw=2 ts=4 : 

require "#{File.join(File.dirname(__FILE__), '..', 'lib', 'hachioji')}"
require "pp"

pc = Hachioji::Taikikanshi::Pm25Client.new
pc.parse

pp pc.values["片倉"].hour_value_at(13)
pp pc.values["館"].hour_value_at(11)
pp pc.values_previous["片倉"].hour_value_at(13)
pp pc.values_previous["館"].hour_value_at(11)

pp pc.values["片倉"].average

pp pc.averages_24h
pp pc.averages_previous

=begin
sc = Hachioji::So2Client.new
sc.parse

pp sc.pm25s
pp sc.pm25s["片倉"].hour_value_at(9)
pp sc.averages_24h
=end

