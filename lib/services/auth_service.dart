import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'dart:io' show Platform;

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final String _backendUrl = 'YOUR_BACKEND_URL'; // Replace with your server URL
  final _storage = FlutterSecureStorage();

  Future<String?> signInWithGoogle() async {
    // ... (Google Sign-In code from previous example)
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

      final response = await http.post(
        Uri.parse('$_backendUrl/auth/google'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'idToken': googleAuth.idToken}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['token'];
        await _storage.write(key: 'jwt_token', value: token);
        return token;
      } else {
        print('Backend error: ${response.statusCode}, ${response.body}');
        return null;
      }
    } catch (error) {
      print('Google sign-in error: $error');
      return null;
    }
  }

  Future<String?> signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        final AccessToken accessToken = result.accessToken!;
        final response = await http.post(
          Uri.parse('$_backendUrl/auth/facebook'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'accessToken': accessToken.token}),
        );

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          final token = data['token'];
          await _storage.write(key: 'jwt_token', value: token);
          return token;
        } else {
          print('Backend error: ${response.statusCode}, ${response.body}');
          return null;
        }
      } else {
        print('Facebook login failed: ${result.status}');
        return null;
      }
    } catch (error) {
      print('Facebook sign-in error: $error');
      return null;
    }
  }

  Future<String?> signInWithApple() async {
    try {
      final AuthorizationCredentialApple appleCredential =
          await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final response = await http.post(
        Uri.parse('$_backendUrl/auth/apple'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'idToken': appleCredential.identityToken}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['token'];
        await _storage.write(key: 'jwt_token', value: token);
        return token;
      } else {
        print('Backend error: ${response.statusCode}, ${response.body}');
        return null;
      }
    } catch (error) {
      print('Apple sign-in error: $error');
      return null;
    }
  }

  Future<String?> getToken() async {
    return await _storage.read(key: 'jwt_token');
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await FacebookAuth.instance.logOut();
    await _storage.delete(key: 'jwt_token');
  }

  Future<http.Response?> authenticatedRequest(String url, {Map<String, String>? headers, dynamic body}) async {
    // ... (Authenticated request code from previous example)
    final token = await getToken();
    if (token == null) {
      return null;
    }

    final newHeaders = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
      ...?headers,
    };

    if (body != null) {
      return http.post(Uri.parse(url), headers: newHeaders, body: jsonEncode(body));
    } else {
      return http.get(Uri.parse(url), headers: newHeaders);
    }
  }
}


// Add these to your pubspec.yaml:
// flutter_facebook_auth: ^5.0.0 (or latest)
// sign_in_with_apple: ^5.0.0 (or latest)