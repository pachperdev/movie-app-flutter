import 'package:flutter/material.dart';
import 'package:movie_app/screens/home_screen.dart';
import 'package:movie_app/screens/profile_screen.dart';
import 'package:movie_app/search/search_delegate.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({super.key});

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  static int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentPage,
      showSelectedLabels: true,
      backgroundColor: const Color.fromARGB(255, 18, 18, 18),
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
      onTap: (int inIndex) {
        _currentPage = inIndex;
        if (inIndex == 0) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => const HomeScreen(),
            ),
            ModalRoute.withName('/'),
          );
        } else if (inIndex == 1) {
          showSearch(context: context, delegate: MovieSearchDelegate());
        } else if (inIndex == 2) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => const ProfileScreen(),
            ),
            ModalRoute.withName('/'),
          );
        }
        setState(() {});
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Inicio',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Buscar',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Perfil',
        )
      ],
    );
  }
}
