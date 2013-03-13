#  vim: set autoindent encoding=utf-8 et filetype=ruby sts=2 sw=2 ts=4 : 

module Hachioji::Taikikanshi
  class Pm25Client < BaseClient

    endpoint_path "/pm25hour.htm"
    measured_value_type :integer

  end
end
