function PostListViewModel() {
    // Data
    var self = this;
    self.posts = ko.observableArray([]);
    self.newPostText = ko.observable();

    // Load initial state from server, convert it to Post instances, then populate self.posts
    $.getJSON("/posts.json", function(allData) {
        var mappedPosts = $.map(allData, function(item) { return new Post(item) });
        self.posts(mappedPosts);
    });
}

$(function() {
   ko.applyBindings(new PostListViewModel());
});
