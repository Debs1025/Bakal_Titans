import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  static final UserService _instance = UserService._internal();
  factory UserService() => _instance;
  UserService._internal();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  // Temporary storage for signup flow
  String? tempEmail;
  String? tempPassword;
  String? tempUsername;
  String? tempBirthdate;
  String? tempGender;
  String? tempHeight;
  String? tempWeight;
  String? tempActivityLevel;
  String? tempBodyType;
  String? tempWeightGoal;
  double? tempBMI;
  String? tempBMICategory;

  // Create user with all stored data at once
  Future<void> createUserWithAllData() async {
    try {
      // Validate required fields
      if (tempEmail == null || tempPassword == null || tempUsername == null) {
        throw Exception('Missing signup information');
      }

      // Create auth user first
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: tempEmail!,
        password: tempPassword!,
      );

      // Get next user number for BKT ID
      DocumentReference counterRef = _firestore.collection('counters').doc('users');
      final userNumber = await _firestore.runTransaction<int>((transaction) async {
        DocumentSnapshot counterDoc = await transaction.get(counterRef);
        
        if (!counterDoc.exists) {
          transaction.set(counterRef, {'count': 1});
          return 1;
        }
        
        int nextCount = (counterDoc.data() as Map<String, dynamic>)['count'] + 1;
        transaction.update(counterRef, {'count': nextCount});
        return nextCount;
      });

      // Create formatted BKT ID
      String formattedUserId = 'BKT${userNumber.toString().padLeft(3, '0')}';

      // Create user document with all collected data
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        // Primary Identifiers
        'uid': formattedUserId,
        'email': tempEmail,
        'username': tempUsername,
        'userNumber': userNumber,

        // Personal Information
        'birthdate': tempBirthdate ?? '',
        'gender': tempGender ?? '',
        
        // Physical Attributes
        'height': tempHeight ?? '',
        'weight': tempWeight ?? '',
        'bmi': tempBMI ?? 0.0,
        'bmiCategory': tempBMICategory ?? '',
        'bodyType': tempBodyType ?? '',
        
        // Fitness Details
        'activityLevel': tempActivityLevel ?? '',
        'weightGoal': tempWeightGoal ?? '',

        // Metadata
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'isProfileComplete': true,
      });

    } catch (e) {
      print('Error creating user: $e');
      rethrow;
    }
  }

  Future<UserCredential> signUpUser({
    required String email, 
    required String password,
    required String username,
  }) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      DocumentReference counterRef = _firestore.collection('counters').doc('users');
      final userNumber = await _firestore.runTransaction<int>((transaction) async {
        DocumentSnapshot counterDoc = await transaction.get(counterRef);
        
        if (!counterDoc.exists) {
          transaction.set(counterRef, {'count': 1});
          return 1;
        }
        
        int nextCount = (counterDoc.data() as Map<String, dynamic>)['count'] + 1;
        transaction.update(counterRef, {'count': nextCount});
        return nextCount;
      });

      String formattedUserId = 'BKT${userNumber.toString().padLeft(3, '0')}';
      
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid': formattedUserId,
        'email': email,
        'username': username,
        'userNumber': userNumber,
        'birthdate': '',
        'gender': '',
        'height': '',
        'weight': '',
        'bmi': 0.0,
        'bmiCategory': '',
        'bodyType': '',
        'activityLevel': '',
        'weightGoal': '',
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'isProfileComplete': false,
      });

      return userCredential;
    } catch (e) {
      print('Error signing up: $e');
      rethrow;
    }
  }

  Future<void> _verifyUpdate(String userId, String field, dynamic value) async {
    final doc = await _firestore.collection('users').doc(userId).get();
    print('Verifying $field update:');
    print('Saved value: ${doc.data()?[field]}');
    print('Expected value: $value');
  }

  Future<UserCredential> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print('Error logging in: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> getUserData() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        final doc = await _firestore.collection('users').doc(user.uid).get();
        print('Retrieved user data: ${doc.data()}');
        return doc.data();
      }
      return null;
    } catch (e) {
      print('Error getting user data: $e');
      rethrow;
    }
  }

  Future<void> createUserDocument({
    required String email,
    required String username,
  }) async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        DocumentReference counterRef = _firestore.collection('counters').doc('users');
        final userNumber = await _firestore.runTransaction<int>((transaction) async {
          DocumentSnapshot counterDoc = await transaction.get(counterRef);
          
          if (!counterDoc.exists) {
            transaction.set(counterRef, {'count': 1});
            return 1;
          }
          
          int nextCount = (counterDoc.data() as Map<String, dynamic>)['count'] + 1;
          transaction.update(counterRef, {'count': nextCount});
          return nextCount;
        });

        String formattedUserId = 'BKT${userNumber.toString().padLeft(3, '0')}';

        await _firestore.collection('users').doc(user.uid).set({
          'uid': formattedUserId,
          'email': email,
          'username': username,
          'userNumber': userNumber,
          'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
        });
      }
    } catch (e) {
      print('Error creating user document: $e');
      rethrow;
    }
  }

  Future<void> saveUserProfile({
    required String birthdate,
    required String gender,
    required String weight,
    required String height,
  }) async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).update({
          'birthdate': birthdate,
          'gender': gender,
          'weight': weight,
          'height': height,
          'updatedAt': FieldValue.serverTimestamp(),
        });

        await _verifyUpdate(user.uid, 'birthdate', birthdate);
        await _verifyUpdate(user.uid, 'gender', gender);
        await _verifyUpdate(user.uid, 'weight', weight);
        await _verifyUpdate(user.uid, 'height', height);
      }
    } catch (e) {
      print('Error saving profile: $e');
      rethrow;
    }
  }

  Future<void> updateActivityLevel(String activityLevel) async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).update({
          'activityLevel': activityLevel,
          'updatedAt': FieldValue.serverTimestamp(),
        });
      }
    } catch (e) {
      print('Error updating activity level: $e');
      rethrow;
    }
  }

  Future<void> updateBodyType(String bodyType) async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).update({
          'bodyType': bodyType,
          'updatedAt': FieldValue.serverTimestamp(),
        });
      }
    } catch (e) {
      print('Error updating body type: $e');
      rethrow;
    }
  }

  Future<void> updateWeightGoal(String weightGoal) async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).update({
          'weightGoal': weightGoal,
          'updatedAt': FieldValue.serverTimestamp(),
        });
      }
    } catch (e) {
      print('Error updating weight goal: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> getUserProfile() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        final doc = await _firestore.collection('users').doc(user.uid).get();
        print('Retrieved profile: ${doc.data()}');
        if (doc.exists) {
          return doc.data();
        } else {
          print('No document found for user ${user.uid}');
          return null;
        }
      }
      return null;
    } catch (e) {
      print('Error getting profile: $e');
      rethrow;
    }
  }

  Future<void> updateBMI({
    required double bmi,
    required String bmiCategory,
  }) async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).update({
          'bmi': bmi,
          'bmiCategory': bmiCategory,
          'updatedAt': FieldValue.serverTimestamp(),
        });
      }
    } catch (e) {
      print('Error updating BMI: $e');
      rethrow;
    }
  }
}