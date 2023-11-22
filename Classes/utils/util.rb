def get_non_empty_input(prompt)
  input = nil
  loop do
    print "#{prompt}: "
    input = gets.chomp.strip
    break unless input.empty?

    puts "\"#{prompt}\" cannot be empty. Please try again."
  end
  input
end

def get_date_input(prompt)
  loop do
    print "#{prompt} (YYYY-MM-DD): "
    input = gets.chomp.strip

    case
    when /^\d{4}-\d{2}-\d{2}$/.match?(input)
      return input
    when input.casecmp('now').zero? || input.casecmp('today').zero?
      return Date.today
    when input.empty? || input.casecmp('nil').zero? || input.casecmp('null').zero?
      return nil
    else
      puts 'Invalid date format. Please enter a date in the format YYYY-MM-DD.'
    end
  end
end

def get_boolean_input(prompt)
  loop do
    print "#{prompt} (Y/N): "
    input = gets.chomp.strip.downcase

    case input
    when 'y'
      return true
    when 'n'
      return false
    else
      puts 'Invalid input. Please enter Y/N.'
    end
  end
end
