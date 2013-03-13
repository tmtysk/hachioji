#  vim: set autoindent encoding=utf-8 et filetype=ruby sts=2 sw=2 ts=4 : 

require "#{File.join(File.dirname(__FILE__), '..', 'lib', 'hachioji')}"
require "pp"

print "=== PM2.5 ===\n"
pc = Hachioji::Taikikanshi::Pm25Client.new
pc.parse
pp pc.values["片倉"].hour_value_at(13)
pp pc.values_previous["館"].hour_value_at(11)
pp pc.values["片倉"].average
pp pc.averages_24h
pp pc.averages_previous

print "=== SO2 ===\n"
sc = Hachioji::Taikikanshi::So2Client.new
sc.parse
pp sc.values["片倉"].hour_value_at(9)
pp sc.values["館"].average
pp sc.averages_24h

print "=== Ox ===\n"
oc = Hachioji::Taikikanshi::OxClient.new
oc.parse
pp oc.latest_values

print "=== Wind Direction ===\n"
wc = Hachioji::Taikikanshi::WdClient.new
wc.parse
pp wc.latest_values


