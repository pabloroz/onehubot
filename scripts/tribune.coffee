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
  robot.respond /submit (.*)/i, (msg) ->
    url = msg.match[1].trim()
    # description = msg.match[2].trim()
    msg.send "ok, got the url"
    msg.reply "whats the title for that url?"
    msg.waitResponse (msg) ->
      title = msg.match[1].trim()
      msg.reply "and please tell me whats \"#{title}\" about"
      msg.waitResponse (msg) ->
        abstract = msg.match[1].trim()
        msg.send "gotcha"
        msg.reply "in which category should I put this article \n 1 - Design \n 2 - Development \n 3 - Business \n 4 - Culture \n 5 - Other"
        msg.waitResponse (msg) ->
          category = msg.match[1].trim()
          catetegory_text = ""
          switch category
            when "1" then catetegory_text = "Design"
            when "2" then catetegory_text = "Development"
            when "3" then catetegory_text = "Business"
            when "4" then catetegory_text = "Culture"
            when "5" then catetegory_text = "Other"
          article = {url: url, title: title, abstract: abstract, category: catetegory_text}
          robot.brain.tribune.push(article)
          msg.send "cool, stored!"

  robot.respond /show tribune/i, (msg) ->
    msg.send robot.brain.tribune

  robot.brain.on 'loaded', ->
    robot.brain.tribune = []