module Listable
  def format_description(description, type)
    "#{description}".ljust(30) + "#{type}".ljust(15)
  end
  def format_date(start_date, end_date=nil)
    dates = start_date.strftime("%D") if start_date
    dates << " -- " + end_date.strftime("%D") if end_date
    dates = "N/A" if !dates
    return dates
  end
  def format_priority(priority)
    value = " ⇧".colorize(:green) if priority == "high"
    value = " ⇨".colorize(:yellow) if priority == "medium"
    value = " ⇩".colorize(:red) if priority == "low"
    value = "" if !priority
    return value
  end
end
