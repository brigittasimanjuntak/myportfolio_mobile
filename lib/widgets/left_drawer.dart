import 'package:flutter/material.dart';
import 'package:myportfolio_mobile/screens/menu.dart';
import 'package:myportfolio_mobile/screens/artwork_form.dart';
import 'package:myportfolio_mobile/screens/gallery_page.dart';
import 'package:myportfolio_mobile/services/auth_state.dart';
import 'package:myportfolio_mobile/widgets/auth_guard.dart';
import 'package:provider/provider.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = context.watch<AuthState>().isLoggedIn;
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
            onTap: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => MyHomePage()), (route) => false),
          ),
          ListTile(
            leading: const Icon(Icons.brush_outlined),
            title: const Text('Art Gallery'),
            onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const GalleryPage())),
          ),
          ListTile(
            leading: const Icon(Icons.add_photo_alternate_outlined),
            title: const Text('Add Artwork'),
            onTap: () async {
              final ok = await ensureLoggedIn(context);
              if (ok && context.mounted) {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ArtworkFormPage()));
              }
            },
          ),
          const Divider(),
          if (!isLoggedIn)
            ListTile(
              leading: const Icon(Icons.login, color: Colors.blue),
              title: const Text('Login (Admin)', style: TextStyle(color: Colors.blue)),
              onTap: () async {
                Navigator.pop(context);
                await ensureLoggedIn(context);
              },
            )
          else
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Logout', style: TextStyle(color: Colors.red)),
              onTap: () {
                context.read<AuthState>().logout();
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Berhasil Logout!')));
              },
            ),
        ],
      ),
    );
  }
}