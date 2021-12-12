class UserModel {
  String? name;
  String? email;
  String? phone;
  String? uid;
  String? bio;
  String? image;
  String? cover;
  bool? isVerification;


  UserModel({
       this.name,
       this.email,
       this.phone,
       this.uid,
       this.bio,
       this.image,
       this.cover,
       this.isVerification,
  });


  UserModel.fromJson( Map<String , dynamic>? json ){
    name = json!['name'];
    email = json['email'];
    phone = json['phone'];
    uid = json['uid'];
    bio = json['bio'];
    image = json['image'];
    cover = json['cover'];
    isVerification = json['isVerification'];
  }

  Map<String , dynamic>  toMap() {
    return {
      'name' : name,
      'email' :email,
      'phone' :phone,
      'uid' :uid,
      'image' :image,
      'cover' :cover,
      'bio' :bio,
      'isVerification' :isVerification,
    };
}

}
