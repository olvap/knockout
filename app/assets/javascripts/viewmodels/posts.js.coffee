class @PostListViewModel
  constructor: ->
    # Data
    self = this
    @posts = ko.observableArray([])
    @newPostText = ko.observable()


    self.addPost = ->
      post = new Post(name: @newPostText())
      self.save(post)

    self.removePost = (post) ->
      self.posts.destroy post

    self.save = (post)->
      $.ajax "/posts.json",
        data: ko.toJSON(post: post)
        type: "post"
        contentType: "application/json"
        success: (result) ->
          self.posts.push post
          self.newPostText ""

    # Load initial state from server, convert it to Post instances, then populate self.posts
    $.getJSON "/posts.json", (allData) ->
      mappedPosts = $.map(allData, (item) ->
        new Post(item)
      )
      self.posts mappedPosts

$ ->
  ko.applyBindings new PostListViewModel()
