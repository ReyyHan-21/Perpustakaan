import 'package:crud_perpustakaan/pages/home_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isHidden = true;

  void _visiblePassword() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  void initState() {
    super.initState();
    _checkLoginStatus(); // mengecek status login saat halaman diinisialisasi
  }

  void _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn =
        prefs.getBool('IsLoggedIn') ?? false; // Mengambil status login
    DateTime lastLogin = DateTime.parse(prefs.getString('lastLogin') ??
        DateTime.now().toString()); // Mengambil waktu terakhir login
    Duration difference =
        DateTime.now().difference(lastLogin); // Menghitung jarak waktu login

    if (isLoggedIn && difference.inMinutes < 30) {
      // Jika user sudah login kurang dari 30 menit maka arahkan user ke dalam halaman Main Page
      Navigator.of(context).pushReplacement(
          // Mengarahkan user ke menu Main Page
          MaterialPageRoute(builder: (context) => const BookListPage()));
    }
  }

  void _login() async {
    if (_emailController.text == 'user@example.com' &&
        _passwordController.text == 'pass') {
      SharedPreferences prefs = await SharedPreferences
          .getInstance(); // Mengambil instance SharedPreferences
      await prefs.setBool('isLoggedIn', true); // Menyimpan Status Login
      await prefs.setString('lastLogin',
          DateTime.now().toString()); // Menyimpan waktu terakhir login
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const BookListPage()));
    } else {
      // Jika login gagal maka user akan diberikan notifikasi di bagian bawah
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Username atau Password Salah')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40, 125, 40, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Selamat Datang',
              style: GoogleFonts.poppins(
                fontSize: 28,
                fontWeight: FontWeight.w700,
              ),
            ),
            RichText(
              text: TextSpan(children: <InlineSpan>[
                TextSpan(
                  text: 'Di',
                  style: GoogleFonts.poppins(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const WidgetSpan(
                  child: SizedBox(
                    width: 5,
                  ),
                ),
                TextSpan(
                  text: 'Perpustakaan',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const WidgetSpan(
                  child: SizedBox(
                    width: 5,
                  ),
                ),
                TextSpan(
                  text: 'Digital',
                  style: GoogleFonts.poppins(
                      color: const Color(0xFF2345B5),
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
                const WidgetSpan(
                  child: SizedBox(
                    width: 5,
                  ),
                ),
                TextSpan(
                  text: 'By Atep',
                  style: GoogleFonts.poppins(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ]),
            ),
            const SizedBox(height: 77),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                  label: Text(
                    'Email',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  prefixIcon: const Icon(
                    Icons.email_outlined,
                    size: 28,
                    color: Color(0xFF2345B5),
                  )),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                  label: Text(
                    'Password',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  prefixIcon: const Icon(
                    Icons.key_rounded,
                    size: 28,
                    color: Color(0xFF2345B5),
                  ),
                  suffixIcon: InkWell(
                    onTap: _visiblePassword,
                    child: Icon(
                        _isHidden ? Icons.visibility_off : Icons.visibility),
                  )),
              obscureText:
                  _isHidden, // Menampilkan tampilan bintang agar password tidak terlihat
            ),
            const SizedBox(height: 15),
            Container(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                style: ButtonStyle(
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                ),
                child: Text(
                  'Lupa Password?',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF2345B5),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 69),
            ElevatedButton(
              onPressed: _login,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xFF2345B5), // Warna teks
                padding: const EdgeInsets.symmetric(
                    horizontal: 32.0, vertical: 16.0), // Padding tombol
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(30.0), // Membuat sudut melengkung
                ),
              ),
              child: Text(
                'Masuk',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ), // Teks pada tombol
            ),
            const SizedBox(height: 20),
            Center(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Tidak Punya Akun?',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const WidgetSpan(
                      child: SizedBox(
                        width: 5,
                      ),
                    ),
                    TextSpan(
                      text: 'Daftar Sekarang',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF2345B5),
                      ),
                      recognizer: TapGestureRecognizer(),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 70),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                    child: Container(
                  height: 2,
                  color: Colors.black,
                )),
                Text(
                  'Atau Masuk Dengan',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Flexible(
                    child: Container(
                  height: 2,
                  color: Colors.black,
                ))
              ],
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Image.asset('images/apple.png'),
                  // iconSize: 25,
                ),
                const SizedBox(width: 63),
                IconButton(
                  onPressed: () {},
                  icon: Image.asset('images/google.png'),
                  // iconSize: 25,
                ),
                const SizedBox(width: 63),
                IconButton(
                  onPressed: () {},
                  icon: Image.asset('images/fb.png'),
                  // iconSize: 25,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
