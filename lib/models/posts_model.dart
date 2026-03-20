class PostModel {
    PostModel({
        required this.listOfPosts,
    });

    final List<ListOfPost> listOfPosts;

    factory PostModel.fromJson(Map<String, dynamic> json){ 
        return PostModel(
            listOfPosts: json["listOfPost"] == null ? [] : List<ListOfPost>.from(json["listOfPost"]!.map((x) => ListOfPost.fromJson(x))),
        );
    }

}

class ListOfPost {
    ListOfPost({
        required this.postId,
        required this.userId,
        required this.username,
        required this.userImage,
        required this.mediaUrl,
        required this.caption,
        required this.likesCount,
    });

    final int? postId;
    final String? userId;
    final String? username;
    final String? userImage;
    final String? mediaUrl;
    final String? caption;
    final String? likesCount;

    factory ListOfPost.fromJson(Map<String, dynamic> json){ 
        return ListOfPost(
            postId: json["postId"],
            userId: json["userId"],
            username: json["username"],
            userImage: json["userImage"],
            mediaUrl: json["mediaUrl"],
            caption: json["caption"],
            likesCount: json["likesCount"],
        );
    }

}
