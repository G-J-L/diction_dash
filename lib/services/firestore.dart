import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {

  // Initialize Cloud Firestore Instance For Users
  final CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> addNewUser({String? userID, String? username, String? email}) async {
    // Initialize new user document
    final newUser = users.doc(userID);

    // Assign username & email to new user
    await newUser.set({
      'username': username!,
      'email': email!,
      'level': 1,
      'exp': 0,
    });

    // TODO: Assign each minigame with xp and level

    // Spelling Collection
    final spelling = newUser.collection('spelling');
    await spelling.add({
      'spelling_level': 1,
      'spelling_exp': 0,
    });

    // Vocabulary Collection
    final vocabulary = newUser.collection('vocabulary');
    await vocabulary.add({
      'vocabulary_level': 1,
      'vocabulary_exp': 0,
    });

    // Grammar Collection
    final grammar = newUser.collection('grammar');
    await grammar.add({
      'grammar_level': 1,
      'grammar_exp': 0,
    });

    // Comprehension Collection
    final comprehension = newUser.collection('comprehension');
    await comprehension.add({
      'comprehension_level': 1,
      'comprehension_exp': 0,
    });

  }

  // TODO: Create get username method
  Future<String?> getUsername(String userID) async {
    DocumentSnapshot<Object?> snapshot = await users.doc(userID).get();
    print(snapshot.data());
  }

  // TODO: Create update username method

  // TODO: Create select fluency method

  // TODO: Create add XP method (Overall, Spelling, Grammar, Vocab, Comprehension)

  // TODO: Create update level method

}