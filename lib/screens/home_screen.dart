import 'package:flutter/material.dart';
import 'meeting_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _nameCtrl = TextEditingController();
  final _idCtrl = TextEditingController();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _idCtrl.dispose();
    super.dispose();
  }


  void _snack(String msg, Color color) => ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(msg), backgroundColor: color));

  void _join() {
    final name = _nameCtrl.text.trim();
    final id = _idCtrl.text.trim();
    if (name.isEmpty || id.isEmpty) {
      _snack('أدخل اسمك ورقم الغرفة', Colors.deepOrange);
      return;
    }
    Navigator.push(context, MaterialPageRoute(
      builder: (_) => MeetingScreen(userName: name, roomId: id),
    ));
  }

  void _startNew() {
    final name = _nameCtrl.text.trim();
    if (name.isEmpty) {
      _snack('أدخل اسمك أولاً', Colors.orange);
      return;
    }
    final roomId = 'ZEN-${DateTime.now().millisecondsSinceEpoch % 9999}';
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF111827),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('🎉 غرفتك جاهزة!',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          const Text('شارك هذا الكود مع الشخص الثاني:',
              style: TextStyle(color: Colors.white60, fontSize: 13)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            decoration: BoxDecoration(
              color: const Color(0xFF2563EB).withOpacity(0.15),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFF2563EB), width: 1.5),
            ),
            child: Text(roomId,
                style: const TextStyle(
                    color: Color(0xFF60A5FA),
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2)),
          ),
        ]),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('إلغاء', style: TextStyle(color: Colors.white54))),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(
                builder: (_) => MeetingScreen(userName: name, roomId: roomId),
              ));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2563EB),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('ادخل الغرفة', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E1A),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Row(children: [
                Container(
                  width: 44, height: 44,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        colors: [Color(0xFF2563EB), Color(0xFF7C3AED)]),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(Icons.videocam_rounded, color: Colors.white, size: 24),
                ),
                const SizedBox(width: 12),
                const Text('ZenMeet',
                    style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
              ]),
              const SizedBox(height: 48),
              const Text('ابدأ اجتماعك الآن',
                  style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text('أدخل اسمك للانضمام أو بدء غرفة جديدة',
                  style: TextStyle(color: Colors.white54, fontSize: 15)),
              const SizedBox(height: 40),
              _label('اسمك'),
              const SizedBox(height: 8),
              _field(controller: _nameCtrl, hint: 'مثال: Ahmed', icon: Icons.person_outline_rounded),
              const SizedBox(height: 24),
              _label('رقم الغرفة'),
              const SizedBox(height: 8),
              _field(controller: _idCtrl, hint: 'مثال: ZEN-1234', icon: Icons.tag_rounded),
              const SizedBox(height: 36),
              SizedBox(
                width: double.infinity, height: 56,
                child: ElevatedButton.icon(
                  onPressed: _join,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2563EB),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  icon: const Icon(Icons.link_rounded, color: Colors.white, size: 22),
                  label: const Text('انضم لغرفة',
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
                ),
              ),
              const SizedBox(height: 14),
              SizedBox(
                width: double.infinity, height: 56,
                child: OutlinedButton.icon(
                  onPressed: _startNew,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF7C3AED), width: 1.5),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  icon: const Icon(Icons.add_rounded, color: Color(0xFF7C3AED), size: 22),
                  label: const Text('ابدأ غرفة جديدة',
                      style: TextStyle(color: Color(0xFF7C3AED), fontSize: 16, fontWeight: FontWeight.w700)),
                ),
              ),
              const SizedBox(height: 48),
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: const Color(0xFF111827),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white.withOpacity(0.07)),
                ),
                child: const Row(children: [
                  Icon(Icons.info_outline_rounded, color: Color(0xFF2563EB), size: 22),
                  SizedBox(width: 12),
                  Expanded(child: Text(
                    'شارك رقم الغرفة مع الشخص الثاني حتى يتمكن من الانضمام',
                    style: TextStyle(color: Colors.white60, fontSize: 13),
                  )),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _label(String t) => Text(t,
      style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.w600, fontSize: 14));

  Widget _field({required TextEditingController controller, required String hint, required IconData icon}) =>
      TextField(
        controller: controller,
        style: const TextStyle(color: Colors.white, fontSize: 16),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white24),
          prefixIcon: Icon(icon, color: const Color(0xFF2563EB)),
          filled: true,
          fillColor: const Color(0xFF111827),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFF2563EB), width: 2)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
      );
}