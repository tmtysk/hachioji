#  vim: set autoindent encoding=utf-8 et filetype=ruby sts=2 sw=2 ts=4 : 

require "#{File.join(File.dirname(__FILE__), '..', 'lib', 'hachioji')}"
require "pp"

pc = Hachioji::Pm25Client.new
pc.parse

pp pc.pm25s["片倉"].hour_value_at(13)
pp pc.pm25s["館"].hour_value_at(11)
pp pc.pm25s_previous["片倉"].hour_value_at(13)
pp pc.pm25s_previous["館"].hour_value_at(11)

pp pc.pm25s["片倉"].average

pp pc.averages_24h
pp pc.averages_previous
