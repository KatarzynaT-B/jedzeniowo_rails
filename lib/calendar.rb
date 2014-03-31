class Calendar
  include DateAndTime
  include DateAndTime::Calculations

  attr_accessor :user, :date

  def initialize(user, date)
    @user = user
    @date = date
  end

  def declare_month_names
    {1 => 'styczeń', 2 => 'luty', 3 => 'marzec', 4 => 'kwiecień', 5 => 'maj', 6 => 'czerwiec',
     7 =>'lipiec', 8 => 'sierpień', 9 => 'wrzesień', 10 => 'październik', 11 => 'listopad', 12 => 'grudzień'}
  end

  def declare_weekday_names
    {1 => 'poniedziałek', 2 => 'wtorek', 3 => 'środa', 4 => 'czwartek', 5 => 'piątek', 6 => 'sobota', 7 => 'niedziela'}
  end

  def weekday_number(date)
    date.wday == 0 ? 7 : date.wday
  end

  def count_days(date)
    Time.days_in_month(date.month, date.year)
  end

end