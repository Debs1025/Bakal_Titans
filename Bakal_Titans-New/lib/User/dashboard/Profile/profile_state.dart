class ProfileState {
  static String profileImagePath = 'assets/default_profile.png';
  static String name = 'Jayce Betrayer';
  static String bio = '';
  
  static void updateProfileImage(String path) {
    try {
      profileImagePath = path;
    } catch (e) {
      print('Error updating profile image: $e');
    }
  }

  static void updateProfile({String? newName, String? newBio}) {
    if (newName != null) name = newName;
    if (newBio != null) bio = newBio;
  }
}