import 'package:flutter/material.dart';
import 'package:pilem/pages/home_page.dart';
import 'package:pilem/pages/genre_page.dart';
import 'package:pilem/api/api.dart'; // Pastikan untuk import API
import 'package:pilem/models/genre.dart'; // Import model Genre
import 'colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pilem',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colours.scaffoldBgColor,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  late Future<List<Genre>> genresFuture; // Future untuk data genre

  @override
  void initState() {
    super.initState();
    genresFuture = Api().getGenres(); // Memanggil API untuk mendapatkan genre
  }

  final List<Widget> _pages = [
    const HomePage(),
    // GenrePage akan dikirimkan genres sebagai parameter setelah mendapatkan data
    const GenrePage(genres: []), // Ini hanya placeholder sementara
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Image.asset(
          'assets/images/pilem_logo.png',
          fit: BoxFit.cover,
          height: 70,
          filterQuality: FilterQuality.high,
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Genre>>(
        future: genresFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final genres = snapshot.data!;
            // Update _pages dengan data genres yang telah diterima
            _pages[1] = GenrePage(genres: genres);

            return _pages[_selectedIndex];
          } else {
            return const Center(child: Text('No genres available'));
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Category',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
