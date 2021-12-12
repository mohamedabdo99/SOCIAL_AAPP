class PostModel {
  String? name;
  String? uid;
  String? image;
  String? dataTime;
  String? text;
  String? postImage;



  PostModel({
    this.name,
    this.uid,
    this.image,
    this.dataTime,
    this.text,
    this.postImage,
  });


  PostModel.fromJson( Map<String , dynamic>? json ){
    name = json!['name'];
    uid = json['uid'];
    image = json['image'];
    dataTime = json['dataTime'];
    text = json['text'];
    postImage = json['postImage'];
  }

  Map<String , dynamic>  toMap() {
    return {
      'name' : name,
      'uid' :uid,
      'image' :image,
      'dataTime' :dataTime,
      'text' :text,
      'postImage' :postImage,
    };
  }

}
