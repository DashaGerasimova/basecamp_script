require './request'
require 'highline'
require 'json'

cli = HighLine.new
user = cli.ask("Enter your basecamp username:")
account_id = cli.ask("Enter account_id:")
password = cli.ask("Enter your password:  ") { |q| q.echo = "*" }

link = "https://basecamp.com/#{account_id}/api/v1/"

# GET /people.json
response = Request.new(link + "people.json", user, password).get
people = JSON.parse(response.body)

people.each do |person|
  response = Request.new(link + "people/#{person["id"]}/projects.json", user, password).get
  projects = JSON.parse(response.body)
  Request.new(link + "people/#{person["id"]}.json", user, password).delete if projects.empty?
end
