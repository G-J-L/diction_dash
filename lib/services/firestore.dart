import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diction_dash/services/helper.dart';

class FirestoreService {
  // Initialize Cloud Firestore Instance For Users
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  // Internal method for fetching user data
  Future<Map<String, dynamic>> getUserData(String userID) async {
    Map<String, dynamic>? userData;
    await users.doc(userID).get().then(
      (DocumentSnapshot doc) {
        userData = doc.data() as Map<String, dynamic>;
      },
      onError: (e) => print('Error getting document: $e'),
    );
    return userData!;
  }

  // Internal method for fetching game data (spelling_data, vocabulary_data, etc.)
  Future<Map<String, dynamic>> getGameData(
      {String? userID, String? game}) async {
    Map<String, dynamic>? gameData;
    await users.doc(userID).collection(game!).doc('${game}_data').get().then(
      (DocumentSnapshot doc) {
        gameData = doc.data() as Map<String, dynamic>;
      },
      onError: (e) => print('Error getting document: $e'),
    );
    return gameData!;
  }

  // Add new user method
  Future<void> addNewUser(
      {String? userID, String? username, String? email}) async {
    // Initialize new user document
    final newUser = users.doc(userID);

    // Assign username & email to new user
    await newUser.set({
      'username': username!,
      'email': email!,
      'profile_picture': null,
      'level': 1,
      'exp': 0,
      'previous_max_exp': 0,
      'cefr_level': null,
    });

    // Initializes spelling subcollection to store game data
    final spelling = newUser.collection('spelling').doc('spelling_data');
    await spelling.set({
      'level': 1,
      'exp': 0,
      'previous_max_exp': 0,
    });

    // Initializes vocabulary subcollection to store game data
    final vocabulary = newUser.collection('vocabulary').doc('vocabulary_data');
    await vocabulary.set({
      'level': 1,
      'exp': 0,
      'previous_max_exp': 0,
    });

    // Initializes grammar subcollection to store game data
    final grammar = newUser.collection('grammar').doc('grammar_data');
    await grammar.set({
      'level': 1,
      'exp': 0,
      'previous_max_exp': 0,
    });

    // Initializes comprehension subcollection to store game data
    final comprehension =
        newUser.collection('comprehension').doc('comprehension_data');
    await comprehension.set({
      'level': 1,
      'exp': 0,
      'previous_max_exp': 0,
    });
  }

  // Fetch user data method
  Stream<DocumentSnapshot<Object?>> fetchUserData(String userID) {
    return users.doc(userID).snapshots();
  }

  // Fetch user spelling data
  Stream<DocumentSnapshot<Object?>> fetchSpellingData(String userID) {
    return users
        .doc(userID)
        .collection('spelling')
        .doc('spelling_data')
        .snapshots();
  }

  // Fetch user vocabulary data
  Stream<DocumentSnapshot<Object?>> fetchVocabularyData(String userID) {
    return users
        .doc(userID)
        .collection('vocabulary')
        .doc('vocabulary_data')
        .snapshots();
  }

  // Fetch user grammar data
  Stream<DocumentSnapshot<Object?>> fetchGrammarData(String userID) {
    return users
        .doc(userID)
        .collection('grammar')
        .doc('grammar_data')
        .snapshots();
  }

