require 'aws-sdk'
require 'yaml'

config = YAML.load_file('aws/credentials.yml')

Aws.config.update(config['test'])

sqs = Aws::SQS::Client.new()

queue_name = 'awesome_queue_1'

#create queue

res = sqs.create_queue(queue_name:queue_name)

if res['queue_url']

	queue_url = res['queue_url']

	p 'Create queue success'

else

	p 'Error. Can not create queur'

	exit

end

#send message

for i in 0...100

	time = Time.now.utc

	message = "This is the message No. #{i.to_s} at #{time}"

	res = sqs.send_message({

		queue_url:queue_url,

		message_body:message,

	})
	if res.to_h[:md5_of_message_body]

		p "Success send | #{message}"

	else

		p "Error. Can not sent data"

		exit

	end

end