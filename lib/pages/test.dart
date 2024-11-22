import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BookListPage extends StatefulWidget {
  const BookListPage({super.key});

  @override
  _BookListPageState createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  // Buat varible untuk menyimpan daftar buku
  List<Map<String, dynamic>> books = [];

  @override
  void initState() {
    super.initState();
    fetchBooks(); //Panggil fungsi untuk fetch data buku
  }

  //Fungsi untuk mengambil data buku dari Supabase
  Future fetchBooks() async {
    final response = await Supabase.instance.client.from('books').select();

    setState(() {
      books = List<Map<String, dynamic>>.from(response);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Daftar Buku"),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: fetchBooks,
          ),
        ],
      ),
      body: books.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];
                return ListTile(
                  title: Text(
                    book['title'] ?? "Not Title",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        book['author'] ?? "No Author",
                        style: const TextStyle(
                            fontStyle: FontStyle.italic, fontSize: 14),
                      ),
                      Text(
                        book['description'] ?? "No Description",
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      )
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //Tombol Edit
                      IconButton(
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.blue,
                        ),
                        onPressed: () {
                          //Arahkan ke halaman EditBookPage dengan mengirim
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => EditBookPage(book: book),
                          //   ),
                          // ).then((_) {
                          //     fetchBooks();
                          //   },
                          // );
                        },
                      ),
                      //Tombol Delete
                      IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Delete Book"),
                                content: const Text(
                                    "Are you sure you want to delete this book?"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("Cancel"),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      // await deleteBook(book['id']);
                                      // ignore: use_build_context_synchronously
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("Delete"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      )
                    ],
                  ),
                );
              },
            ),
    );
  }
}
