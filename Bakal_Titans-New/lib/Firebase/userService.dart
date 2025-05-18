import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createUserDocument({
    required String email,
    required String username,
  }) async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        // Get the counter document
        DocumentReference counterRef = _firestore.collection('counters').doc('users');
        
        // Get the next user number in a transaction
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

        // Create formatted user ID (e.g., BKT001, BKT002, etc.)
        String formattedUserId = 'BKT${userNumber.toString().padLeft(3, '0')}';

        // Create user document with custom ID
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


  // Save profile details
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
          'weight': weight.replaceAll(' kg', ''),
          'height': height.replaceAll(' cm', ''),
          'updatedAt': FieldValue.serverTimestamp(),
        });
      }
    } catch (e) {
      print('Error saving profile: $e');
      rethrow;
    }
  }

  // Update activity level
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

  // Update body type
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

  // Update weight goal
  Future<void> updateWeightGoal(String weightGoal) async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).update({
          'weightGoal': weightGoal.replaceAll(' lbs', ''),
          'updatedAt': FieldValue.serverTimestamp(),
        });
      }
    } catch (e) {
      print('Error updating weight goal: $e');
      rethrow;
    }
  }

  // Update BMI
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

  // Get user profile
  Future<Map<String, dynamic>?> getUserProfile() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        final doc = await _firestore.collection('users').doc(user.uid).get();
        return doc.data();
      }
      return null;
    } catch (e) {
      print('Error getting user profile: $e');
      rethrow;
    }
  }
}