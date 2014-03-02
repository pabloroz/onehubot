# Description:
#   Submit articles to weekly newsletter
#
# Commands:
#   hubot submit <article_url> with description <description> - submit article to newsletter
#   hubot show tribune - show submitted newsletter articles since the last clean
#   hubot clean tribune - restart tribune
#
# Examples:
#   hubot submit www.google.com with description a good search engine

module.exports = (robot) ->
  robot.respond /submit @?([\w .\-_]+) with description (["'\w: \-_]+)[.!]*$/i, (msg) ->
    url         = msg.match[1].trim()
    description = msg.match[2].trim()
    msg.send "url: #{url}"
    msg.send "description: #{description}"
