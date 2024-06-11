import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smart_home/electrical_device_option.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.name});

  final String name;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
        padding: const EdgeInsets.all(15),
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height,
          child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 10,
            children: const [
              ElectricalDeviceOption(
                name: "Máy lạnh",
                room: "Phòng khách",
                deviceIcon: FontAwesomeIcons.snowflake,
                backgroundColor: Colors.purpleAccent,
              ),
              ElectricalDeviceOption(
                name: "Đèn",
                room: "Phòng ngủ",
                deviceIcon: Icons.light,
                backgroundColor: Colors.cyan,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
