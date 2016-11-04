require 'aws-sdk'
require_relative 'dl_lib'
require 'yaml'

config = YAML.load_file('aws/credentials.yml')

Aws.config.update(config['test'])

s3 = Aws::S3::Client.new()

bucket = {:name=>'hadl_demo_2',:acl=>'public-read',:source_file=>"1.jpg",:key=>File.basename("1.jpg")}

# create bucket

res_init_bucket = s3.create_bucket({

	acl: bucket[:acl], 
  	bucket: bucket[:name], 
	})

p "Create a bucket |=>'#{bucket[:name]}'"

# put object to bucket

for i in 0...10

	put_bucket = {:name=>'hadl_demo_2',:acl=>'public-read',:source_file=>"1.jpg",:key=>File.basename(i.to_s + ".jpg")}
	res_put_object = s3.put_object({
	  acl: put_bucket[:acl],
	  body: File.read(put_bucket[:source_file]),
	  bucket: put_bucket[:name],
	  key: put_bucket[:key],
	})

	p res_put_object

end

# list bucket

res_list_bucket = s3.list_buckets()

Dl.notice(res_list_bucket.buckets,'bucket')

res_list_bucket.buckets.each {	|value| p "| #{value.name} ----- create at #{value.creation_date} |" }

# list object in bucket

res_obj_in_bucket = s3.list_objects({
	bucket: bucket[:name]
})

d = Dl.notice(res_obj_in_bucket.contents,'Object')

res_obj_in_bucket.contents.each { |value| p "| #{value.key} ----- last_modified #{value.last_modified} |"}


# Download all Object from bucket S3 to download/

res_obj_in_bucket = s3.list_objects({

	bucket: bucket[:name]

})

res_obj_in_bucket.contents.each do |value|

	res_download_from_bucket = s3.get_object({

  		response_target: "download/" + value.key,

  		bucket: bucket[:name],

  		key: value.key
	})

	p res_download_from_bucket.body

end

# Delete a Object in Bucket

obj_key = '7.jpg'

res_delete_obj = s3.delete_object({

	bucket:bucket[:name],

	key:obj_key

	})

p "Delete #{obj_key} success"

