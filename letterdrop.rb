require 'mandrill'
require 'json'

begin
  mandrill = Mandrill::API.new 'mandrill-api-key'
  results = mandrill.templates.list
  # [{"publish_name"=>"Example Template",
  #     "from_name"=>"Example Name",
  #     "publish_code"=>
  #     "different than draft content",
  #     "slug"=>"example-template",
  #     "publish_text"=>"Example published text",
  #     "text"=>"Example text",
  #     "publish_from_email"=>"from.email.published@example.com",
  #     "subject"=>"example subject",
  #     "updated_at"=>"2013-01-01 15:30:49",
  #     "published_at"=>"2013-01-01 15:30:40",
  #     "from_email"=>"from.email@example.com",
  #     "publish_from_name"=>"Example Published Name",
  #     "created_at"=>"2013-01-01 15:30:27",
  #     "publish_subject"=>"example publish_subject",
  #     "code"=>"editable content",
  #     "labels"=>["example-label"],
  #     "name"=>"Example Template"}]

  results.each do |result|
    open("./emails/#{result['publish_name']}.html", 'w') { |f|
      f.puts result['publish_code']
    }
  end


rescue Mandrill::Error => e
  # Mandrill errors are thrown as exceptions
  puts "A mandrill error occurred: #{e.class} - #{e.message}"
  # A mandrill error occurred: Mandrill::InvalidKeyError - Invalid API key
  raise
end