import 'package:crud_perpustakaan/pages/home_page.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddBookPage extends StatefulWidget {
  const AddBookPage({super.key});

  @override
  State<AddBookPage> createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  final _formKey = GlobalKey<FormState>(); // For Primary Key in table
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future _addBook(context) async {
    final title = _titleController.text;
    final author = _authorController.text;
    final description = _descriptionController.text;

    if (!_formKey.currentState!.validate()) {
      return;
    }

    final response = await Supabase.instance.client.from('books').insert({
      // Menambahkan data ke dalam database supabase yang tablenya bernama books pada field title, author, dan description
      'title': title,
      'author': author,
      'description': description,
    });

    if (response != null) {
      // Jika ada data yang tidak terisikan maka akan menampilkan error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${response.error}')),
      );
    } else {
      // Jika tidak ada error maka akan menampilkan notifikasi berhasil
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Book added successfully')),
      );
      _titleController.clear();
      _authorController.clear();
      _descriptionController.clear();
      Navigator.pop(
          context, true); // digunakan untuk kembali ke halaman sebelumnya

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const BookListPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Add New Book',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
        ),
        body: Container(
            padding: const EdgeInsets.fromLTRB(25, 20, 25, 0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _titleController,
                    validator: (value) {
                      // Untuk mengecek atau validasi apakah field tersebut kosong atau tidak
                      if (value == null || value.isEmpty) {
                        // Jika field2 tersebut kosong maka akan menampilkan pesan error
                        return 'Please enter the text';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        labelText: 'Title',
                        labelStyle: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _authorController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the text';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        labelText: 'Author',
                        labelStyle: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _descriptionController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the text';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        labelText: 'Description',
                        labelStyle: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => _addBook(context),
                    child: const Text(
                      'Add Book',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                  )
                ],
              ),
            )));
  }
}
