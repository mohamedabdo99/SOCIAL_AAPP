import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/data/local/cache_helper.dart';
import 'package:social_app/layout/social_layout.dart';
import 'package:social_app/moduls/register/cubit/register_cubit.dart';
import 'package:social_app/moduls/register/cubit/states_cubit.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/contants/constants.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var phoneController = TextEditingController();
    var passwordController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterErrorState) {
            buildShowToast(
              text: state.error,
              state: ToastState.ERROR,
            );
          }
          if(state is CreateUserSuccessState){
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
                'Register',
              ),
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: defaultTextFiled(
                          controller: nameController,
                          type: TextInputType.name,
                          label: 'name',
                          validate: (value) {
                            if (value == null) {
                              return 'this filed required';
                            }
                          },
                          prefix: Icons.person,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
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
                          controller: phoneController,
                          type: TextInputType.phone,
                          label: 'phone',
                          validate: (value) {
                            if (value == null) {
                              return 'this filed required';
                            }
                          },
                          prefix: Icons.phone,
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
                          suffixPressed: () {
                            RegisterCubit.get(context).changeIconSuffix();
                          },
                          isPassword: RegisterCubit.get(context).isPassword,
                          validate: (value) {
                            if (value == null) {
                              return 'this filed required';
                            } else {
                              return null;
                            }
                          },
                          // suffix: LoginCubit.get(context).suffix,
                          prefix: Icons.lock_outline_rounded,
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      ConditionalBuilder(
                        condition: true,
                        builder: (context) => Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: defaultButton(
                            height: 40.0,
                            function: () {
                              if (formKey.currentState!.validate()) {
                                RegisterCubit.get(context).userRegister(
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            text: "SignUP",
                            textColor: Colors.white,
                          ),
                        ),
                        fallback: (context) =>
                            Center(child: CircularProgressIndicator()),
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
