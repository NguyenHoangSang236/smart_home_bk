import 'package:flutter/material.dart';

class ElectricalDeviceOption extends StatefulWidget {
  const ElectricalDeviceOption({
    super.key,
    required this.name,
    required this.room,
    required this.deviceIcon,
    this.isWifiConnection = true,
    required this.backgroundColor,
  });

  final String name;
  final String room;
  final IconData deviceIcon;
  final bool isWifiConnection;
  final Color backgroundColor;

  @override
  State<ElectricalDeviceOption> createState() => _ElectricalDeviceOptionState();
}

class _ElectricalDeviceOptionState extends State<ElectricalDeviceOption> {
  bool isOn = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: widget.backgroundColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                widget.deviceIcon,
                color: Colors.white,
              ),
              widget.isWifiConnection
                  ? const Icon(
                      Icons.wifi,
                      color: Colors.white,
                    )
                  : const Icon(
                      Icons.bluetooth,
                      color: Colors.white,
                    )
            ],
          ),
          const SizedBox(height: 20),
          Text(
            widget.name,
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            widget.room,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 20),
          const Divider(
            color: Colors.white,
            thickness: 0.5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isOn ? 'On' : 'Off',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Switch(
                value: isOn,
                onChanged: (value) {
                  setState(() {
                    isOn = value;
                  });
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
