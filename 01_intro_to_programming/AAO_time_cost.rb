def AAO_length(arr)
  arr.each do |hours_per_day|
  total_days = 1500 / hours_per_day
  total_month = total_days / 30
  puts "Working " + hours_per_day.to_s + " hours per day,\nIt would take you approx. " + total_days.to_s + " days (±" + total_month.to_s + " months) to finish the program";
  puts
  end
end
# p finishAAO([12,8])

def aao_time_investment(min, max, total_h_estimate=2000)
  puts "AppAcademy Online time investment calculator "
  puts "- - - - - - - - - - - - - - - - - - - - - - -"
  while min <= max
    days = total_h_estimate / min
    months = days / 30
    puts min.to_s + "\t\t hours/Day\t\t" + days.to_s + "\t days\t\t" + months.to_s + "\t\t months"
    min += 1
  end
  puts "- - - - - - - - - - - - - - - - - - - - - - -"
  puts "BASED ON ESTIMATED TOTAL HOURS: " + total_h_estimate.to_s
  puts "- - - - - - - - - - - - - - - - - - - - - - -"
end
# aao_time_investment(2,12)

#### Add Sources:
# kpatel737
# "Without any external help, my optimistic estimate would be 2,000 hours"
# https://www.reddit.com/r/learnprogramming/comments/9oq32j/app_academy_is_making_its_entire_fullstack/
