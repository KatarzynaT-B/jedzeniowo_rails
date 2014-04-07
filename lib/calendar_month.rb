class CalendarMonth
  include DateAndTime
  include DateAndTime::Calculations
  attr_accessor :date

  def initialize(date)
    @date = date
  end

  # Depending on day of week for month beginning and end of the @date.month,
  # method checks how many days of previous and next month should be displayed
  # so that the calendar's view was filled. If @date.month begins on day other
  # than Monday, the first date displayed should be weekday_number of this day
  # minus 1, else - previous month is not included in view. If @date.month ends
  # on day other than Sunday, the last date displayed should be 7 minus
  # weekday_number for the @date.month, else - next month is not included.
  def all_days_for_month_view
    month_start = @date.beginning_of_month
    month_end = @date.end_of_month
    first = if weekday_number(month_start) > 1
      month_start.ago((weekday_number(month_start) - 1).days).to_date
    else
      month_start
    end
    last = if weekday_number(month_end) < 7
      month_end.advance(days: 7 - weekday_number(month_end))
    else
      month_end
    end
    days_to_display = (first..last).inject([]) do |days_list, day|
      days_list << day
    end

    days_to_display.each_slice(7).to_a
  end

  protected

    #Week starts on Monday (1), ends on Sunday (7)
    def weekday_number(date)
      @weekday_number ||= {}
      @weekday_number[date] ||= (date.wday == 0 ? 7 : date.wday)
    end
end