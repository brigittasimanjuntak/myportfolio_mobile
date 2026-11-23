import 'package:flutter/material.dart';
import 'package:myportfolio_mobile/screens/artwork_form.dart';
import 'package:myportfolio_mobile/screens/gallery_page.dart';

// Model Data
class ItemHomepage {
  final String name;
  final IconData icon;
  final Color color;

  ItemHomepage(this.name, this.icon, this.color);
}

// Widget Card
class ArtworkCard extends StatelessWidget {
  final ItemHomepage item;

  const ArtworkCard(this.item, {super.key});

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
          // 1. Munculin SnackBar DULU
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text("Kamu telah menekan tombol ${item.name}!"),
                backgroundColor: const Color(0xFF1C1917),
                behavior: SnackBarBehavior.floating,
              ),
            );

          // 2. Fitur Navigasi 
          if (item.name == "Add Artwork!") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ArtworkFormPage()),
            );
          } else if (item.name == "Art Gallery!") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const GalleryPage()),
            );
          }
        },
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: item.color == const Color(0xFFFFD800)
                      ? const Color(0xFF1C1917)
                      : Colors.white,
                  size: 36.0,
                ),
                const SizedBox(height: 8),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: item.color == const Color(0xFFFFD800)
                        ? const Color(0xFF1C1917)
                        : Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
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