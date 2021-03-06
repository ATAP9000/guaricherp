class SaleSearch
  attr_reader :date_from, :date_to

  def initialize(params)
    params ||= {}
    @date_from = parsed_date(params[:date_from], Date.today.to_s)
    @date_to = parsed_date(params[:date_to], Date.today.to_s)
  end

  def scope
    Sale.where('created_at BETWEEN ? AND ?', @date_from, @date_to)
  end

  private

  def parsed_date(date_string, default)
    Date.parse(date_string)
  rescue ArgumentError, TypeError
    default
  end
end
  
