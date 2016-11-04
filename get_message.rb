require 'aws-sdk'


Aws.config.update({
  :access_key_id => "x",
  :secret_access_key => "y",
  :region => "localhost",
  :sqs => {
  	:endpoint=>"http://localhost:9324"
  }
	})

sqs = Aws::SQS::Client.new

queue_name = 'awesome_queue'

#list queues

res = sqs.list_queues({
  queue_name_prefix:queue_name
})

list_q = res['queue_urls']

unless list_q.length > 0

	p "There aren't chanel with keyword #{queue_name}"
	exit

end

for i in 0...list_q.length

	queue_url = list_q[i]

	#polling data from this chanel

	poller = Aws::SQS::QueuePoller.new(queue_url)

	poller.poll do |msg|

	  puts msg.body

	end

end
