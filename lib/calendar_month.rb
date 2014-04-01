class CalendarMonth
  include DateAndTime
  include DateAndTime::Calculations

  def initialize(date)
    @date = date
  end

  def declare_month_names
    {1 => 'styczeń', 2 => 'luty', 3 => 'marzec', 4 => 'kwiecień', 5 => 'maj', 6 => 'czerwiec',
     7 =>'lipiec', 8 => 'sierpień', 9 => 'wrzesień', 10 => 'październik', 11 => 'listopad', 12 => 'grudzień'}
  end

  def declare_weekday_names
    {1 => 'poniedziałek', 2 => 'wtorek', 3 => 'środa', 4 => 'czwartek', 5 => 'piątek', 6 => 'sobota', 7 => 'niedziela'}
  end

  def weekday_number
    @date.wday == 0 ? 7 : @date.wday
  end

  def count_days
    Time.days_in_month(@date.month, @date.year)
  end

  def build_weeks_array
    weeks = self.count_number_of_weeks
    first_day_of_second_week = ((first_week(@date))[-1].split(" "))[0].to_i + 1
    weeks_for_month = {}
    weeks_for_month[0] = first_week(@date)
    i = 1
    starting_step = 0
    while i < weeks - 1
      weeks_for_month[i] = each_middle_week(first_day_of_second_week + starting_step, @date)
      i += 1
      starting_step += 7
    end
    weeks_for_month[weeks - 1] = last_week(@date)
    weeks_for_month
  end

  def count_number_of_weeks
    first_of_month = weekday_number
    days_after_first_sunday = count_days - (8 - first_of_month)
    (days_after_first_sunday % 7 > 0) ? (2 + days_after_first_sunday / 7) : (1 + days_after_first_sunday / 7)
  end

  def first_week(date)
    list_end_days_for_month.concat(list_days_till_sunday)
  end

  def each_middle_week(start_day, date)
    months = declare_month_names
    week = []
    (0..6).each do |i|
      week << "#{start_day + i} #{months[date.month]}"
    end
    week
  end

  def last_week(date)
    if weekday_number(date.end_of_month) == 7
      start_day = 6.days.ago(date.end_of_month).day
      each_middle_week(start_day, date)
    else
      date_new = date.end_of_month.tomorrow
      (list_end_days_for_month(date_new)).concat(list_days_till_sunday(date_new))
    end
  end

  def list_end_days_for_month(date)
    months = declare_month_names
    first_of_month = weekday_number(date.beginning_of_month)
    prev_month_date = date.beginning_of_month.yesterday
    days_in_prev_month = count_days(prev_month_date)
    prev_month_days_list = []
    while first_of_month > 1
      prev_month_days_list << "#{days_in_prev_month} #{months[prev_month_date.month]}"
      first_of_month -= 1
      days_in_prev_month -=1
    end
    prev_month_days_list.reverse!
  end

  def list_days_till_sunday(date)
    months = declare_month_names
    first_of_month = weekday_number(date.beginning_of_month)
    current_month_days_first_week = []
    current_month_day = 1
    until first_of_month > 7
      current_month_days_first_week << "#{current_month_day} #{months[date.month]}"
      current_month_day += 1
      first_of_month += 1
    end
    current_month_days_first_week
  end

end