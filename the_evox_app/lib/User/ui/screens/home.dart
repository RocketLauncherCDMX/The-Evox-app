import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_evox_app/IoT/ui/screens/add_room.dart';

// ignore: must_be_immutable
class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  //final _options = ['Home1', 'Home2', 'Home3'];
  //final _actualVal = 'Add Home';
  // ignore: prefer_final_fields
  int _rooms = 0;
  final String _name = '';
  final String _place = 'Mexico city';
  //var _temperature = 187;
  final _tempDouble = 22.3;
  final _activeDevices = 4;
  final _powerUsage = 21.4;
  // ignore: unused_field
  final _bottomNavIcon = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  const CircleAvatar(
                    backgroundImage: AssetImage('assets/images/user_image.png'),
                    backgroundColor: Colors.transparent,
                    radius: 42,
                  ),
                  Container(
                    height: 60,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        color: Colors.pink.shade200,
                        border: Border.all(
                          color: Colors.pink.shade200,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                    margin: const EdgeInsets.all(10),
                    child: const Center(
                        child: Text(
                            'Home') /*DropdownButton(
                          iconEnabledColor: Colors.black, //Icon color
                          value: _actualVal,
                          style:
                              const TextStyle(color: Colors.black, fontSize: 20),
                          elevation: 1,
                          dropdownColor: Colors.white,
                          underline: const SizedBox(),
                          items: _options.map((String a) {
                            return DropdownMenuItem(value: a, child: Text(a));
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _actualVal = newValue!;
                            });
                          },
                        ),*/
                        ),
                  ),
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: SizedBox(
                      child: OutlinedButton(
                          style: ButtonStyle(
                              alignment: AlignmentDirectional.center,
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.grey.shade700),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      side: const BorderSide(
                                          color: Colors.grey)))),
                          onPressed: () => {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const AddRoom()),
                                ),
                              },
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                          )),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Hello $_name',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 38.0),
                ),
                const SizedBox(width: 10.0),
                Image.asset(
                  'assets/icons/greet.png',
                  width: 30,
                  height: 30,
                  fit: BoxFit.scaleDown,
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Center(
              child: Text(
                'Welcome to your home',
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 5, 20),
                    child: Card(
                      margin: EdgeInsets.zero,
                      elevation: 0.0,
                      color: Colors.grey.shade700,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      ),
                      child: SizedBox(
                        height: 200.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            const Icon(
                              Icons.cloud,
                              color: Colors.white,
                            ),
                            Text(_tempDouble.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 32,
                                    color: Colors.white)),
                            const Text('°C',
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 20,
                                    color: Colors.white)),
                            Text(_place,
                                style: const TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16,
                                    color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                    child: Card(
                      margin: EdgeInsets.zero,
                      elevation: 0.0,
                      color: Colors.grey.shade700,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      ),
                      child: SizedBox(
                        height: 200.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            const Icon(
                              Icons.settings_rounded,
                              color: Colors.white,
                            ),
                            Text(_activeDevices.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 32,
                                    color: Colors.white)),
                            Column(
                              children: const <Widget>[
                                Text('Active',
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16,
                                        color: Colors.white)),
                                Text('devices',
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16,
                                        color: Colors.white)),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 20, 20, 20),
                    child: Card(
                      margin: EdgeInsets.zero,
                      elevation: 0.0,
                      color: Colors.grey.shade700,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      ),
                      child: SizedBox(
                        height: 200.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            const Icon(
                              Icons.electric_bolt,
                              color: Colors.white,
                            ),
                            Text(_powerUsage.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 32,
                                    color: Colors.white)),
                            const Text('mW/h',
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 20,
                                    color: Colors.white)),
                            const Text('Usage',
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16,
                                    color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      CircleAvatar(
                          backgroundColor: Colors.grey.shade700,
                          radius: 16,
                          child: Text('$_rooms',
                              style: const TextStyle(color: Colors.white))),
                      const SizedBox(width: 15),
                      const Text('Rooms',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: Colors.black)),
                    ],
                  ),
                  Row(children: <Widget>[
                    TextButton(
                      onPressed: () => {},
                      child: Text(
                        _rooms == 0 ? 'Add room' : 'See all',
                        style: const TextStyle(fontSize: 22),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(20, 20),
                        shape: const CircleBorder(),
                        elevation: 0,
                      ),
                      child: const Text(
                        '+',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ]),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 30, 15, 30),
              child: _rooms == 0 ? noRoomsWidget() : roomsWidget(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.pink,
        child: const Icon(
          Icons.close,
          size: 50,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: Container(
        height: 60,
        decoration: const BoxDecoration(
          color: null,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              enableFeedback: false,
              onPressed: () {},
              icon: const Icon(
                Icons.home_rounded,
                color: Colors.pink,
                size: 35,
              ),
            ),
            IconButton(
              enableFeedback: false,
              onPressed: () {},
              icon: const Icon(
                Icons.device_hub_rounded,
                color: Colors.black,
                size: 35,
              ),
            ),
            IconButton(
              enableFeedback: false,
              onPressed: () {},
              icon: Transform.scale(
                scaleX: -1,
                child: const Icon(
                  Icons.bar_chart,
                  color: Colors.black,
                  size: 35,
                ),
              ),
            ),
            IconButton(
              enableFeedback: false,
              onPressed: () {},
              icon: Stack(
                children: <Widget>[
                  Transform.rotate(
                    angle: 11,
                    child: const Icon(
                      //Icons.hexagon_rounded,
                      CupertinoIcons.add,
                      color: Colors.black,
                      size: 35,
                    ),
                  ),
                  Transform.scale(
                    scale: 0.4,
                    child: Transform.translate(
                        offset: const Offset(14, 6),
                        child: const Icon(Icons.circle, color: Colors.white)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

noRoomsWidget() {
  return SizedBox(
    child: Column(
      children: <Widget>[
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 8),
                  blurRadius: 10,
                  color: Colors.black26,
                  spreadRadius: 5)
            ],
          ),
          child: CircleAvatar(
              backgroundColor: Colors.pink.shade200,
              radius: 42,
              child: const Text('!',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold))),
        ),
        const Text('No rooms',
            style: TextStyle(
                color: Colors.black,
                fontSize: 36,
                fontWeight: FontWeight.bold)),
        const SizedBox(height: 15),
        const Text('You haven\'t added a room. You need to add',
            style: TextStyle(
                color: Colors.grey,
                fontSize: 18,
                fontWeight: FontWeight.normal)),
        const Text('rooms first by clicking "Add room".',
            style: TextStyle(
                color: Colors.grey,
                fontSize: 18,
                fontWeight: FontWeight.normal)),
        const SizedBox(height: 100)
      ],
    ),
  );
}

roomsWidget() {
  return SizedBox(
    child: Column(
      children: <Widget>[
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 8),
                  blurRadius: 10,
                  color: Colors.black26,
                  spreadRadius: 5)
            ],
          ),
          child: CircleAvatar(
              backgroundColor: Colors.pink.shade200,
              radius: 42,
              child: const Icon(
                Icons.check,
                color: Colors.white,
                size: 60,
              )),
        ),
        const Text('Rooms',
            style: TextStyle(
                color: Colors.black,
                fontSize: 36,
                fontWeight: FontWeight.bold)),
        const SizedBox(height: 15),
        const Text('You have rooms.',
            style: TextStyle(
                color: Colors.grey,
                fontSize: 18,
                fontWeight: FontWeight.normal)),
        const Text('click "Add room" for another room.',
            style: TextStyle(
                color: Colors.grey,
                fontSize: 18,
                fontWeight: FontWeight.normal)),
        const SizedBox(height: 100)
      ],
    ),
  );
}
