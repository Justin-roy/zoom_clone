import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:zoom_clone/resource/jitsi_meet.dart';
import 'package:zoom_clone/widget/join_option.dart';

class JoinMeetingScreen extends StatefulWidget {
  const JoinMeetingScreen({Key? key}) : super(key: key);

  @override
  State<JoinMeetingScreen> createState() => _JoinMeetingScreenState();
}

class _JoinMeetingScreenState extends State<JoinMeetingScreen> {
  late final _meetingIdController;
  late final _nameController;
  bool isAudioMuted = true;
  bool isVideoMuted = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    _meetingIdController = TextEditingController();
    _nameController =
        TextEditingController(text: _auth.currentUser!.displayName!);

    super.initState();
  }

  @override
  void dispose() {
    JitsiMeet.closeMeeting();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff32353f),
        centerTitle: true,
        leading: TextButton(
          onPressed: () {
            const BackButton();
          },
          child: const Text(
            'Cancel',
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
        ),
        title: const Text(
          'Join Meeting',
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: Column(
        children: [
          const Spacer(),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
            ),
            child: TextField(
              controller: _meetingIdController,
              maxLines: 1,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Meeting Id',
              ),
            ),
          ),
          const Spacer(),

          const Text(
            'Join with a personal link name',
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
          const Spacer(),

          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
            ),
            child: TextField(
              controller: _nameController,
              maxLines: 1,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
          const Spacer(),

          Container(
            margin: const EdgeInsets.all(18),
            width: MediaQuery.of(context).size.width,
            height: 60,
            child: ElevatedButton(
              onPressed: _joinMeetingById,
              child: const Text(
                'Join',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(29.0),
                ),
              ),
            ),
          ),
          const Spacer(),

          Padding(
            padding: const EdgeInsets.only(
              left: 8,
            ),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Join Options'.toUpperCase(),
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          //for audio
          JoinOptionScreen(
            text: 'Don\'t Connet To Audio',
            isMuted: isAudioMuted,
            onChanged: (value) => _onAudioMuted(value),
          ),
          //for video
          JoinOptionScreen(
            text: 'Turn Off My Video',
            isMuted: isVideoMuted,
            onChanged: (value) => _onVideoMuted(value),
          ),
          const Spacer(
            flex: 5,
          ),
        ],
      ),
    );
  }

  _onAudioMuted(bool value) {
    setState(() {
      isAudioMuted = value;
    });
  }

  _onVideoMuted(bool value) {
    setState(() {
      isVideoMuted = value;
    });
  }

  // Joining Meeting
  _joinMeetingById() {
    ZoomMeet _zoom = ZoomMeet();
    _zoom.createMeeting(
        roomName: _meetingIdController.text,
        isAudioMuted: isAudioMuted,
        isVideoMuted: isVideoMuted,
        username: _nameController.text);
  }
}
