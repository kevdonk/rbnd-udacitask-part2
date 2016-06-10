class UdaciList
  attr_reader :title, :items

  def initialize(options={})
    @title = options[:title]
    @items = []
  end
  def add(type, description, options={})
    type = type.downcase
    valid_priorities = ["low", "medium", "high"]
    if options[:priority]
      if !valid_priorities.include? options[:priority]
        raise UdaciListErrors::InvalidPriorityValue, "Invalid priority #{options[:priority]}, choose from #{valid_priorities}"
      end
    end
    original_length = @items.length
    @items.push TodoItem.new(description, options) if type == "todo"
    @items.push EventItem.new(description, options) if type == "event"
    @items.push LinkItem.new(description, options) if type == "link"
    if (@items.length - original_length) < 1
      raise UdaciListErrors::InvalidItemType, "Type '#{type}' not supported"
    end
  end
  def delete(index)
    if index > @items.length
      raise UdaciListErrors::IndexExceedsListSize, "Attempted to delete item that is not in the list"
    else
      @items.delete_at(index - 1)
    end
  end
  def all
    if @title
      puts "-" * @title.length
      puts @title
      puts "-" * @title.length
    end
    @items.each_with_index do |item, position|
      puts "#{position + 1}) #{item.details}"
    end
  end
end
