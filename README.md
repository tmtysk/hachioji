# Hachioji

Utilities for programmers in Hachioji.

## Installation

Add this line to your application's Gemfile:

    gem 'hachioji'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hachioji

## Usage

### Taikikanshi module

This module includes unofficial wrapper classes for "八王子市大気汚染常時監視測定結果 / http://www.taikikansi-hachioji.jp/realtime.htm"
See http://www.taikikansi-hachioji.jp/realtime.htm for details to operate/understand gotten values before using this module.

Getting latest wind direction:

    require 'hachioji'
    wc = Hachioji::Taikikanshi::WdClient.new
    wc.parse
    pp wc.latest_values # => {"片倉"=>"南南西", "館"=>"南南東", "大楽寺"=>"南", "川口"=>"南", "八木"=>"南東", "下柚木"=>"南南東", "打越"=>"南西"}

Getting average density of PM2.5 in last 24 hours:

    require 'hachioji'
    pc = Hachioji::Taikikanshi::Pm25Client.new
    pc.parse
    pp pc.averages_24h # => {"片倉"=>17.958333333333332, "館"=>12.875, "八木"=>15.583333333333334, "打越"=>16.0}

Confirm with command line:

    $ hachioji_pm25
    Latest: 
            {"片倉"=>45, "館"=>14, "八木"=>25, "打越"=>33}
    Average in last 24H:
            {"片倉"=>17.958333333333332, "館"=>12.875, "八木"=>15.583333333333334, "打越"=>16.0}

