class CalendarMonth
  include DateAndTime
  include DateAndTime::Calculations
  attr_accessor :date

  def initialize(date)
    @date = date
  end

  #Depending on day of week for month beginning and end of the @date.month, method checks how many days of previous and next month should be displayed
  #so that the calendar's view was filled. If @date.month begins on day other than Monday, the first date displayed should be weekday_number of this
  #day minus 1, else - previous month is not included in view. If @date.month ends on day other than Sunday, the last date displayed should be
  #7 minus weekday_number for this day, else - next month is not included in view.
  def all_days_for_month_view
    first_of_month = @date.beginning_of_month
    last_of_month = @date.end_of_month
    display_begin = ((weekday_number(first_of_month) > 1) ? first_of_month.ago((weekday_number(first_of_month) - 1).days).to_date : first_of_month)
    display_end = ((weekday_number(last_of_month) < 7) ? last_of_month.advance(days: 7 - weekday_number(last_of_month)) : last_of_month)

    days_to_display = (display_begin..display_end).inject([]) { |days_list, day| days_list << day }

    days_to_display.each_slice(7).to_a
  end

  protected

    #Week starts on Monday (1), ends on Sunday (7)
    def weekday_number(date)
    @weekday_number ||= {}
    @weekday_number[date] ||= (date.wday == 0 ? 7 : date.wday)
  end
end