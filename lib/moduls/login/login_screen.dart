import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/data/local/cache_helper.dart';
import 'package:social_app/layout/social_layout.dart';
import 'package:social_app/moduls/login/cubit/login_cubit.dart';
import 'package:social_app/moduls/login/cubit/states_cubit.dart';
import 'package:social_app/moduls/register/register_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/contants/constants.dart';

class LoginScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginErrorState) {
            buildShowToast(
              text: state.error,
              state: ToastState.ERROR,
            );
          }
          if(state is  LoginSucessState){
            CacheHelper.saveData(
                key: "uId", value: state.uId)
                .then((value) {
              uId = state.uId;
              navigateToAndFinish(
                context,
                SocialLayoutScreen(),
              );
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'login',
                style: TextStyle(
                  fontSize: 27.0,
                  fontFamily: 'Cairo',
                ),
              ),
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: defaultTextFiled(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          label: 'Email Address',
                          validate: (value) {
                            if (value == null) {
                              return 'this filed required';
                            }
                          },
                          prefix: Icons.email,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: defaultTextFiled(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          label: 'Password',
                          suffixPressed: () {},
                          isPassword: true,
                          validate: (value) {
                            if (value == null) {
                              return 'this filed required';
                            } else {
                              return null;
                            }
                          },
                          suffix: LoginCubit.get(context).suffix,
                          prefix: Icons.lock_outline_rounded,
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      ConditionalBuilder(
                        condition: state is! LoginLoadingState,
                        builder: (context) => Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: defaultButton(
                            height: 40.0,
                            function: () {
                              if (formKey.currentState!.validate()) {
                                LoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            text: "Login",
                            textColor: Colors.white,
                          ),
                        ),
                        fallback: (context) =>
                            Center(child: CircularProgressIndicator()),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an account?',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'assets/fonts/cairo.ttf',
                            ),
                          ),
                          SizedBox(
                            width: 3.0,
                          ),
                          defaultTextButton(
                            textColor: Colors.blue,
                            function: () {
                              navigateTo(
                                context,
                                RegisterScreen(),
                              );
                            },
                            text: "Sign Up",
                            background: Colors.transparent,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
