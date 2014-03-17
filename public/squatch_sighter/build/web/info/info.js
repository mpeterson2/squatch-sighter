$(document).ready(function() {
	// TODO when converting to javascript, make this work correctly.
	$("#backLink").attr("href", "/?lat=45&lng=90&zoom=4")
})

function postComment() {
	var form = $("#addCommentForm")
	var path = window.location.pathname
	var id = path.substr(path.lastIndexOf("/") + 1)
	
	$.post("/sighting/info/comment/" + id, form.serialize(), function(data) {
		showComment(data)
		form[0].reset()
	})
}

function showComment(data) {
	var commentsDiv = $("#comments")

	// Create the comment Div.
	var commentDiv = $("<div />", {
		class: "comment"
	})

	// Create the commenter.
	var commenter = $("<h4 />", {
		class: "commenter",
		text: data.name + ":"
	})

	// Create paragraphs out of p tags.
	var comText = "<p>" + data.text.split("\n").join("</p><p>") + "</p>"

	// Build the comment div.
	commentDiv.append(commenter)
	commentDiv.append($("<br />"))
	commentDiv.append(comText)

	// Add it to the DOM
	commentsDiv.append(commentDiv)
}