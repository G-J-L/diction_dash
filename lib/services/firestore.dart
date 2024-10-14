import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {

  // Initialize Cloud Firestore Instance For Users
  final CollectionReference users = FirebaseFirestore.instance.collection('users');

  // Add new user method
  Future<void> addNewUser({String? userID, String? username, String? email}) async {
    // Initialize new user document
    final newUser = users.doc(userID);

    // Assign username & email to new user
    await newUser.set({
      'username': username!,
      'email': email!,
      'profile_picture': null,

      'level': 1,
      'exp': 0,
      'cefr_level': null,

      'spelling_level': 1,
      'spelling_exp': 0,

      'vocabulary_level': 1,
      'vocabulary_exp': 0,

      'grammar_level': 1,
      'grammar_exp': 0,

      'comprehension_level': 1,
      'comprehension_exp': 0,
    });
  }

  // Fetch user data method
  Stream<DocumentSnapshot<Object?>> fetchUserData(String userID) {
    return users.doc(userID).snapshots();
  }

  // Update username method
  Future<void> updateUsername({String? userID, String? newUsername}) async {
    await users.doc(userID).update({
      'username': newUsername!,
    });
  }

  // Update profile picture method
  Future<void> updateProfilePicture({String? userID, String? imageUrl}) async {
    await users.doc(userID).update({
      'profile_picture': imageUrl!,
    });
  }

  // Update CEFR level method
  Future<void> updateCEFR({String? userID, String? newLevel}) async {
    await users.doc(userID).update({
      'cefr_level': newLevel!,
    });
  }

  // Delete document ID
  Future<void> deleteUser(String userID) async {
    print(userID);
    await users.doc(userID).delete();
  }

  // TODO: Create add XP method (Overall, Spelling, Grammar, Vocab, Comprehension)

  // TODO: Create update level method

}