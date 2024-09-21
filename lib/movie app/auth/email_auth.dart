// import 'package:firebase_auth/firebase_auth.dart';
//
// Future<UserCredential> signInWithEmail()async {
//   try {
//     final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
//       email: emailAddress,
//       password: password,
//     );
//   } on FirebaseAuthException catch (e) {
//     if (e.code == 'weak-password') {
//       print('The password provided is too weak.');
//     } else if (e.code == 'email-already-in-use') {
//       print('The account already exists for that email.');
//     }
//   } catch (e) {
//     print(e);
//   }
// }