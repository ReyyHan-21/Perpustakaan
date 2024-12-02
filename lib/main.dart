import 'package:crud_perpustakaan/pages/home_page.dart';
import 'package:crud_perpustakaan/pages/Auth/login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://fsgrnkslgxohvsacspmx.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZzZ3Jua3NsZ3hvaHZzYWNzcG14Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzE3MjY1MjIsImV4cCI6MjA0NzMwMjUyMn0.cP8Ki-w1uC1-HZl2zGB9RloM8Sn1TzIZLVMSkkHrVv0',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Digital Library',
      home: FutureBuilder(
        future: _checkLoginStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child:
                    CircularProgressIndicator()); // Menampilkan loader saat memeriksa status login
          } else {
            return snapshot.data as bool
                ? const BookListPage()
                : const LoginPage(); // Arahkan ke HomePage jika sudah login, jika tidak ke LoginPage
          }
        },
      ),
      debugShowCheckedModeBanner: false,
    );
  }

  Future<bool> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false; // Mengembalikan status login
  }
}
