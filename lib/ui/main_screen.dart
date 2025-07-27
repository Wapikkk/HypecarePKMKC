import 'package:flutter/material.dart';
import 'package:hypecare_pkmkc/ui/home_screen.dart';
import 'package:hypecare_pkmkc/ui/history_screen.dart';
import 'package:hypecare_pkmkc/ui/feedback_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    HistoryScreen(),
    FeedbackScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const Color _primaryBlue = Color.fromRGBO(90, 157, 255, 1);
  static const Color _indicatorColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 150,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/image/logo-hypecare.png',
                height: 30,
              ),
              SizedBox(width: 7),
              Text(
                'Hypecare',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: _primaryBlue,
                ),
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: _primaryBlue,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(
                  Icons.notifications,
                  color: _indicatorColor,
                ),
                onPressed: () {
                  print('Notifications tapped');
                },
              ),
            ),
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: _primaryBlue,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8.0,
              spreadRadius: 2.0,
            ),
          ],
        ),
        child: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Column(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: 4,
                    width: _selectedIndex == 0 ? 30 : 0,
                    decoration: BoxDecoration(
                      color: _indicatorColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Icon(Icons.home, color: _indicatorColor),
                ],
              ),
              label: 'Beranda',
            ),
             BottomNavigationBarItem(
              icon: Column(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: 4,
                    width: _selectedIndex == 1 ? 30 : 0,
                    decoration: BoxDecoration(
                      color: _indicatorColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Icon(Icons.history),
                ],
              ),
              label: 'Riwayat',
            ),
            BottomNavigationBarItem(
              icon: Column(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: 4,
                    width: _selectedIndex == 2 ? 30 : 0,
                    decoration: BoxDecoration(
                      color: _indicatorColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Icon(Icons.feedback),
                ],
              ),
              label: 'Umpan Balik',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: _indicatorColor,
          unselectedItemColor: _indicatorColor,
          onTap: _onItemTapped,
          backgroundColor: _primaryBlue,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: const TextStyle(
            fontFamily: 'Inika',
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: const TextStyle(
            fontFamily: 'Inika',
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

