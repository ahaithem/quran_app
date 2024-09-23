import 'package:flutter/material.dart';
import '../models/all_surahs.dart';
import '../models/all_ahzab.dart' as all_ahzab;
import './last_page.dart';
import '../providers/theme_provider.dart';
import 'package:provider/provider.dart';

class SurahDetailScreen extends StatefulWidget {
  final int startingImageIndex;

  SurahDetailScreen({
    required this.startingImageIndex,
  });

  @override
  _SurahDetailScreenState createState() => _SurahDetailScreenState();
}

class _SurahDetailScreenState extends State<SurahDetailScreen>
    with SingleTickerProviderStateMixin {
  int _currentImageIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isDrawerOpen = false;
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  bool _showAppBar = false;
  // Track the marked image index
  int? _markedImageIndex;

  @override
  void initState() {
    super.initState();
    _currentImageIndex = widget.startingImageIndex;

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    _offsetAnimation =
        Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
            .animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final int totalImages = 604;

  String getImagePath(int index) {
    return 'assets/images/${index}.png';
  }

  void _navigateToHome() {
    Navigator.popUntil(context, ModalRoute.withName('/'));
  }

  String _getSurahNameForIndex(int index) {
    for (var entry in surahPages.entries) {
      if (index >= entry.value) {
        if (entry.key == surahPages.keys.last ||
            index <
                surahPages[surahPages.keys.elementAt(
                    surahPages.keys.toList().indexOf(entry.key) + 1)]!) {
          return entry.key;
        }
      }
    }
    return 'Unknown Surah';
  }

  // Method to mark the current image
  void _putTheMark() {
    setState(() {
      _markedImageIndex =
          _currentImageIndex; // Set the mark for the current image
    });
  }

  void _moveToTheMark() {
    setState(() {
      if (_markedImageIndex != null) {
        _currentImageIndex =
            _markedImageIndex!; // Move to the marked image index
      } else {
        // Optionally show a message if no mark is set
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No mark has been set.')),
        );
      }
    });
  }

  void _toggleDrawer() {
    setState(() {
      if (_isDrawerOpen) {
        _controller.reverse();
      } else {
        _controller.forward();
      }
      _isDrawerOpen = !_isDrawerOpen;
    });
  }

  void _closeDrawer() {
    if (_isDrawerOpen) {
      setState(() {
        _controller.reverse();
        _isDrawerOpen = false;
      });
    }
  }

  void _toggleAppBar() {
    setState(() {
      _showAppBar = !_showAppBar;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              _toggleAppBar();
              _closeDrawer();
            },
            onHorizontalDragEnd: (details) {
              if (details.primaryVelocity != null) {
                setState(() {
                  if (details.primaryVelocity! > 0) {
                    if (_currentImageIndex < totalImages) {
                      _currentImageIndex++;
                    }
                  } else if (details.primaryVelocity! < 0) {
                    if (_currentImageIndex > 1) {
                      _currentImageIndex--;
                    }
                  }
                });
              }
            },
            child: Center(
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 500),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(opacity: animation, child: child);
                },
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    themeProvider.isDarkMode
                        ? Colors.black.withOpacity(0.5)
                        : Colors.transparent,
                    BlendMode.darken,
                  ),
                  child: Image.asset(
                    getImagePath(_currentImageIndex),
                    key: ValueKey<int>(_currentImageIndex),
                    fit: BoxFit.fill,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              ),
            ),
          ),
          // AppBar and other widgets remain unchanged
          if (_showAppBar)
            Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: AppBar(
                    title: Text(
                      'القائمة الرئيسية',
                      style: TextStyle(color: Colors.white),
                    ),
                    automaticallyImplyLeading: false,
                    actions: [
                      IconButton(
                        onPressed: _navigateToHome,
                        icon: Icon(Icons.home, color: Colors.white),
                      ),
                      IconButton(
                        onPressed: _toggleDrawer,
                        icon: const Icon(
                          Icons.menu,
                          color: Colors.white,
                        ),
                      ),
                      // Display the checkmark if the current image is marked
                      if (_markedImageIndex == _currentImageIndex)
                        Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                    ],
                    backgroundColor: Colors.black.withOpacity(0.8),
                    elevation: 0,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 50,
                    color: Colors.black.withOpacity(0.8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          _getSurahNameForIndex(_currentImageIndex),
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          'الحزب ${all_ahzab.getHizbNumberForIndex(_currentImageIndex)}',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          SlideTransition(
            position: _offsetAnimation,
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 8, top: 100),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: MediaQuery.of(context).size.height * 0.7,
                    color: Colors.black.withOpacity(0.8),
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        _buildDrawerItem(
                          imagePath: 'assets/images/favori.png',
                          text: 'فضل قراءة الفران',
                          onTap: () {},
                        ),
                        _buildDrawerItem(
                          imagePath: 'assets/images/menu.png',
                          text: 'الفهرس',
                          onTap: _navigateToHome,
                        ),
                        _buildDrawerItem(
                          imagePath: 'assets/images/save_icon.png',
                          text: 'put the mark',
                          onTap: _putTheMark, // Call _putTheMark when tapped
                        ),
                        _buildDrawerItem(
                          imagePath: 'assets/images/save_icon.png',
                          text: 'move to the mark',
                          onTap: _moveToTheMark,
                        ),
                        _buildDrawerItem(
                          imagePath: 'assets/images/khetm_icon.png',
                          text: 'دعاء الختم',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LastPage()),
                            );
                          },
                        ),
                        _buildDrawerItem(
                          imagePath: 'assets/images/ampoule.png',
                          text: 'سطوع الشاشة',
                          onTap: () {},
                        ),
                        _buildDrawerItem(
                          imagePath: 'assets/images/mode-nuit.png',
                          text: 'dark mode',
                          onTap: () {
                            Provider.of<ThemeProvider>(context, listen: false)
                                .toggleTheme();
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required String imagePath,
    required String text,
    required GestureTapCallback onTap,
  }) {
    return Column(
      children: [
        ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  text,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
              ),
              Image.asset(
                imagePath,
                width: 24,
                height: 24,
                color: Colors.white,
              ),
            ],
          ),
          onTap: onTap,
          tileColor: Colors.black.withOpacity(0.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: BorderSide(color: Colors.white.withOpacity(0.4)),
          ),
        ),
        Divider(color: Colors.white.withOpacity(0.3)),
      ],
    );
  }
}
