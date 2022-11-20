import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:the_evox_app/repositories/user_profile_provider.dart';

import 'package:the_evox_app/models/authorization_model.dart';
import 'package:the_evox_app/models/device_model.dart';
import 'package:the_evox_app/models/home_model.dart';
import 'package:the_evox_app/models/room_model.dart';
import 'package:the_evox_app/models/user_profile_model.dart';

class RepotestingScreen extends StatefulWidget {
  const RepotestingScreen({Key? key}) : super(key: key);

  @override
  State<RepotestingScreen> createState() => _RepotestingScreenState();
}

class _RepotestingScreenState extends State<RepotestingScreen> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final UserProfileRepository _userProvider = UserProfileRepository();
  UserProfile? signedProfile;

  _RepotestingScreenState() {
    signedProfile = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("RepoTesting"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          color: Colors.blueGrey.shade50,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: StreamBuilder<User?>(
                    stream: _firebaseAuth.authStateChanges(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Text("...");
                      } else if (snapshot.hasError) {
                        return Text("Error: ${snapshot.error}");
                      } else if (snapshot.hasData) {
                        return const Text("Loggeado");
                      } else {
                        return const Text("No loggeado");
                      }
                    },
                  ),
                ),
                /********** INSERT TEST **********/
                //BUTTON COMPONENT
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: SizedBox(
                    height: 50,
                    width: 150,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          )),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.blueGrey.shade400)),
                      child: const Text("Inserting Test"),
                      onPressed: () async {
                        /** Create not user-binded filled profile in db */
                        if (await _userProvider.createUserProfile(
                                _createTestFilledProfile()) !=
                            null) {
                          print("PROFILE CREATED");
                        } else {
                          print("ERROR: ${_userProvider.errorMessage}");
                        }
                      },
                    ),
                  ),
                ),
                //END BUTTON COMPONENT
                /********** INSERT TEST **********/
                /********** EMAIL PASS **********/
                //BUTTON COMPONENT
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: SizedBox(
                    height: 50,
                    width: 150,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          )),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.lightGreen.shade300)),
                      child: const Text("Email SignUp"),
                      onPressed: () async {
                        if (signedProfile == null) {
                          /** If THERE ISNT a user profile object created
                           * then proceed to signin intend */
                          try {
                            /** Make sign up intend with email and password */
                            UserCredential userSigned = await _firebaseAuth
                                .createUserWithEmailAndPassword(
                                    email: 'jorgegarcia@gmail.com',
                                    password: "12345678");

                            /** If no error throwned
                             * get user info from credential */
                            User? newUserInfo = userSigned.user;

                            /** Create a test filled up object user profile
                             * binded to user authenticated */
                            UserProfile newUserProfile =
                                _createTestFilledProfile(
                                    testName:
                                        newUserInfo!.displayName.toString(),
                                    testAuthId: newUserInfo.uid);

                            /** Create a user profile in DB from previous filledup
                             * object and stores the ID of created db doc */
                            newUserProfile.profileDocId = await _userProvider
                                .createUserProfile(newUserProfile);
                            if (_userProvider.status) {
                              /** If Status indicator is true means that profile
                                 * was successfully created and stores
                                 * the locally created profile in global var */
                              signedProfile = newUserProfile;
                            } else {
                              print(_userProvider.errorMessage);
                            }
                          } on FirebaseAuthException catch (e) {
                            print("error: ${e.message}");
                          }
                        } else {
                          /** If THERE IS a user profile object then means that user was logged in */
                          print("User is already logged!!");
                        }
                      },
                    ),
                  ),
                ),
                //END BUTTON COMPONENT
                //BUTTON COMPONENT
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: SizedBox(
                    height: 50,
                    width: 150,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          )),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.lightGreen.shade300)),
                      child: const Text("Email SignIn"),
                      onPressed: () async {
                        if (signedProfile == null) {
                          /** If THERE ISNT a user profile object created
                           * then proceed to signin intend */
                          try {
                            /** Perform login with email and password
                             * expecting for user credential
                             */
                            UserCredential userSigned =
                                await _firebaseAuth.signInWithEmailAndPassword(
                                    email: 'jorgegarcia@gmail.com',
                                    password: "12345678");

                            /** Trying to retrive the profile from DB using
                             * user authenticated ID */
                            signedProfile =
                                await _userProvider.getUserProfileByAuthId(
                                    userSigned.user!.uid.toString());

                            if (_userProvider.status) {
                              /** If retriving user profile from DB SUCCEEDS*/
                              print("User signed: ${signedProfile!.name}");
                              print(signedProfile);
                            } else {
                              /** If retriving user profile from DB FAILS*/
                              if (_userProvider.errorCode == 404) {
                                /** If no Exception throwned (just profile not found)
                                * create one getting user info from credential */
                                print(
                                    'USER WARNING: User profile no found in DB starting profile creation');
                                User? newUserInfo = userSigned.user;

                                /** Create a test filled up object user profile
                                 * binded to user authenticated */
                                UserProfile newUserProfile =
                                    _createTestFilledProfile(
                                        testName:
                                            newUserInfo!.displayName.toString(),
                                        testAuthId: newUserInfo.uid);

                                /** Create a user profile in DB from previous filledup
                                 * object and stores the ID of created db doc */
                                newUserProfile.profileDocId =
                                    await _userProvider
                                        .createUserProfile(newUserProfile);
                                if (_userProvider.status) {
                                  /** If Status indicator is true means that profile
                                     * was successfully created and stores
                                     * the locally created profile in global var */
                                  print(
                                      "User profile created for: ${newUserProfile.name}");
                                  signedProfile = newUserProfile;
                                } else {
                                  print(_userProvider.errorMessage);
                                }
                              } else {
                                print(
                                    "ERROR USERPROFILEPROVIDER: ${_userProvider.errorMessage}");
                              }
                            }
                          } on FirebaseAuthException catch (e) {
                            print("AUTH ERROR: ${e.message}");
                          }
                        } else {
                          /** If THERE IS a user profile object then means that user was logged in */
                          print("User is already logged!!");
                        }
                      },
                    ),
                  ),
                ),
                //END BUTTON COMPONENT
                /********** EMAIL PASS **********/
                /********** USER PROFILE OPPERATIONS **********/
                //BUTTON COMPONENT
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: SizedBox(
                    height: 50,
                    width: 150,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          )),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.blueGrey.shade400)),
                      child: const Text("Update User"),
                      onPressed: () async {
                        if (signedProfile != null) {
                          DateTime previousUpdate = signedProfile!.modified!;
                          try {
                            signedProfile = await _userProvider
                                .updateUserProfilePersonalInfo(signedProfile!);
                            if (_userProvider.status) {
                              print(
                                  "User updated at: ${signedProfile!.modified.toString()}, previous update in: ${previousUpdate.toString()}");
                            } else {
                              print(
                                  "ERROR USERPROFILEPROVIDER:${_userProvider.errorMessage}");
                            }
                          } on Exception catch (e) {
                            print("Error: ${e.toString()}");
                          }
                        } else {
                          print("Logged user not found");
                        }
                      },
                    ),
                  ),
                ),
                //END BUTTON COMPONENT
                //BUTTON COMPONENT
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: SizedBox(
                    height: 50,
                    width: 150,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          )),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.blueGrey.shade400)),
                      child: const Text("Delete profile"),
                      onPressed: () async {
                        if (signedProfile != null) {
                          try {
                            if (await _userProvider.deleteUserProfile(
                                signedProfile!.profileDocId!)) {
                              print("User profile successfully deleted.");
                              /**
                               * ! Delete account from Auth DB before trigger logout
                               */
                              _firebaseAuth.signOut();
                            } else {
                              print(
                                  "ERROR USERPROFILEPROVIDER:${_userProvider.errorMessage}");
                            }
                          } on Exception catch (e) {
                            print("Error: ${e.toString()}");
                          }
                        } else {
                          print("Logged user not found");
                        }
                      },
                    ),
                  ),
                ),
                //END BUTTON COMPONENT
                /********** USER PROFILE OPERATIONS **********/
                /********** GOOGLE **********/
                //BUTTON COMPONENT
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: SizedBox(
                    height: 50,
                    width: 150,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          )),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.red.shade500)),
                      child: const Text("Google SignUp"),
                      onPressed: () async {
                        try {
                          // Trigger the authentication flow
                          GoogleSignInAccount? googleUser =
                              await GoogleSignIn().signIn();

                          // Obtain the auth details from the request
                          GoogleSignInAuthentication? googleAuth =
                              await googleUser?.authentication;

                          // Create a new credential
                          var credential = GoogleAuthProvider.credential(
                            accessToken: googleAuth?.accessToken,
                            idToken: googleAuth?.idToken,
                          );

                          UserCredential newGoogleUser = await _firebaseAuth
                              .signInWithCredential(credential);
                        } on FirebaseAuthException catch (e) {
                          print("error: ${e.message}");
                        }
                      },
                    ),
                  ),
                ),
                //END BUTTON COMPONENT
                //BUTTON COMPONENT
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: SizedBox(
                    height: 50,
                    width: 150,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          )),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.red.shade500)),
                      child: const Text("Google SignIn"),
                      onPressed: () async {
                        try {
                          UserCredential userGoogleSigned =
                              await _firebaseAuth.signInWithEmailAndPassword(
                                  email: 'jorgegarcia@gmail.com',
                                  password: "12345678");
                        } on FirebaseAuthException catch (e) {
                          print("error: ${e.message}");
                        }
                      },
                    ),
                  ),
                ),
                //END BUTTON COMPONENT
                /********** GOOGLE **********/
                //BUTTON COMPONENT
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: SizedBox(
                    height: 50,
                    width: 150,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          )),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.black)),
                      child: const Text("SignOut"),
                      onPressed: () {
                        signedProfile = null;
                        _firebaseAuth.signOut();
                      },
                    ),
                  ),
                ),
                //END BUTTON COMPONENT
              ]),
            ),
          ),
        ),
      ),
    );
  }

  UserProfile _createTestFilledProfile(
      {String testName = "User Test", String testAuthId = "0101010101"}) {
    var creationDt = DateTime.now();
    var userHomeRoomDevices = [
      DeviceModel(
          deviceId: "aa11aa11",
          name: "Main light",
          type: "Rgb Lamp",
          controller: {"parametro1": "valor1", "parametro2": "valor2"},
          powerMeasure: 100.0),
    ];
    var userHomeRooms = [
      RoomModel(
          roomId: "a1a1a1a1",
          name: "Living room",
          picture: "http://google.com/home1room1.jpg",
          powerUsage: 2535.0,
          devices: userHomeRoomDevices),
    ];
    var userHomes = [
      HomeModel(
          homeId: "AAAAAAAA",
          name: "Forest House",
          location: {
            "address": "555 Oakroad, Winterforest",
            "coords": "19N 19W 19.19",
            "countryCode": "MX"
          },
          images: [
            "http://google.com/home1.jpg",
            "http://google.com/home2.jpg"
          ],
          rooms: userHomeRooms),
    ];
    var userAuthorizations = [
      (AuthorizationModel(
          guestId: "02020202", homesAuthorized: ["AAAAAAAA", "BBBBBBBB"]))
    ];
    return UserProfile(
        userId: testAuthId,
        name: testName,
        email: "user@test.com",
        photo: "http://google.com",
        countryCode: "MX",
        authorizations: userAuthorizations,
        homes: userHomes,
        invites: ["03030303", "04040404"],
        created: creationDt,
        modified: creationDt,
        verified: false);
  }
}
