class @PostListViewModel
  constructor: ->
    # Data
    self = this
    @posts = ko.observableArray([])

    @newPostTitle = ko.observable()
    @newPostBody  = ko.observable()
    @chosenPostData = ko.observable()
    @chosenPostToEdit = ko.observable()

    @editPostId = ko.observable()
    @editPostTitle  = ko.observable()
    @editPostBody  = ko.observable()

    @addPost = ->
      post = new Post(name: @newPostTitle(), body: @newPostBody())
      self.create(post)

    @editPost = (post)->
      $.get "/posts/#{post.id}.json", {}, self.chosenPostToEdit

    @removePost = (post) ->
      self.posts.destroy post

    @showPost = (post) ->
      $.get "/posts/#{post.id}.json", {}, self.chosenPostData

    @update = ->
      console.log @chosenPostToEdit
      $.ajax "/posts/1.json",
        data: ko.toJSON()
        type: "put"
        contentType: "application/json"
        success: (result) ->
          self.posts.push result
          self.newPostTitle ""
          self.newPostBody ""

    @create = (post)->
      $.ajax "/posts.json",
        data: ko.toJSON(post: post)
        type: "post"
        contentType: "application/json"
        success: (result) ->
          self.posts.push result
          self.newPostTitle ""
          self.newPostBody ""

    # Load initial state from server, convert it to Post instances, then populate self.posts
    $.getJSON "/posts.json", (allData) ->
      mappedPosts = $.map(allData, (item) ->
        new Post(item)
      )
      self.posts mappedPosts

$ ->
  ko.applyBindings new PostListViewModel()
