#  vim: set autoindent encoding=utf-8 et filetype=ruby sts=2 sw=2 ts=4 : 

module Hachioji::Taikikanshi
  class BaseClient
    attr_accessor :values, :values_previous
    ENDPOINT_HOST = "http://www.taikikansi-hachioji.jp"

    def parse
      html = open(self.endpoint_url).read
      @doc = Nokogiri::HTML(html.toutf8)
      @areas = []
      @values = {}
      @values_previous = {}
      got_date = false
      parsing_previous = false

      @doc.xpath("/html/body/table[2]/tr").each_with_index do |tr,tri|
        if tri == 0
          tr.xpath("./td/font").each_with_index do |font,fonti|
            next if fonti == 0
            @areas << font.text
            @values[font.text] = MeasuredValue.new(area_name: font.text, value_type: measured_value_type)
            @values_previous[font.text] = MeasuredValue.new(area_name: font.text, value_type: measured_value_type)
          end
        else
          tdidx = 0
          tr.xpath("./td").each do |td|
            if td["rowspan"]
              month, day = td.xpath("./font").first.text.scan(/(\d+)／(\d+)/).first
              if !got_date
                @areas.each do |area|
                  @values[area].date = Date.new(Date.today.year, month.to_i, day.to_i)
                end
                got_date = true
              else
                @areas.each do |area|
                  @values_previous[area].date = Date.new(Date.today.year, month.to_i, day.to_i)
                end
                parsing_previous = true
              end
            else
              val = td.xpath("./font").first.text.strip
              next if val.match(/\d+時/)
              value = measured_value(val)
              if parsing_previous
                @values_previous[@areas[tdidx]].values.insert(0, value)
              else
                @values[@areas[tdidx]].values.insert(0, value)
              end
              tdidx += 1
            end
          end
        end
      end
    end

    class << self
      def endpoint_path(path)
        define_method("endpoint_url") {
          "#{ENDPOINT_HOST}#{path}"
        }
      end

      def available_average
        define_method("averages_24h") {
          averages = {}
          parse if !@values || !@values_previous

          @areas.each do |area|
            area_values = @values_previous[area].values + @values[area].values
            area_values.compact!
            base_values = area_values.last(24)
            averages[area] = base_values.inject(0){ |sum,v| sum += v }.to_f / base_values.count
          end

          averages
        }

        define_method("averages_previous") {
          averages = {}
          parse if !@values || !@values_previous

          @areas.each do |area|
            area_values = @values_previous[area].values
            area_values.compact!
            base_values = area_values.last(24)
            averages[area] = base_values.inject(0){ |sum,v| sum += v }.to_f / base_values.count
          end

          averages
        }
      end



      def measured_value_type(type)
        available_average if type == :float || type == :integer
        define_method("measured_value_type") {
          type
        }
        define_method("measured_value") { |read_value|
          case type
          when :float
            read_value.to_f if read_value.match(/^[\d\.]+$/)
          when :integer
            read_value.to_i if read_value.match(/^[\d]+$/)
          when :string
            read_value.to_s
          else
            nil
          end
        }
      end

    end

    endpoint_path "/dummy.html"
    measured_value_type :float
  end
end
