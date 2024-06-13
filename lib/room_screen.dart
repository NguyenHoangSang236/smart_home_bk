import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smart_home/device_screen.dart';
import 'package:smart_home/electrical_device_option.dart';

class RoomScreen extends StatefulWidget {
  const RoomScreen({super.key, required this.name});

  final String name;

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  List<String> roomList = ["Phòng khách", "Phòng ngủ", "Bếp"];
  List<List<Widget>> deviceComponentLists = [
    [
      ElectricalDeviceOption(
        name: "Đèn 1",
        room: "Phòng khách",
        deviceIcon: Icons.lightbulb,
        backgroundColor: Colors.deepPurpleAccent,
      ),
      ElectricalDeviceOption(
        name: "Đèn 2",
        room: "Phòng khách",
        deviceIcon: Icons.light_mode_sharp,
        backgroundColor: Colors.blueAccent,
      ),
      ElectricalDeviceOption(
        name: "Rèm cửa",
        room: "Phòng khách",
        deviceIcon: Icons.curtains_outlined,
        backgroundColor: Colors.amber,
      ),
      ElectricalDeviceOption(
        name: "Quạt trần",
        room: "Phòng khách",
        deviceIcon: FontAwesomeIcons.fan,
        backgroundColor: Colors.pink,
      ),
    ],
    [
      ElectricalDeviceOption(
        name: "Đèn ngủ",
        room: "Phòng ngủ",
        deviceIcon: Icons.light,
        backgroundColor: Colors.deepPurpleAccent,
      ),
      ElectricalDeviceOption(
        name: "Máy lạnh",
        room: "Phòng ngủ",
        deviceIcon: FontAwesomeIcons.snowflake,
        backgroundColor: Colors.teal,
      ),
      ElectricalDeviceOption(
        name: "Quạt treo tường",
        room: "Phòng ngủ",
        deviceIcon: FontAwesomeIcons.fan,
        backgroundColor: Colors.amber,
      ),
    ],
    [
      ElectricalDeviceOption(
        name: "Đèn",
        room: "Bếp",
        deviceIcon: Icons.light,
        backgroundColor: Colors.deepPurpleAccent,
      ),
      ElectricalDeviceOption(
        name: "Máy hút khói",
        room: "Bếp",
        deviceIcon: FontAwesomeIcons.smoking,
        backgroundColor: Colors.blueAccent,
      ),
      ElectricalDeviceOption(
        name: "Quạt",
        room: "Bếp",
        deviceIcon: FontAwesomeIcons.fan,
        backgroundColor: Colors.orange,
      ),
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Smart Home",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 5),
            RichText(
              text: TextSpan(
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 21,
                ),
                children: [
                  const TextSpan(
                    text: 'Hey, ',
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                  TextSpan(
                    text: widget.name,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: ListView.builder(
          itemCount: roomList.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return _roomOption(roomList[index], deviceComponentLists[index]);
          },
        ),
      ),
    );
  }

  Widget _roomOption(String roomName, List<Widget> deviceComponentList) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DeviceScreen(
              name: widget.name,
              deviceComponents: deviceComponentList,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 15),
        padding: EdgeInsets.all(20),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.lime,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          roomName,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
