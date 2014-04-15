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

  def grams_to_kcal(options = [])
    val = options[:protein] || options[:carbs] || options[:fat]
    if options[:protein] || options[:carbs]
      (4.0 * val).round
    elsif options[:fat]
      (9.0 * val).round
    end
  end

  #def protein_g_to_kcal(protein)
  #  (4.0 * protein).round
  #end
  #
  #def carbs_g_to_kcal(carbs)
  #  (4.0 * carbs).round
  #end
  #
  #def fat_g_to_kcal(fat)
  #  (9.0 * fat).round
  #end
end
