### 
  Blogo v0.0.1
  Fetch and display RSS feeds
###
(($) ->
  $.fn.blogo = (options = {}) ->
    googleFeed = 'https://ajax.googleapis.com/ajax/services/feed/load?v=1.0&callback=?'
    default_options =
      layout: '<h3><a href="ENTRY_URL" target="_blank">ENTRY_TITLE</a></h3><p>ENTRY_SNIPPET <a href="ENTRY_URL" target="_blank">Read More</a></p>'
      numPosts: 3

    opts = $.extend {}, default_options, options

    @each ->

      that = this

      $.getJSON googleFeed, {q: opts.feed, num: opts.numPosts}, (data, textStatus, jqXHR) ->

        result = []
        $.each data.responseData.feed.entries, (i, entry) ->
          result.push(
            opts.layout.replace(/ENTRY_TITLE/g, entry.title)
              .replace(/ENTRY_SNIPPET/g, entry.contentSnippet)
              .replace( /ENTRY_URL/g, entry.link)
          )

        $(that).append result.join ''

)(jQuery)
