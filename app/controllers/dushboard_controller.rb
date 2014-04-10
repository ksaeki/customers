class DushboardController < ApplicationController
  before_action :authenticate_user!
  def index
    @counts = {}
    @counts[:customers] = Customer.count
    @counts[:banks] = Bank.count
    
    sell = 0.0
    buy = 0.0
    scol = 3
    bcol = 4
    @rates = {}
    
    rate = Mechanize.new{|a| a.user_agent = "Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1; Trident/4.0)"}
      .get("http://www.cimbbank.com.my/index.php?tpt=cimb_bbiz&tpl=gen_rates")
      .root.xpath("//table[position()=2]//table//table[position()=2]//table//td[position()=3]//table[last()]//tr")
    title = rate.shift.css('td')
pp title.children[2].inner_text.match(/sell/i)
pp title.children[3].inner_text.match(/buy/i)
    if !(title.children[2].inner_text.match(/sell/i) and
         title.children[3].inner_text.match(/buy/i))
      @error = 'Site has changed.'
pp @error
      return
    end
    rate.each{ |row|
      sell = BigDecimal(row.xpath('descendant::td[3]').text()).floor(4).to_f
      buy  = BigDecimal(row.xpath('descendant::td[4]').text()).floor(4).to_f
      @rates[row.xpath('descendant::td[2]').text()] = (sell + buy) / 2
    }
    @usdjpy = BigDecimal(((@rates['USD'] / @rates['JPY']) * 100).to_s).floor(4).to_f
    @jpyusd = BigDecimal(((@rates['JPY'] / @rates['USD'])).to_s).floor(4).to_f
  end
end
