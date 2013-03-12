#  vim: set autoindent encoding=utf-8 et filetype=ruby sts=2 sw=2 ts=4 : 

module Hachioji
  class Pm25Client

    attr_accessor :pm25s, :pm25s_previous
    ENDPOINT_URL = "http://www.taikikansi-hachioji.jp/pm25hour.htm"

    def averages_24h
      averages = {}
      parse if !@pm25s || !@pm25s_previous

      @areas.each do |area|
        area_values = @pm25s_previous[area].values + @pm25s[area].values
        area_values.compact!
        base_values = area_values.last(24)
        averages[area] = base_values.inject(0){ |sum,v| sum += v }.to_f / base_values.count
      end

      averages
    end

    def averages_previous
      averages = {}
      parse if !@pm25s || !@pm25s_previous

      @areas.each do |area|
        area_values = @pm25s_previous[area].values
        area_values.compact!
        base_values = area_values.last(24)
        averages[area] = base_values.inject(0){ |sum,v| sum += v }.to_f / base_values.count
      end

      averages
    end

    def parse
      html = open(ENDPOINT_URL).read
      @doc = Nokogiri::HTML(html.toutf8)
      @areas = []
      @pm25s = {}
      @pm25s_previous = {}
      got_date = false
      parsing_previous = false

      @doc.xpath("/html/body/table[2]/tr").each_with_index do |tr,tri|
        if tri == 0
          tr.xpath("./td/font").each_with_index do |font,fonti|
            next if fonti == 0
            @areas << font.text
            @pm25s[font.text] = Hachioji::Pm25.new(area_name: font.text)
            @pm25s_previous[font.text] = Hachioji::Pm25.new(area_name: font.text)
          end
        else
          tdidx = 0
          tr.xpath("./td").each do |td|
            if td["rowspan"]
              month, day = td.xpath("./font").first.text.scan(/(\d+)／(\d+)/).first
              if !got_date
                @areas.each do |area|
                  @pm25s[area].date = Date.new(Date.today.year, month.to_i, day.to_i)
                end
                got_date = true
              else
                @areas.each do |area|
                  @pm25s_previous[area].date = Date.new(Date.today.year, month.to_i, day.to_i)
                end
                parsing_previous = true
              end
            else
              val = td.xpath("./font").first.text.strip
              next if val.match(/\d+時/)
              value = nil
              value = val.to_i if val.match(/^\d+$/)
              if parsing_previous
                @pm25s_previous[@areas[tdidx]].values.insert(0, value)
              else
                @pm25s[@areas[tdidx]].values.insert(0, value)
              end
              tdidx += 1
            end
          end
        end
      end

    end

  end
end