  // Fetch user comprehension data
  Stream<DocumentSnapshot<Object?>> fetchComprehensionData(String userID) {
    return users
        .doc(userID)
        .collection('comprehension')
        .doc('comprehension_data')
        .snapshots();
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

  Future<void> updateLevelAndEXP(String userID) async {
    Map<String, dynamic> spellingData =
        await getGameData(userID: userID, game: 'spelling');
    Map<String, dynamic> vocabularyData =
        await getGameData(userID: userID, game: 'vocabulary');
    Map<String, dynamic> grammarData =
        await getGameData(userID: userID, game: 'grammar');
    Map<String, dynamic> comprehensionData =
        await getGameData(userID: userID, game: 'comprehension');

    // Assigns the summation of each game exp to user's overall exp
    await users.doc(userID).update({
      'exp': spellingData['exp'] +
          vocabularyData['exp'] +
          grammarData['exp'] +
          comprehensionData['exp'],
    });

    // Retrieve user data and adjust level accordingly
    Map<String, dynamic> userData = await getUserData(userID);
    int userLevel = userData['level'];
    int userExp = userData['exp'];
    if (userExp > calculateMaxEXP(userLevel)) {
      await users.doc(userID).update({
        'level': userLevel + 1,
        'previous_max_exp': calculateMaxEXP(userLevel),
      });
    }
  }

  // Increment spelling exp by a given amount and adjust game level if necessary
  Future<void> addSpellingEXP(String userID, int expReward) async {
    Map<String, dynamic> spellingData =
        await getGameData(userID: userID, game: 'spelling');
    DocumentReference spelling =
        users.doc(userID).collection('spelling').doc('spelling_data');
    int spellingExp = spellingData['exp'];
    await spelling.update({
      'exp': spellingExp + expReward,
    });
    spellingData = await getGameData(userID: userID, game: 'spelling');
    int spellingLevel = spellingData['level'];
    spellingExp = spellingData['exp'];
    if (spellingData['exp'] > calculateMaxEXP(spellingData['level'])) {
      await spelling.update({
        'level': spellingLevel + 1,
        'previous_max_exp': calculateMaxEXP(spellingLevel),
      });
    }
  }

  // Increment vocabulary exp by a given amount and adjust game level if necessary
  Future<void> addVocabularyEXP(String userID, int expReward) async {
    Map<String, dynamic> vocabularyData =
        await getGameData(userID: userID, game: 'vocabulary');
    DocumentReference vocabulary =
        users.doc(userID).collection('vocabulary').doc('vocabulary_data');
    int vocabularyExp = vocabularyData['exp'];
    await vocabulary.update({
      'exp': vocabularyExp + expReward,
    });
    vocabularyData = await getGameData(userID: userID, game: 'vocabulary');
    int vocabularyLevel = vocabularyData['level'];
    vocabularyExp = vocabularyData['exp'];
    if (vocabularyExp > calculateMaxEXP(vocabularyLevel)) {
      await vocabulary.update({
        'level': vocabularyLevel + 1,
        'previous_max_exp': calculateMaxEXP(vocabularyLevel),
      });
    }
  }

  // Increment grammar exp by a given amount and adjust game level if necessary
  Future<void> addGrammarEXP(String userID, int expReward) async {
    Map<String, dynamic> grammarData =
        await getGameData(userID: userID, game: 'grammar');
    DocumentReference grammar =
        users.doc(userID).collection('grammar').doc('grammar_data');
    int grammarExp = grammarData['exp'];
    await grammar.update({
      'exp': grammarData['exp'] + expReward,
    });
    grammarData = await getGameData(userID: userID, game: 'grammar');
    int grammarLevel = grammarData['level'];
    grammarExp = grammarData['exp'];
    if (grammarExp > calculateMaxEXP(grammarLevel)) {
      await grammar.update({
        'level': grammarLevel + 1,
        'previous_max_exp': calculateMaxEXP(grammarLevel),
      });
    }
  }

  // Increment comprehension exp by a given amount and adjust game level if necessary
  Future<void> addComprehensionEXP(String userID, int expReward) async {
    Map<String, dynamic> comprehensionData =
        await getGameData(userID: userID, game: 'comprehension');
    DocumentReference comprehension =
        users.doc(userID).collection('comprehension').doc('comprehension_data');
    int comprehensionExp = comprehensionData['exp'];
    await comprehension.update({
      'exp': comprehensionExp + expReward,
    });
    comprehensionData =
        await getGameData(userID: userID, game: 'comprehension');
    int comprehensionLevel = comprehensionData['level'];
    comprehensionExp = comprehensionData['exp'];
    if (comprehensionExp > calculateMaxEXP(comprehensionLevel)) {
      await comprehension.update({
        'level': comprehensionLevel + 1,
        'previous_max_exp': calculateMaxEXP(comprehensionLevel),
      });
    }
  }

  // Store spelling question for spaced repetition
  Future<void> storeSpellingQuestion(
      {String? userID,
      String? word,
      int? correctScore,
      int? wrongScore,
      Timestamp? nextReview,
      int? repetition,
      }) async {
    final user = users.doc(userID);
    final spellingQuestions = user
        .collection('spelling')
        .doc('spelling_data')
        .collection('spelling_questions');
    await spellingQuestions.add({
      'word': word,
      'correct_score': correctScore,
      'wrong_score': wrongScore,
      'last_review': Timestamp.now(),
      'next_review': nextReview,
      'repetition': repetition,
      'quality_score': 4,
      'ease_score': 2.25,
    });
  }

  // Store vocabulary question for spaced repetition
  Future<void> storeVocabularyQuestion(
      {String? userID,
        String? word,
        int? correctScore,
        int? wrongScore,
        Timestamp? nextReview,
        int? repetition,
      }) async {
    final user = users.doc(userID);
    final vocabularyQuestions = user
        .collection('vocabulary')
        .doc('vocabulary_data')
        .collection('vocabulary_questions');
    await vocabularyQuestions.add({
      'word': word,
      'correct_score': correctScore,
      'wrong_score': wrongScore,
      'last_review': Timestamp.now(),
      'next_review': nextReview,
      'repetition': repetition,
      'quality_score': 4,
      'ease_score': 2.25,
    });
  }
}
