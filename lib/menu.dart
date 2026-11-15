import 'package:flutter/material.dart';

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
                        return ItemCard(item);
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

// MODEL & KOMPONEN ITEM CARD
class ItemHomepage {
  final String name;
  final IconData icon;
  final Color color;

  ItemHomepage(this.name, this.icon, this.color);
}

class ItemCard extends StatelessWidget {
  final ItemHomepage item;

  const ItemCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.color,
      borderRadius: BorderRadius.circular(16),
      elevation: 6,
      shadowColor: item.color.withOpacity(0.6),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text("Kamu telah menekan tombol ${item.name}!"),
                backgroundColor: const Color(0xFF1C1917),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            );
        },
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon, 
                  color: item.color == const Color(0xFFFFD800) ? const Color(0xFF1C1917) : Colors.white, 
                  size: 36.0
                ),
                const SizedBox(height: 8),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: item.color == const Color(0xFFFFD800) ? const Color(0xFF1C1917) : Colors.white, 
                    fontWeight: FontWeight.w700,
                    fontSize: 12
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}