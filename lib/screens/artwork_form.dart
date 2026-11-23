import 'package:flutter/material.dart';
import 'package:myportfolio_mobile/widgets/left_drawer.dart';

class ArtworkFormPage extends StatefulWidget {
  const ArtworkFormPage({super.key});

  @override
  State<ArtworkFormPage> createState() => _ArtworkFormPageState();
}

class _ArtworkFormPageState extends State<ArtworkFormPage> {
  final _formKey = GlobalKey<FormState>();
  
  String _title = "";
  String _artist = "";
  String _medium = "digital-art"; 
  String _imageUrl = "";
  String _description = "";

  final List<String> _mediums = [
    'digital-art', 'traditional', 'sketch', '3d-model', 'photography', 'other',
  ];

  // UI II A
  Widget _buildTextInput({
    required String label,
    required String hint,
    required ValueChanged<String> onChanged,
    int maxLines = 1,
    bool isRequired = true,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hint,
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
        onChanged: onChanged,
        validator: (String? value) {
          if (isRequired && (value == null || value.trim().isEmpty)) {
            return "$label tidak boleh kosong!";
          }
          return null;
        },
      ),
    );
  }

  void _showSummaryDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Artwork berhasil ditambahkan!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text('Title: $_title'),
                const SizedBox(height: 4),
                Text('Artist: $_artist'),
                const SizedBox(height: 4),
                Text('Medium: $_medium'),
                const SizedBox(height: 4),
                Text('URL: $_imageUrl'),
                const SizedBox(height: 4),
                Text('Description: $_description'),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pop(context);
                _formKey.currentState!.reset();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add New Artwork',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF1C1917),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextInput(
                label: "Title",
                hint: "Artwork Title",
                onChanged: (val) => setState(() => _title = val),
              ),
              _buildTextInput(
                label: "Artist",
                hint: "Artist Name",
                onChanged: (val) => setState(() => _artist = val),
              ),
              
              // Dropdown Medium
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: "Art Medium",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                  ),
                  initialValue: _medium,
                  items: _mediums.map((medium) => DropdownMenuItem(
                    value: medium,
                    child: Text(medium),
                  )).toList(),
                  onChanged: (val) => setState(() => _medium = val!),
                ),
              ),

              _buildTextInput(
                label: "URL",
                hint: "https://i.imgur.com/...",
                onChanged: (val) => setState(() => _imageUrl = val),
                isRequired: true, 
              ),
              _buildTextInput(
                label: "Description",
                hint: "Describe your masterpiece...",
                onChanged: (val) => setState(() => _description = val),
                maxLines: 4,
                isRequired: false,
              ),

              // Tombol Simpan
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(const Color(0xFFFF218D)),
                      foregroundColor: WidgetStateProperty.all(Colors.white),
                      padding: WidgetStateProperty.all(
                        const EdgeInsets.symmetric(horizontal: 40, vertical: 12)
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _showSummaryDialog();
                      }
                    },
                    child: const Text("Save", style: TextStyle(fontSize: 16)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}