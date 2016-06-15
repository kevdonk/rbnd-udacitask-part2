class UdaciList
  attr_reader :title, :items

  def initialize(options={})
    @title = options[:title] ? options[:title] : "Untitled List"
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
    allowed_types = { todo: TodoItem, link: LinkItem, event: EventItem }
    if allowed_types.keys.include? type.to_sym
      @items.push allowed_types[type.to_sym].new(type, description, options)
    else
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
  def toggle_highlight(index)
    @items[index-1].toggle_highlight
  end
  def all
    if @title
      title_art = Artii::Base.new :font => 'big'
      puts "-" * @title.length * 5
      puts title_art.asciify(@title)
      puts "-" * @title.length * 5
    end
    @items.each_with_index do |item, position|
      puts "#{position + 1}) #{item.details}"
    end
  end
  def filter(item_type)
    @items.select{ |item| item.type == item_type }
  end
  def change_priority(index, priority)
    if @items[index-1].type == "todo"
      @items[index-1].priority = priority
    end
  end
end
