# require "right_aws"
require 'aws-sdk'
# sqs = RightAws::SqsGen2.new("12121212","121212",{:server=>"localhost",:port=>9324,:protocol=>"http"})
# queue = sqs.queue("awesome_queue")
# # queue.send_message("Hi Queue")
# message1 = queue.receive
# # unless message1 || message1 != ''
# 	message1.visibility = 0
# 	puts message1
# # else
	# puts 'There are no data'
# end
#queue.delete_message(ss)
#prints Hi Queue
# puts queue.name #prints awesome_queue
poller = Aws::SQS::QueuePoller.new('us-west-2',{:server=>"localhost",:port=>9324,:protocol=>"http"})

poller.poll do |msg|
  puts msg.body
end