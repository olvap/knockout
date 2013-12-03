class @PostListViewModel
  constructor: ->
    # Data
    self = this
    @posts = ko.observableArray([])
    @newPostText = ko.observable()

    # Load initial state from server, convert it to Post instances, then populate self.posts
    $.getJSON "/posts.json", (allData) ->
      mappedPosts = $.map(allData, (item) ->
        new Post(item)
      )
      self.posts mappedPosts

$ ->
  ko.applyBindings new PostListViewModel()
