

import 'package:social_app/data/local/cache_helper.dart';
import 'package:social_app/moduls/login/login_screen.dart';
import 'package:social_app/shared/components/components.dart';

void signOut(context){
  CacheHelper.removeData(key: "token").then((value) {
    if (value) {
      navigateToAndFinish(
        context,
        LoginScreen(),
      );
    }
  });
}

String? token = '';
String? uId = '';