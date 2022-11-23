import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:the_evox_app/models/home_model.dart';

class UserHomeRepository {
  final String userProfileDocId;

  late DocumentReference? dbUsrProfileDoc;

  bool status = false;
  String errorMessage = "";
  int? errorCode;

  UserHomeRepository({
    required this.userProfileDocId,
  }) {
    dbUsrProfileDoc =
        FirebaseFirestore.instance.collection('users').doc(userProfileDocId);
  }

  //If update succeed returns the timestamp of update, otherwise returns null
  DateTime? createHomeForUser(HomeModel newHomeData) {
    List<HomeModel> homeArranged = List.empty();
    DateTime currentDt = DateTime.now();

    homeArranged.add(newHomeData);

    try {
      dbUsrProfileDoc?.update({
        "homes": FieldValue.arrayUnion(homeArranged),
        "modified": currentDt
      });
      _setRepositoryState(true, "", 0);
      return currentDt;
    } on FirebaseException catch (e) {
      _setRepositoryState(false, "FIREBASE ERROR: ${e.message!.toString()}", 1);
      return null;
    }
  }

// ignore_for_file: no_leading_underscores_for_local_identifiers
//This 'repository state setter' method must be used before every
//posible result of each method ends
//* @param _status true for success on method, false for fail on method
  void _setRepositoryState(
      bool _status, String _errorMessage, int? _errorCode) {
    status = _status;
    errorMessage = _errorMessage;
    errorCode = _errorCode;
  }
}
