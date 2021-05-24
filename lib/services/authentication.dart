// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_translation_app/models/AppUser.dart';
//
// class Authentication {
//   static FirebaseAuth auth = FirebaseAuth.instance;
//
//   static Future<AppUser> anonymousLoginOrGetUser() async {
//     UserCredential uc = await auth.signInAnonymously();
//     AppUser user = AppUser();
//     user.userId = uc.user.uid;
//     return user;
//   }
//   static bool checkUserIsLoggedIn() {
//     return auth.currentUser != null;
//   }
// }
