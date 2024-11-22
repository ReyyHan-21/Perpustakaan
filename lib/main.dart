import 'package:crud_perpustakaan/pages/home_page.dart';
import 'package:flutter/material.dart';
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
    return const MaterialApp(
      title: 'Digital Library',
      home: BookListPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
