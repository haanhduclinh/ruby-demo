require 'aws-sdk'

require 'yaml'

require './dl_lib'

config = YAML.load_file('aws/credentials.yml')

Aws.config.update(config['test'])

@dynamodb ||= Aws::DynamoDB::Client.new

#create table

table_name = 'tbl_products'

# res_create_table = dynamodb.create_table(
#     table_name: table_name,
#     attribute_definitions: [
#       {
#         attribute_name: :product_id,
#         attribute_type: :S,
#       },
#       {
#         attribute_name: :city,
#         attribute_type: :S
#       }
#     ],
#     key_schema: [
#       {
#         attribute_name: :user_id,
#         key_type: :HASH
#       },
#       {
#         attribute_name: :city,
#         key_type: :RANGE
#       }
#     ],
#     provisioned_throughput: {
#       read_capacity_units: 10,
#       write_capacity_units: 10
#     }
#   )
# if res_create_table.table_description.table_status == "ACTIVE" then p "Create '#{table_name}' successed at #{res_create_table.table_description.creation_date_time}" else p 'Err. Can not create table' end

#list all tables

# res_list_table = dynamodb.list_tables()

# Dl.notice(res_list_table.table_names,'table')

# res_list_table.table_names.each {	|value| p "| #{value} |" }

#put items

for i in 0..100

	res_put_items = dynamodb.put_item({

	  table_name: table_name,

	  item: {

	    :user_id => "haanhduclinh#{i}@yahoo.com",
	    :city => "Hai Duong #{i}",

	  }

	  })

	p "Create new item #{i}"

end

#get data from table

# res_table_data = dynamodb.scan({
#   	table_name: table_name
#   })

# p res_table_data.items

#delete item from table

# res_delete_item_from_table = dynamodb.delete_item({

# 	table_name:table_name,
# 	key:{
# 		:user_id => "haanhduclinh@yahoo.com",
# 		:city => "Hai Duong"
# 	}
# 	})
# p res_delete_item_from_table.attributes

#update item

res_update_item_from_table = dynamodb.update_item({
	table_name:table_name,
	key:{
		:user_id => "haanhduclinh1@yahoo.com",
		:city => "Hai Duong 1"
	},
	attribute_updates: {
	    :city => {
	      value: "Thay dia chi",
	      action: "PUT", # accepts ADD, PUT, DELETE
	    }
  }
	})

p res_table_data