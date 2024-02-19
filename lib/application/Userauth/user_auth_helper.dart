import 'package:firebase_auth/firebase_auth.dart';

class UserauthHelper {
  final FirebaseAuth auth = FirebaseAuth.instance;

  get user => auth.currentUser;

  //signup
  Future signUp({required String email, required String password}) async {
    try {
      auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //signin

  Future signIn({required String email, required String password}) async {
    try {
      auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //signout

  Future signOut() async {
    await auth.signOut();
    print("signout");
  }
}
