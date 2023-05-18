module Timer
  def start_timer
    @start = Time.current
  end

  def time_elapsed_in_milliseconds
    (time_elpased * 1000).round(4)
  end

  def time_elpased
    Time.current.to_f - @start.to_f
  end
end
