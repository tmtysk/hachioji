#  vim: set autoindent encoding=utf-8 et filetype=ruby sts=2 sw=2 ts=4 : 

module Hachioji::Taikikanshi
  class NoxClient < BaseClient

    endpoint_path "/noxhour.htm"
    measured_value_type :float

  end
end
