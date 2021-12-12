import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/message_model/message_model.dart';
import 'package:social_app/models/user_model/post_model.dart';
import 'package:social_app/models/user_model/user_model.dart';
import 'package:social_app/moduls/chats/chats_screen.dart';
import 'package:social_app/moduls/feeds/feeds_screen.dart';
import 'package:social_app/moduls/new_post/new_post_screen.dart';
import 'package:social_app/moduls/settings/settings_screen.dart';
import 'package:social_app/moduls/users/users_screen.dart';
import 'package:social_app/shared/contants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SocialLayoutCubit extends Cubit<SocialLayoutScreenStates> {
  SocialLayoutCubit() : super(SocialInitialLayout());

  // INSTANCE

  static SocialLayoutCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;

  void getUserData() {
    emit(SocialGetUserLoadingLayoutState());

    FirebaseFirestore.instance.collection("Users").doc(uId).get().then((value) {
      userModel = UserModel.fromJson(value.data());
      emit(SocialLayoutGetUserSuccessState());
      print(userModel!.email);
    }).catchError((error) {
      emit(SocialLayoutGetUserErrorState(error.toString()));
    });
  }

  int currentIndex = 0;

  List<Widget> screen = [
    FeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];

  List<String> title = [
    'Feeds',
    'Chats',
    'Post',
    'Users',
    'Profile',
  ];

  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: "Feeds",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.chat),
      label: "Chats",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.add),
      label: "Post",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.location_on),
      label: "users",
    ),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
  ];

  void changeBottomIndex(int index) {
    if(index == 1 )
      getAllUsers();
    if (index == 2)
      emit(SocialLayoutAddPostState());
    else {
      currentIndex = index;
      emit(SocialLayoutChangeNavState());
    }
  }

  File? profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialImageProfilePickerSuccessState());
    } else {
      print('No image selected');
      emit(SocialImageProfilePickerErrorState());
    }
  }

  File? coverImage;

  Future<void> getCoverImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialCoverProfilePickerSuccessState());
    } else {
      print('No image selected');
      emit(SocialCoverProfilePickerErrorState());
    }
  }

  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUpdateLoadingState());
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // emit(SocialImageProfileUploadSuccessState());
        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          profile: value,
        );
      }).catchError((error) {
        emit(SocialImageProfileUploadErrorState());
      });
    }).catchError((error) {
      emit(SocialImageProfileUploadErrorState());
    });
  }

  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUpdateLoadingState());

    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // emit(SocialCoverProfileUploadSuccessState());
        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          cover: value,
        );
      }).catchError((error) {
        emit(SocialCoverProfileUploadErrorState());
      });
    }).catchError((error) {
      emit(SocialCoverProfileUploadErrorState());
    });
  }

  // void updateUserData({
  //   required String name,
  //   required String phone,
  //   required String bio,
  // }) {
  //   emit(SocialUpdateLodaingState());
  //
  //   if (coverImage != null) {
  //     uploadCoverImage();
  //   } else if (profileImage != null) {
  //     uploadProfileImage();
  //   } else if (coverImage != null && profileImage != null) {
  //     uploadProfileImage();
  //     uploadCoverImage();
  //   } else {
  //     updateUser(
  //       name: name,
  //       phone: phone,
  //       bio: bio,
  //     );
  //   }
  // }

  void updateUser({
    required String name,
    required String phone,
    required String bio,
    String? profile,
    String? cover,
  }) {
    {
      UserModel model = UserModel(
        name: name,
        phone: phone,
        bio: bio,
        email: userModel!.email,
        uid: userModel!.uid,
        image: profile ?? userModel!.image,
        cover: cover ?? userModel!.cover,
        isVerification: false,
      );
      FirebaseFirestore.instance
          .collection("Users")
          .doc(userModel!.uid)
          .update(model.toMap())
          .then((value) {
        getUserData();
      }).catchError((error) {
        emit(SocialUpdateErrorState());
      });
    }
  }

  File? postImage;

  Future<void> getPostImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialPostImagePickerSuccessState());
    } else {
      print('No image selected');
      emit(SocialPostImagePickerErrorState());
    }
  }

  void removePostImage(){
    postImage = null;
    emit(SocialRemovePostImageState());
  }

  void uploadPostImage({
    required String dataTime,
    required String text,
  }) {
    emit(SocialCreatePostLoadingState());
    FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        crateNewPost(
          dataTime: dataTime,
          text: text,
          postImage: value as String,
        );
      }).catchError((error)
      {
        emit(SocialCreatePostErrorState());
      });
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  void crateNewPost({
    required String dataTime,
    required String text,
    String? postImage,
  }) {
    {
      emit(SocialCreatePostLoadingState());
      print("*************");
      PostModel model = PostModel(
        name: userModel!.name,
        dataTime: dataTime,
        text: text,
        uid: userModel!.uid,
        image: userModel!.image,
        postImage: postImage ?? '',
      );
      FirebaseFirestore.instance
          .collection("Posts")
          .add(model.toMap())
          .then((value) {
        emit(SocialCreatePostSuccessState());
      }).catchError((error) {
        emit(SocialCreatePostErrorState());
      });
    }
  }

  List<PostModel> posts = [];

  List<String> postsId = [];

  List<int> likes = [];

  void getPosts()
  {
   FirebaseFirestore.instance
        .collection('Posts')
       .get()
       .then((value) {
         value.docs.forEach((element) {
           element.reference
               .collection('Likes')
               .get()
               .then((value)
           {
                 likes.add(value.docs.length);
                 postsId.add(element.id);
                 posts.add(PostModel.fromJson(element.data()));
           })
               .catchError((error){
                 
           });
           
         });
         emit(SocialGetPostsSuccessState());
   })
       .catchError((error){
     emit(SocialGetPostsErrorState(error.toString()));
   });
  }

  void createLike(String postId)
  {
    FirebaseFirestore.instance
        .collection('Posts')
        .doc(postId)
        .collection('Likes')
        .doc(userModel!.uid)
        .set({
        'like' : true,
    })
        .then((value) {
          emit(SocialCreatePostLikeSuccessState());
    })
        .catchError((error){
      emit(SocialCreatePostLikeErrorState(error.toString()));
    });
  }

  void createComment(String postId){
    FirebaseFirestore.instance
        .collection('Posts')
        .doc(postId)
        .collection('Comment')
        .doc(userModel!.uid)
        .set({
      'comment' : true,
    })
        .then((value) {
      emit(SocialCreatePostCommentSuccessState());
    })
        .catchError((error){
      emit(SocialCreatePostCommentErrorState(error.toString()));
    });
  }

  List<UserModel> users = [];

  void getAllUsers() {
    if(users.length == 0)
      FirebaseFirestore.instance
          .collection('Users')
          .get()
          .then((value) {
        value.docs.forEach((element)
        {
          if(element.data()['uid'] != userModel!.uid)
            users.add(UserModel.fromJson(element.data()));
            emit(SocialLayoutGetAllUserSuccessState());
        });
      })
          .catchError((error) {
        emit(SocialLayoutGetAllUserErrorState(error.toString()));
      });
  }

  void sendMessage({
  required String receiverId,
  required String dateTime,
  required String text,
}){

    MessageModel model = MessageModel(
      text: text,
      senderId: userModel!.uid,
      dateTime: dateTime,
      receiverId: receiverId,
    );

    // my chat
    FirebaseFirestore.instance
        .collection('Users')
        .doc(userModel!.uid)
        .collection('chats')
        .doc(receiverId)
        .collection('message')
        .add(model.toMap())
    .then((value) {
      emit(SocialSendMessageSuccessState());
    })
    .catchError((error){
      emit(SocialSendMessageErrorState(error.toString()));
    });
  //  receiver chat
    FirebaseFirestore.instance
        .collection('Users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel!.uid)
        .collection('message')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    })
        .catchError((error){
      emit(SocialSendMessageErrorState(error.toString()));
    });

  }

  List<MessageModel> messages = [];

  void getMessages({
    required String receiverId,

  }){
    FirebaseFirestore.instance
        .collection('Users')
        .doc(userModel!.uid)
        .collection('chats')
        .doc(receiverId)
        .collection('message')
        .orderBy('dateTime')
        .snapshots()
        .listen((event)
    {
        messages = [];
       event.docs.forEach((element) {
         messages.add(MessageModel.fromJson(element.data()));
       });
       emit(SocialGetAllMessageSuccessState());
    });
  }
}
