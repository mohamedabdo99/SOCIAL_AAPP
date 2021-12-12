abstract class SocialLayoutScreenStates {}

class SocialInitialLayout extends SocialLayoutScreenStates{}

class SocialGetUserLoadingLayoutState extends SocialLayoutScreenStates{}

class SocialLayoutGetUserSuccessState extends SocialLayoutScreenStates{}

class SocialLayoutGetUserErrorState extends SocialLayoutScreenStates{
  final String error ;
  SocialLayoutGetUserErrorState(this.error);
}
// get all users

class SocialGetAllUserLoadingLayoutState extends SocialLayoutScreenStates{}

class SocialLayoutGetAllUserSuccessState extends SocialLayoutScreenStates{}

class SocialLayoutGetAllUserErrorState extends SocialLayoutScreenStates{
  final String error ;
  SocialLayoutGetAllUserErrorState(this.error);
}

class SocialLayoutChangeNavState extends SocialLayoutScreenStates {}

class SocialLayoutAddPostState extends SocialLayoutScreenStates {}

class SocialImageProfilePickerSuccessState extends SocialLayoutScreenStates {}

class SocialImageProfilePickerErrorState extends SocialLayoutScreenStates {}

class SocialCoverProfilePickerSuccessState extends SocialLayoutScreenStates {}

class SocialCoverProfilePickerErrorState extends SocialLayoutScreenStates {
}

class SocialImageProfileUploadSuccessState extends SocialLayoutScreenStates {}

class SocialImageProfileUploadErrorState extends SocialLayoutScreenStates {
}

class SocialCoverProfileUploadSuccessState extends SocialLayoutScreenStates {}

class SocialCoverProfileUploadErrorState extends SocialLayoutScreenStates {}

class SocialUpdateLoadingState extends SocialLayoutScreenStates {}

class SocialUpdateSuccessState extends SocialLayoutScreenStates {}

class SocialUpdateErrorState extends SocialLayoutScreenStates {}
//create post
class SocialCreatePostLoadingState extends SocialLayoutScreenStates {}

class SocialCreatePostSuccessState extends SocialLayoutScreenStates {}

class SocialCreatePostErrorState extends SocialLayoutScreenStates {}

// post image
class SocialPostImagePickerSuccessState extends SocialLayoutScreenStates {}

class SocialPostImagePickerErrorState extends SocialLayoutScreenStates {}

class SocialRemovePostImageState extends SocialLayoutScreenStates {}

// get posts

class SocialGetPostsLayoutState extends SocialLayoutScreenStates{}

class SocialGetPostsSuccessState extends SocialLayoutScreenStates{}

class SocialGetPostsErrorState extends SocialLayoutScreenStates{
  final String error ;
  SocialGetPostsErrorState(this.error);
}

// add post like
class SocialCreatePostLikeSuccessState extends SocialLayoutScreenStates{}

class SocialCreatePostLikeErrorState extends SocialLayoutScreenStates{
  final String error ;
  SocialCreatePostLikeErrorState(this.error);
}

// add post comment
class SocialCreatePostCommentSuccessState extends SocialLayoutScreenStates{}

class SocialCreatePostCommentErrorState extends SocialLayoutScreenStates{
  final String error ;
  SocialCreatePostCommentErrorState(this.error);
}
//chat

class SocialSendMessageSuccessState extends SocialLayoutScreenStates{}

class SocialSendMessageErrorState extends SocialLayoutScreenStates{
  final String error;

  SocialSendMessageErrorState(this.error);
}

class SocialGetAllMessageSuccessState extends SocialLayoutScreenStates{

}

class SocialGetAllMessageErrorState extends SocialLayoutScreenStates{
  final String error;

  SocialGetAllMessageErrorState(this.error);
}