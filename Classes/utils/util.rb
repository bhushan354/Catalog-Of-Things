require 'date'
require_relative 'unix_text.color'

def get_non_empty_input(prompt)
  input = nil
  loop do
    print "#{GREEN_COLOR}#{prompt}:#{END_COLOR} "
    input = gets.chomp.strip
    break unless input.empty?

    puts "\"#{prompt}\" cannot be empty. Please try again."
  end
  input
end

def get_date_input(prompt)
  loop do
    print "#{GREEN_COLOR}#{prompt} (YYYY-MM-DD):#{END_COLOR} "
    input = gets.chomp.strip

    case
    when input.casecmp('now').zero? || input.casecmp('today').zero?
      return Date.today
    when input.empty? || input.casecmp('nil').zero? || input.casecmp('null').zero?
      return nil
    else
      begin
        parsed_date = Date.parse(input)
        return parsed_date.strftime('%Y-%m-%d')
      rescue ArgumentError
        puts 'Invalid date format. Please enter a valid date in the format YYYY-MM-DD.'
        puts 'Or insert "now" or "today" to insert the current date.'
      end
    end
  end
end

def get_boolean_input(prompt)
  loop do
    print "#{GREEN_COLOR}#{prompt} (Y/N):#{END_COLOR} "
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
