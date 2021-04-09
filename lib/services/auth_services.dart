part of 'services.dart';

class AuthServices {
  static FirebaseAuth auth = FirebaseAuth.instance;

  static Future<ResultValue> signUp(String email, String password, String name, String address) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);

      UserModel user = userCredential.user.changeValue(name: name, address: address);

      await UserServices.setDataUser(user);

      return ResultValue(value: user);
    } catch (e) {
      return ResultValue(message: e.toString());
    }
  }

  static Future<ResultValue> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);

      UserModel user = await userCredential.user.getDataUser();

      return ResultValue(value: user);
      
    } catch (e) {
      return ResultValue(message: e.toString());
    }
  }

  static Future<void> signOut() async {
    await auth.signOut();
  }

  static Future<void> resetPassword(String email) async {
    await auth.sendPasswordResetEmail(email: email);
  }

  static Stream<User> get userStream => auth.authStateChanges();

  
}