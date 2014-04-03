module ApplicationHelper
  def full_title(page_title)
    base_title = "Jedzeniowo"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def explain_errors(object)
    errors = []
    object.errors.messages.each_value { |msg| errors << msg }
    errors.flatten
  end
end
