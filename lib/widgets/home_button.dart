import 'package:flutter/material.dart';
import 'package:pilem/main.dart';
import 'package:pilem/colors.dart';

class HomeBtn extends StatelessWidget {
  const HomeBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 50,
      margin: const EdgeInsets.only(top: 16, right: 16),
      decoration: BoxDecoration(
        color: Colours.scaffoldBgColor, // Background semi-transparan
        borderRadius: BorderRadius.circular(8),
      ),
      child: IconButton(
        onPressed: () {
          // Navigasi ke halaman HomePage dengan menghapus semua halaman sebelumnya
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    const MyApp()), // Gunakan MyApp untuk memulai aplikasi
            (route) => false, // Hapus semua halaman sebelumnya dari stack
          );
        },
        icon: const Icon(
          Icons.home_rounded,
          color: Colors.white, // Warna putih untuk ikon
        ),
      ),
    );
  }
}
