#  vim: set autoindent encoding=utf-8 filetype=ruby sts=3 sw=2 ts=2 : 

require 'date'

module Hachioji::Taikikanshi
  class MeasuredValue

    attr_accessor :area_name, :date, :values

    def initialize(area_name: "", date: nil, values: [], value_type: :float)
      @area_name = area_name
      @date = date
      @values = values
      available_average if value_type == :integer || value_type == :float
    end

    def hour_value_at(hour)
      @values[hour-1]
    end

    def available_average
      define_singleton_method("average") {
        eff_values = @values.compact
        eff_values.inject(0){ |sum,v| sum += v }.to_f / eff_values.count
      }
    end
  end
end
