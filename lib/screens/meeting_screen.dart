import 'package:flutter/material.dart';
import 'package:meeting/config/zego_confid.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zego_uikit_prebuilt_video_conference/zego_uikit_prebuilt_video_conference.dart';

class MeetingScreen extends StatefulWidget {
  final String userName;
  final String roomId;

  const MeetingScreen({super.key, required this.userName, required this.roomId});

  @override
  State<MeetingScreen> createState() => _MeetingScreenState();
}

class _MeetingScreenState extends State<MeetingScreen> {
  String? _userID;

  @override
  void initState() {
    super.initState();
    _loadUserID();
  }

  Future<void> _loadUserID() async {
    final prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString('user_id');
    if (id == null) {
      id = '${widget.userName}_${DateTime.now().millisecondsSinceEpoch}'
          .replaceAll(' ', '_')
          .toLowerCase();
      await prefs.setString('user_id', id);
    }
    setState(() => _userID = id);
  }

  @override
  Widget build(BuildContext context) {
    if (_userID == null) {
      return const Scaffold(
        backgroundColor: Color(0xFF0A0E1A),
        body: Center(
          child: CircularProgressIndicator(color: Color(0xFF2563EB)),
        ),
      );
    }

    return ZegoUIKitPrebuiltVideoConference(
      appID: kAppID,
      appSign: kAppSign,
      userID: _userID!,
      userName: widget.userName,
      conferenceID: widget.roomId,
      config: ZegoUIKitPrebuiltVideoConferenceConfig(
        turnOnCameraWhenJoining: true,
        turnOnMicrophoneWhenJoining: true,
        useSpeakerWhenJoining: true,
        onLeave: () => Navigator.pop(context),
      ),
    );
  }
}