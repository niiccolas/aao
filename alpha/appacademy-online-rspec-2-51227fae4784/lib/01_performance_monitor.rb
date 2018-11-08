def measure(num = 1, &prc)
  # save into variable Time at beginning of method
  start_time = Time.now
  # call num times the proc passed to measure
  num.times { prc.call }
  # return the average of: time elapsed / num times the proc was called
  (Time.now - start_time) / num
end

# puts measure { sleep 3 } # => ± 3
