class Api::V1::StocksController < Api::V1::BaseController

  include RemoteHelper
  include ActionView::Helpers::NumberHelper

  def refresh
    @portfolio = Portfolio.where(params[:portfolio_id]).first
    @stocks = Stock.quote_update(Stock.find(params[:stock_ids]))
    @stocks_changed = price_change_assign(@stocks)
    @stocks.map {|stock| stock.save }
    render json: @stocks
  end
  
  # def refresh_history(stocks = Stock.all)
  #   @history = History.history_update(stocks, start_date, end_date)
  # end

  def price_change_assign(stocks)
    stocks.each do |stock|
      @change = 100 * ((stock.lasttradepriceonly / stock.lasttradepriceonly ) - (stock.lasttradepriceonly_was / stock.lasttradepriceonly))

      stock.ticks.pop if stock.ticks.length == 10
    
      if @change > 0.05
        stock[:ticks].unshift('green')
      elsif @change < -0.05
        stock[:ticks].unshift('red')
      else
        stock[:ticks].unshift('#272B30')
      end

    end
    
  def bounce_assign(stock)
    
  end
  
  end

end
