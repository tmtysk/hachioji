#  vim: set autoindent encoding=utf-8 et filetype=ruby sts=2 sw=2 ts=4 : 

module Hachioji::Taikikanshi
  class Ch4Client < BaseClient

    endpoint_path "/ch4hour.htm"
    measured_value_type :float

  end
end
