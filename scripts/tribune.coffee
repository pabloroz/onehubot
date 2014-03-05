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
  categories = [
    {id: 1, name: "Design"},
    {id: 2, name: "Development"},
    {id: 3, name: "Business"},
    {id: 4, name: "Culture"},
    {id: 5, name: "Other"}
  ]
  categories_option_message = "in which category should I put this article"
  options_text = categories.map (item) -> "\n #{item.id} - #{item.name}"
  categories_option_message += options_text.join("")

  robot.respond /submit (.*)/i, (msg) ->
    url = msg.match[1].trim()
    msg.send "ok, got the url"
    msg.reply "whats the title for that url?"
    msg.waitResponse (msg) ->
      title = msg.match[1].trim()
      msg.reply "and please tell me whats \"#{title}\" about"
      msg.waitResponse (msg) ->
        abstract = msg.match[1].trim()
        askCategory(msg)
        msg.waitResponse (msg) ->
          selected_category_number = msg.match[1].trim()
          selected_category = categories.filter (item) -> item.id.toString() == selected_category_number
          article = {url: url, title: title, abstract: abstract, category: selected_category[0].name}
          robot.brain.tribune.push(article)
          msg.send "cool, stored!"

  robot.respond /show tribune/i, (msg) ->
    tribune_string = robot.brain.tribune.map (e) ->
      "\nurl: #{e.url}\ntitle: #{e.title}\nabstract: #{e.abstract}\ncategory: #{e.category}"
    msg.send tribune_string.join("\n")

  robot.brain.on 'loaded', ->
    robot.brain.tribune = []

  askCategory = (msg) ->
    msg.send "gotcha"
    msg.reply categories_option_message