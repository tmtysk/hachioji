#  vim: set autoindent encoding=utf-8 et filetype=ruby sts=2 sw=2 ts=4 : 

module Hachioji::Taikikanshi
  class WdClient < BaseClient

    endpoint_path "/wdhour.htm"
    measured_value_type :string

    def parse
      html = open(self.endpoint_url).read
      @doc = Nokogiri::HTML(html.toutf8)
      @areas = []
      @values = {}
      @values_previous = {}
      got_date = false
      parsing_previous = false

      @doc.xpath("/html/body/table/tr").each_with_index do |tr,tri|
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

  end
end
