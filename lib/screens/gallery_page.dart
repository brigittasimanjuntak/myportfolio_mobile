import 'package:flutter/material.dart';
import 'package:myportfolio_mobile/models/artwork.dart';
import 'package:myportfolio_mobile/services/api_client.dart';
import 'package:myportfolio_mobile/widgets/left_drawer.dart';
import 'package:provider/provider.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});
  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  late Future<List<Artwork>> _artworksFuture;

  @override
  void initState() {
    super.initState();
    _artworksFuture = context.read<ApiClient>().getArtworks();
  }

  Future<void> _reload() async {
    final future = context.read<ApiClient>().getArtworks();
    setState(() => _artworksFuture = future);
    await future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Art Gallery')),
      drawer: const LeftDrawer(),
      body: FutureBuilder<List<Artwork>>(
        future: _artworksFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Gagal memuat: ${snapshot.error}'));
          }
          final artworks = snapshot.data ?? [];
          if (artworks.isEmpty) {
            return const Center(child: Text('Belum ada artwork.'));
          }
          return RefreshIndicator(
            onRefresh: _reload,
            child: ListView.builder(
              itemCount: artworks.length,
              itemBuilder: (context, index) {
                final art = artworks[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    leading: art.imageUrl.isNotEmpty 
                        ? Image.network(art.imageUrl, width: 50, height: 50, fit: BoxFit.cover)
                        : const Icon(Icons.image),
                    title: Text(art.title),
                    subtitle: Text('by ${art.artist} • ${art.medium}'),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}