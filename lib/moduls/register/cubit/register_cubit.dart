import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user_model/user_model.dart';
import 'package:social_app/moduls/register/cubit/states_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  // INSTANCE
  static RegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      createUser(
        name: name,
        phone: phone,
        email: email,
        uid: value.user!.uid,
      );
    }).catchError((error) {
      emit(RegisterErrorState(error.toString()));
    });
  }

  void createUser({
    required String name,
    required String phone,
    required String email,
    required String uid,
  }) {
    UserModel model = UserModel(
      name: name,
      phone: phone,
      email: email,
      uid: uid,
      bio: 'write a bio here',
      image: 'https://img.freepik.com/free-photo/discontent-female-model-with-black-skin-picks-up-trash-points-plastic-wastes-displeasure-does-volunteer-work-protects-environment-stands-blue-wall-with-free-space-your-text_273609-26480.jpg?size=338&ext=jpg',
      cover: 'https://img.freepik.com/free-photo/discontent-female-model-with-black-skin-picks-up-trash-points-plastic-wastes-displeasure-does-volunteer-work-protects-environment-stands-blue-wall-with-free-space-your-text_273609-26480.jpg?size=338&ext=jpg',
      isVerification: false,
    );

    FirebaseFirestore.instance
        .collection("Users")
        .doc(uid)
        .set(model.toMap())
        .then((value) {
      emit(CreateUserSuccessState(uid));
    }).catchError((error) {
      emit(CreateUserErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changeIconSuffix() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(RegisterChangePasswordVisibilityState());
  }
}
