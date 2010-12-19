Delayed::Job.destroy_failed_jobs = false
Delayed::Job.destroy_successful_jobs = false

silence_warnings do
  Delayed::Job.const_set("MAX_ATTEMPTS", 3)
  Delayed::Job.const_set("MAX_RUN_TIME", 1.hours)
end

