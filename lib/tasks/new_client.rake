desc 'create a new Client record (and API key)'
task :new_client, [:source_app] => :environment do |_task, args|
  source_app = args[:source_app]
  puts "Creating new Client record for #{source_app}"
  client = Client.create(source_app: source_app)
  puts "New API key: #{client.api_key}"
end
