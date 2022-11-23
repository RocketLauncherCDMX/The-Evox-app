import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_profile_model.dart';

class UserProfileRepository {
  final usersDb = FirebaseFirestore.instance.collection("users");
  bool status = false;
  String errorMessage = "";
  int? errorCode;

  UserProfileRepository();

  /**
   * TODO: document possible errors (mabe just check fireb docs)
   */

  Future<String?> createUserProfile(UserProfile newProfileData) async {
    String? docCreated = "";
    try {
      usersDb
          .add(newProfileData.toFirestore())
          .then((DocumentReference doc) => {docCreated = doc.id});
      _setDataProviderState(true, "", 1);
    } on FirebaseException catch (e) {
      docCreated = null;
      _setDataProviderState(
          false, "FIREBASE ERROR: ${e.message!.toLowerCase()}", 400);
    }
    return docCreated;
  }

  Future<UserProfile?> getUserProfileByAuthId(String userAuthId) async {
    UserProfile? profileData;
    try {
      final docSnap = await usersDb
          .where("userId", isEqualTo: userAuthId)
          .withConverter(
            fromFirestore: UserProfile.fromFirestore,
            toFirestore: (UserProfile uProfile, _) => uProfile.toFirestore(),
          )
          .get();

      if (docSnap.docs.isNotEmpty) {
        //A profile was found in db for the user authenticated
        profileData = docSnap.docs.first.data();
        profileData.profileDocId = docSnap.docs.first.id;
        _setDataProviderState(true, "", 1);
      } else {
        //There isnt a profile in db that matches with userAuthId
        profileData = null;
        _setDataProviderState(false, "No matching profile for userAuthId", 404);
      }
    } on FirebaseException catch (e) {
      profileData = null;
      _setDataProviderState(
          false, "FIREBASE CONN ERROR: ${e.message!.toLowerCase()}", 0);
    }
    return profileData;
  }

  Future<UserProfile>? updateUserProfilePersonalInfo(
      UserProfile udProfile) async {
    final DateTime modificationTimestamp = DateTime.now();
    try {
      usersDb.doc(udProfile.profileDocId).update({
        "name": udProfile.name,
        "email": udProfile.email,
        "photo": udProfile.photo,
        "countryCode": udProfile.countryCode,
        "modified": modificationTimestamp,
      });
      udProfile.modified = modificationTimestamp;
      _setDataProviderState(true, "", 1);
    } on FirebaseException catch (e) {
      _setDataProviderState(
          false, "FIREBASE ERROR: ${e.message!.toLowerCase()}", 0);
    }
    return udProfile;
  }

  Future<bool> deleteUserProfile(String docProfileId) async {
    try {
      await usersDb
          .doc(docProfileId)
          .delete()
          .then((value) => print("User profile deleted"))
          .catchError((error) => print("Failed to delete user: $error"));
      _setDataProviderState(true, "", 1);
      return true;
    } on FirebaseException catch (e) {
      _setDataProviderState(
          false, "FIREBASE ERROR: ${e.message!.toLowerCase()}", 0);
      return false;
    }
  }

// ignore_for_file: no_leading_underscores_for_local_identifiers
//This 'provider state setter' method must be used before every
//posible result of each method ends
//* @param _status true for success on method, false for fail on method
  void _setDataProviderState(
      bool _status, String _errorMessage, int? _errorCode) {
    status = _status;
    errorMessage = _errorMessage;
    errorCode = _errorCode;
  }
}
