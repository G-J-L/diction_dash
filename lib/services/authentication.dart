import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthenticationService {

  // Register User
  Future<User?> registerUser({String? email, String? password, String? confirmPassword}) async {
    print('Registering New User!');
    if (password != confirmPassword) {
      print('Passwords Do Not Match!');
    } else {
      try {
        UserCredential? userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email!, password: password!);
        return userCredential.user;
      } on FirebaseAuthException catch (e) {
        print(e.code);
      }
    }
  }

  // Login User
  Future<void> loginUser({String? email, String? password}) async {
    print('Registering New User!');
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email!, password: password!);
    } on FirebaseAuthException catch (e) {
      print(e.code);
    }
  }

  // Get UserID
  Future<String?> getCurrentUserID() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      return user!.uid;
    } on FirebaseAuthException catch (e) {
      print(e.code);
    }
  }

  // Logout User
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  // Delete Account
  Future<void> reauthenticateAndDelete({String? password}) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      AuthCredential credential = EmailAuthProvider.credential(
        email: user!.email!,
        password: password!,
      );
      await user.reauthenticateWithCredential(credential);
      await user.delete();
      // TODO: Let the user know that the account was deleted succesfully
      print('User reauthenticated and deleted succesfully');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        // TODO: Let the user know that they inputted the wrong password
        print('Incorrect password');
      } else {
        print(e.code);
      }
    }
  }

  // Change Password
  Future<void> reauthenticateAndChangePassword(
      {String? currentPassword, String? newPassword}) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      AuthCredential credential = EmailAuthProvider.credential(
        email: user!.email!,
        password: currentPassword!,
      );
      await user.reauthenticateWithCredential(credential);
      await user.updatePassword(newPassword!);
      // TODO: Let the user know that the password was updated successfully
      print('Password changed succesfully!');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        // TODO: Let the user know that the current password is incorrect
        print('The current password is incorrect');
      } else {
        print('Error: ${e.message}');
      }
    }
  }

}