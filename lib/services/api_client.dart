import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myportfolio_mobile/config.dart';
import 'package:myportfolio_mobile/models/artwork.dart';

class ApiException implements Exception {
  const ApiException(this.statusCode, this.message);
  final int statusCode;
  final String message;
  @override
  String toString() => 'ApiException($statusCode): $message';
}

class ApiClient {
  ApiClient({http.Client? client, this.baseUrl = apiBaseUrl})
      : _client = client ?? http.Client();

  final http.Client _client;
  final String baseUrl;

  Uri _uri(String path) => Uri.parse('$baseUrl$path');

  // 1. Ambil list artwork
  Future<List<Artwork>> getArtworks() async {
    final response = await _client.get(
      _uri('/api/v1/creativespaces/'),
      headers: const {'Accept': 'application/json'},
    );
    _ensureSuccess(response);

    final decoded = jsonDecode(response.body) as List<dynamic>;
    return decoded.map((item) => Artwork.fromJson(item as Map<String, dynamic>)).toList();
  }

  // 2. Login dapet Token
  Future<String> obtainToken(String username, String password) async {
    final response = await _client.post(
      _uri('/api/v1/auth/token/'),
      headers: const {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );
    _ensureSuccess(response);
    final decoded = jsonDecode(response.body);
    return decoded['token'] as String;
  }

  // 3. Logout hapus token
  Future<void> logout({required String token}) async {
    final response = await _client.post(
      _uri('/api/v1/auth/logout/'),
      headers: {'Authorization': 'Token $token'},
    );
    _ensureSuccess(response);
  }

  // 4. Tambah Artwork Baru (Butuh Token)
  Future<Artwork> createArtwork(Artwork artwork, {required String token}) async {
    final response = await _client.post(
      _uri('/api/v1/creativespaces/'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Token $token',
      },
      body: jsonEncode(artwork.toJson()),
    );
    _ensureSuccess(response);
    return Artwork.fromJson(jsonDecode(response.body));
  }

  void _ensureSuccess(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) return;
    throw ApiException(response.statusCode, response.body);
  }
}