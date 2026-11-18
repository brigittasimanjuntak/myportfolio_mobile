import 'package:flutter/material.dart';
import 'package:myportfolio_mobile/widgets/left_drawer.dart';
import 'package:myportfolio_mobile/screens/artwork_form.dart';
import 'package:myportfolio_mobile/widgets/artwork_card.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final String npm = "2506601855"; 
  final String nama = "Brigitta"; 
  final String kelas = "PBP B"; 

  final Color panPink = const Color(0xFFFF218D); 
  final Color panYellow = const Color(0xFFFFD800);
  final Color panBlue = const Color(0xFF1B8DFF);


  final List<ItemHomepage> items = [
    ItemHomepage("Art Gallery!", Icons.brush_rounded, const Color(0xFFFF218D)), 
    ItemHomepage("Add Artwork!", Icons.add_photo_alternate_rounded, const Color(0xFFFFD800)), 
    ItemHomepage("Logout!", Icons.logout_rounded, const Color(0xFF1BB3FF)), 
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA), 
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF1C1917), 
        title: const Text(
          'MyPortfolio',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
      ),
      drawer: const LeftDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Baris InfoCard
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InfoCard(title: 'NPM', content: npm, icon: Icons.badge_rounded, iconColor: panPink),
                InfoCard(title: 'Name', content: nama, icon: Icons.person_rounded, iconColor: panYellow),
                InfoCard(title: 'Class', content: kelas, icon: Icons.school_rounded, iconColor: panBlue),
              ],
            ),
            const SizedBox(height: 30.0),
            
            // Area Grid Menu
            Expanded(
              child: Center(
                child: Column(
                  children: [
                    const Text(
                      'Welcome to My Creative Space! 🎨',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22.0,
                        color: Color(0xFF1C1917),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20.0),
                    GridView.count(
                      primary: false,
                      padding: const EdgeInsets.all(10),
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      crossAxisCount: 3,
                      shrinkWrap: true,
                      children: items.map((ItemHomepage item) {
                        return ArtworkCard(item);
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// KOMPONEN INFO CARD
class InfoCard extends StatelessWidget {
  final String title;
  final String content;
  final IconData icon;
  final Color iconColor;

  const InfoCard({
    super.key, 
    required this.title, 
    required this.content, 
    required this.icon,
    required this.iconColor
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.white,
      child: Container(
        width: MediaQuery.of(context).size.width / 3.8,
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
        child: Column(
          children: [
            Icon(icon, color: iconColor, size: 28),
            const SizedBox(height: 8.0),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 4.0),
            Text(
              content,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

