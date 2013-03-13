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

This module includes unofficial wrapper classes for "$BH,2&;R;TBg5$1x@w>o;~4F;kB,Dj7k2L(B / http://www.taikikansi-hachioji.jp/realtime.htm"
See http://www.taikikansi-hachioji.jp/realtime.htm for details to operate/understand gotten values before using this module.

Getting latest wind direction:

    require 'hachioji'
    wc = Hachioji::Taikikanshi::WdClient.new
    wc.parse
    pp wc.latest_values # => {"$BJRAR(B"=>"$BFnFn@>(B", "$B4[(B"=>"$BFnFnEl(B", "$BBg3Z;{(B"=>"$BFn(B", "$B@n8}(B"=>"$BFn(B", "$BH,LZ(B"=>"$BFnEl(B", "$B2<M.LZ(B"=>"$BFnFnEl(B", "$BBG1[(B"=>"$BFn@>(B"}

Getting average density of PM2.5 in last 24 hours:

    require 'hachioji'
    pc = Hachioji::Taikikanshi::Pm25Client.new
    pc.parse
    pp pc.averages_24h # => {"$BJRAR(B"=>17.958333333333332, "$B4[(B"=>12.875, "$BH,LZ(B"=>15.583333333333334, "$BBG1[(B"=>16.0}

Confirm with command line:

    $ hachioji_pm25
    Latest: 
            {"$BJRAR(B"=>45, "$B4[(B"=>14, "$BH,LZ(B"=>25, "$BBG1[(B"=>33}
    Average in last 24H:
            {"$BJRAR(B"=>17.958333333333332, "$B4[(B"=>12.875, "$BH,LZ(B"=>15.583333333333334, "$BBG1[(B"=>16.0}

