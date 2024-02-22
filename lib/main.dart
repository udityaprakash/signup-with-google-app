import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Sign-In Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignInScreen(),
    );
  }
}

class SignInScreen extends StatelessWidget {
  // final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  Future<void> _handleSignIn(BuildContext context) async {
    try {
      await googleapi.signIn();
      // await _googleSignIn.signIn();
      log(googleapi.userinfo().toString());
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserDetailsScreen(user: googleapi.userinfo()),
        ),
      );
    } catch (error) {
      log(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In with Google'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _handleSignIn(context),
              // onPressed: () => signin(),
              child: Text('Continue with Google'),
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     // _googleSignIn.signOut();
            //   },
            //   // onPressed: () => signin(),
            //   child: Text('signout'),
            // ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Center(child: Text('Made by Uditya Prakash in ❤️')),
      )
    );
  }
}

class UserDetailsScreen extends StatelessWidget {
  final GoogleSignInAccount? user;

  UserDetailsScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome, ${user?.displayName ?? "User"}!',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(user?.photoUrl ?? 'https://media.istockphoto.com/id/1354776457/vector/default-image-icon-vector-missing-picture-page-for-website-design-or-mobile-app-no-photo.jpg?s=612x612&w=0&k=20&c=w3OW0wX3LyiFRuDHo9A32Q0IUMtD4yjXEvQlqyYk9O4='),
            ),
            SizedBox(height: 20),
            Text(
              'ID: ${user?.id ?? "User"}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              '${user?.email ?? "User"}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                googleapi.signOut();
                // _googleSignIn.signOut();
                Navigator.pop(context);
              },
              child: Text('Sign Out'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Center(child: Text('Made by Uditya Prakash in ❤️')),
      )
    );
  }
}

// Future signin() async {
//   try {
//     await googleapi.signIn();
//   } catch (e) {
//     log(e.toString());
//   }
// }

class googleapi {
  static final _googleSignIn = GoogleSignIn();
  static Future<GoogleSignInAccount?> signIn() => _googleSignIn.signIn();
  static GoogleSignInAccount? userinfo() => _googleSignIn.currentUser;
  static Future<void> signOut() => _googleSignIn.signOut();
}
