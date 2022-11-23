part of '../testingrepo_screen.dart';

class UserHomeButtons extends StatefulWidget {
  const UserHomeButtons({Key? key}) : super(key: key);

  @override
  State<UserHomeButtons> createState() => _UserHomeButtonsState();
}

class _UserHomeButtonsState extends State<UserHomeButtons> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final UserProfileRepository _userProvider = UserProfileRepository();
  UserProfile? signedProfile;
  _UserHomeButtonsState() {
    signedProfile = null;
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /********** INSERT TEST **********/
        //BUTTON COMPONENT
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: SizedBox(
            height: 50,
            width: 150,
            child: ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  )),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.grey.shade400)),
              child: const Text("Inserting Test"),
              onPressed: () async {
                /** Create not user-binded filled profile in db */
                if (await _userProvider
                        .createUserProfile(_createTestFilledProfile()) !=
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
        /********** INSERT TEST **********/
        //BUTTON COMPONENT
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: SizedBox(
            height: 50,
            width: 150,
            child: ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  )),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.grey.shade400)),
              child: const Text("Inserting Test"),
              onPressed: () async {
                /** Create not user-binded filled profile in db */
                if (await _userProvider
                        .createUserProfile(_createTestFilledProfile()) !=
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
      ],
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
