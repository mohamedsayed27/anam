
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../cache_helper/cache_keys.dart';
import '../cache_helper/shared_pref_methods.dart';

// import '../cache_manager/cache_keys.dart';
// import '../cache_manager/shared_preferences.dart';

// String imageToBase64(File image) {
//   List<int> bytes = image.readAsBytesSync();
//   return base64Encode(bytes);
// }

void showProgressIndicator(BuildContext context){
  AlertDialog alertDialog = const AlertDialog(
    backgroundColor: Colors.transparent,
    elevation: 0,
    content: Center(
      child: CircularProgressIndicator.adaptive(),
    ),
  );
  showDialog(context: context, builder: (context)=>WillPopScope(child: alertDialog, onWillPop: ()async{return true;}),barrierDismissible: false);
}

void showToast({required int errorType, required String message}){
  if(errorType == 0){
    Fluttertoast.showToast(msg: message,backgroundColor: Colors.green,textColor: Colors.white,gravity: ToastGravity.SNACKBAR,);
  }else{
    Fluttertoast.showToast(msg: message,backgroundColor: Colors.red,textColor: Colors.white,gravity: ToastGravity.SNACKBAR);
  }
}
String? token = CacheHelper.getData(key: CacheKeys.token);
String? onboarding = CacheHelper.getData(key: CacheKeys.onboarding);
String? googleClientIdIos = "519171617357-ea5stt0mq1vavf89nvj9e15rgnc0ikjp.apps.googleusercontent.com";
String? googleClientIdAndroid = "519171617357-gb5jkffo2fpdek02j89souen5balhfos.apps.googleusercontent.com";
String? userId = CacheHelper.getData(key: CacheKeys.userId).toString();
String? userType = CacheHelper.getData(key: CacheKeys.userType);
String? username = CacheHelper.getData(key: CacheKeys.userName);
String? userEmail = CacheHelper.getData(key: CacheKeys.userEmail);
String? phone = CacheHelper.getData(key: CacheKeys.phone);
String initialLocale = CacheHelper.getData(key: CacheKeys.initialLocale)??"en";
Size appBarSize = AppBar().preferredSize;