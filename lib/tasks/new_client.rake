require 'json'
require 'aws-sdk-dynamodb'

# It is advised to run this task using scripts/new_client.py in the infrastructure-aws repo:
#  https://github.com/Crown-Commercial-Service/ccs-conclave-document-infrastructure-aws/blob/main/scripts/new_client.py

desc 'create a new Client record (and API key)'
task :new_client, [:source_app] => :environment do |_task, args|
  container_metadata = ENV['ECS_CONTAINER_METADATA_URI_V4']
  api_keys_table_name = ENV['API_KEYS_TABLE_NAME']
  source_app = args[:source_app]

  response = `curl #{container_metadata}/task`

  parsed_response = JSON.parse(response)

  task_arn = parsed_response['TaskARN']

  puts "Task running in #{task_arn}"

  dynamodb = Aws::DynamoDB::Client.new

  client = Client.create(source_app: source_app)
  api_key = client.api_key

  item = {
    'PK' => task_arn,
    'ApiKey' => api_key
  }

  dynamodb.put_item({
                      table_name: api_keys_table_name,
                      item: item
                    })

  puts 'Data inserted into DynamoDB table.'
end
