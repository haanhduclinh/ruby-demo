require "right_aws"
require "right_http_connection"

sqs = RightAws::SqsGen2.new("AKIA","bWksa23",:server=>"localhost",:port=>9324,:protocol=>"http")
queue = sqs.queue("awesome_queue")
for i in 0...1000
	message = "Day la tin nhan thu #{i}"
	queue.send_message(message)
	puts message
end

# ss = queue.receive_messages(1,10)
# puts ss #prints Hi Queue
# puts queue.name #prints awesome_queue