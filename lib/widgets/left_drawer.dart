import 'package:flutter/material.dart';
import 'package:myportfolio_mobile/screens/menu.dart';
import 'package:myportfolio_mobile/screens/artwork_form.dart';
import 'package:myportfolio_mobile/screens/gallery_page.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Color(0xFF1C1917)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('My Portfolio', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
                SizedBox(height: 8),
                Text('Explore my creative space!', style: TextStyle(fontSize: 14, color: Colors.white70)),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Home'),
            onTap: () {
              // Pake pushAndRemoveUntil biar history-nya bersih waktu balik ke Home
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage()),
                (Route<dynamic> route) => false,
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.brush_outlined),
            title: const Text('Art Gallery'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const GalleryPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_photo_alternate_outlined),
            title: const Text('Add Artwork'),
            onTap: () {
              // Pindah ke form tanpa numpuk history form sebelumnya
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ArtworkFormPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}