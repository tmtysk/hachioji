#  vim: set autoindent encoding=utf-8 filetype=ruby sts=3 sw=2 ts=2 : 

require 'date'

module Hachioji
  class Pm25

    attr_accessor :area_name, :date, :values

    def initialize(area_name: "", date: nil, values: [])
      @area_name = area_name
      @date = date
      @values = values
    end

    def hour_value_at(hour)
      @values[hour-1]
    end

    def average
      eff_values = @values.compact
      eff_values.inject(0){ |sum,v| sum += v }.to_f / eff_values.count
    end

  end
end
