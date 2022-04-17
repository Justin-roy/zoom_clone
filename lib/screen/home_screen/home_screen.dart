import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zoom_clone/resource/auth_methods.dart';
import 'package:zoom_clone/resource/jitsi_meet.dart';
import 'package:zoom_clone/widget/home_icons.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final _textController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  _createNewMeeting() async {
    Random randomId = Random();
    String meetingId = randomId.nextInt((10000000) + 10000000).toString();
    ZoomMeet _zoom = ZoomMeet();
    await AuthMethods().uploadZoomDetails(
      username: _auth.currentUser!.displayName!,
      meetingId: meetingId,
    );
    _zoom.createMeeting(
      roomName: meetingId,
      isAudioMuted: true,
      isVideoMuted: true,
      username: _auth.currentUser!.displayName!,
    );
  }

  _joinMeeting() {
    Navigator.pushNamed(context, '/join-meeting');
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: TextField(
              controller: _textController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              HomeIcons(
                buttonIcon: Icons.videocam,
                buttonColor: Colors.orange,
                text: 'New Meeting',
                ontap: _createNewMeeting,
              ),
              HomeIcons(
                buttonIcon: Icons.add_circle_outline,
                buttonColor: Colors.blue,
                text: 'Join',
                ontap: _joinMeeting,
              ),
              HomeIcons(
                buttonIcon: Icons.calendar_today,
                buttonColor: Colors.blue,
                text: 'Schedule',
                ontap: () {},
              ),
              HomeIcons(
                buttonIcon: Icons.arrow_upward_rounded,
                buttonColor: Colors.blue,
                text: 'Share Screen',
                ontap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
