class ReelModel {
    ReelModel({
        required this.listOfReels,
    });

    final List<ListOfReel> listOfReels;

    factory ReelModel.fromJson(Map<String, dynamic> json){ 
        return ReelModel(
            listOfReels: json["liostOfReels"] == null ? [] : List<ListOfReel>.from(json["liostOfReels"]!.map((x) => ListOfReel.fromJson(x))),
        );
    }

}

class ListOfReel {
    ListOfReel({
        required this.reelId,
        required this.comments,
        required this.videoUrl,
        required this.caption,
        required this.username,
        required this.likes,
    });

    final int? reelId;
    final String? comments;
    final String? videoUrl;
    final String? caption;
    final String? username;
    final String? likes;

    factory ListOfReel.fromJson(Map<String, dynamic> json){ 
        return ListOfReel(
            reelId: json["reelId"]??0,
            comments: json["comments"]??"",
            videoUrl: json["videoUrl"]??"",
            caption: json["caption"]??"",
            username: json["username"]??"",
            likes: json["likes"]??"",
        );
    }

}
