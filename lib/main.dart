import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_video_conference/zego_uikit_prebuilt_video_conference.dart';
import 'package:meeting/config/zego_confid.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ZegoUIKit().init(appID: kAppID, appSign: kAppSign);
  runApp(const ZenMeetApp());
}

class ZenMeetApp extends StatelessWidget {
  const ZenMeetApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'ZenMeet',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: const Color(0xFF0A0E1A),
        ),
        home: const HomeScreen(),
      );
}