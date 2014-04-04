class CalendarMonth
  include DateAndTime
  include DateAndTime::Calculations
  attr_accessor :date

  def initialize(date)
    @date = date
  end

  def all_days_for_month_view
    view_month = []

    first_day = @date.beginning_of_month
    (weekday_number(first_day) - 1).downto(1) { |i| view_month << first_day.ago(i.days).to_date } if weekday_number(first_day) > 1

    month_length = Time.days_in_month(@date.month, @date.year)
    0.upto(month_length - 1) { |i|  view_month << first_day.advance(days: i) }

    last_day = @date.end_of_month
    1.upto(7 - weekday_number(last_day)) { |i| view_month << last_day.advance(days: i) } if weekday_number(last_day) < 7

    view_month.flatten.each_slice(7).to_a
  end

  protected

    def weekday_number(date)
    @weekday_number ||= {}
    @weekday_number[date] ||= (date.wday == 0 ? 7 : date.wday)
  end
end