import "dart:convert";
import "dart:html";
import "../utilities.dart";

void main() {
  try {
    AnchorElement backLink = querySelector("#backLink");
    Map<String, String> args = getArgs();
    double lat = double.parse(args["lat"]);
    double lng = double.parse(args["lng"]);
    double zoom = double.parse(args["zoom"]);
    backLink.href = "/?lat=$lat&lng=$lng&zoom=$zoom";
  } catch(e) {}
  
  ButtonElement postBtn = querySelector("#postBtn");
  postBtn.onClick.listen(postComment);
}

void postComment(Event e) {
  FormElement form = querySelector("#addCommentForm");
  FormData formData = new FormData(form);
  String path = window.location.pathname;
  String id = path.substring(path.lastIndexOf("/") + 1);
  
  HttpRequest.request("/sighting/info/comment/$id", method: "post", sendData: formData)
    .then((HttpRequest request) {
    form.reset();
    showComment(request.responseText);
  });
}

void showComment(String data) {
  Map json = JSON.decode(data);
  DivElement commentsDiv = querySelector("#comments");
  
  DivElement commentDiv = new DivElement()
    ..classes = ["comment"];
  
  HeadingElement commenter = new HeadingElement.h4()
    ..classes = ["commenter"]
    ..text = json["name"] + ":";
  
  String rComment = json["text"];
  String commentText = "<p>${rComment.replaceAll("\n", "</p><p>")}</p>";
  
  commentDiv..append(commenter)
            ..append(new BRElement())
            ..appendHtml(commentText);
  
  commentsDiv.append(commentDiv);
}