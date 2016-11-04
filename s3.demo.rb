require 'aws-sdk'
require_relative 'dl_lib'

Aws.config.update({
  :access_key_id => "x",
  :secret_access_key => "y",
  :region => "localhost",
  :s3 => {
  	:endpoint=>"http://localhost:4567"
  }
	})

s3 = Aws::S3::Client.new()

bucket = {:name=>'hadl_demo_2',:acl=>'public-read',:source_file=>"1.jpg",:key=>File.basename("1.jpg")}

#create bucket

res_init_bucket = s3.create_bucket({

	acl: bucket[:acl], 
  	bucket: bucket[:name], 
	})

p "Create a bucket |=>'#{bucket[:name]}'"

#put object to bucket

res_put_object = s3.put_object({
  acl: bucket[:acl],
  body: bucket[:source_file],
  bucket: bucket[:name],
  key: bucket[:key],
})

p res_put_object

#list bucket

res_list_bucket = s3.list_buckets()

Dl.notice(res_list_bucket.buckets,'bucket')

res_list_bucket.buckets.each {	|value| p "| #{value.name} ----- create at #{value.creation_date} |" }

#list object in bucket

res_obj_in_bucket = s3.list_objects({
	bucket: bucket[:name]
})

d = Dl.notice(res_obj_in_bucket.contents,'Object')

res_obj_in_bucket.contents.each { |value| p "| #{value.key} ----- last_modified #{value.last_modified} |"}