module Listable
  def format_description(description, type)
    description = "#{description}".ljust(30) + "#{type}".ljust(15)
    return style_string(description)
  end
  def format_date(start_date, end_date=nil)
    dates = start_date.strftime("%D") if start_date
    dates << " -- " + end_date.strftime("%D") if end_date
    dates = "N/A" if !dates
    return style_string(dates)
  end
  def format_priority(priority)
    value = " ⇧".colorize(:green) if priority == "high"
    value = " ⇨".colorize(:yellow) if priority == "medium"
    value = " ⇩".colorize(:red) if priority == "low"
    value = "" if !priority
    return style_string(value)
  end
  def toggle_highlight
    @highlighted = !@highlighted
  end
  def style_string(string)
    if @highlighted
      string = string.colorize(:blue)
    end
    string
  end
end
