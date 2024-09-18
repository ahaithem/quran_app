import 'package:flutter/material.dart';

class SurahDetailScreen extends StatefulWidget {
  final int startingImageIndex;

  SurahDetailScreen({required this.startingImageIndex});

  @override
  _SurahDetailScreenState createState() => _SurahDetailScreenState();
}

class _SurahDetailScreenState extends State<SurahDetailScreen>
    with SingleTickerProviderStateMixin {
  int _currentImageIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>(); // Create a GlobalKey
  bool _isDrawerOpen = false; // Track drawer state
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  bool _showAppBar = false; // Track whether to show the AppBar

  @override
  void initState() {
    super.initState();
    _currentImageIndex = widget.startingImageIndex; // Set the initial image

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

  // Total number of images (from 1 to 604)
  final int totalImages = 604;

  // Method to get the image path by index
  String getImagePath(int index) {
    return 'assets/images/${index}.png'; // Assuming your images are in assets/images/
  }

  void _navigateToHome() {
    Navigator.popUntil(context, ModalRoute.withName('/'));
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
    return Scaffold(
      key: _scaffoldKey, // Assign the GlobalKey to the Scaffold
      body: Stack(
        children: [
          // Image Background
          GestureDetector(
            onTap: () {
              _toggleAppBar(); // Toggle the AppBar visibility
              _closeDrawer(); // Close the drawer when tapping on the image
            },
            onHorizontalDragEnd: (details) {
              if (details.primaryVelocity != null) {
                setState(() {
                  if (details.primaryVelocity! > 0) {
                    // Swiping right (left-to-right) -> Go to next image
                    if (_currentImageIndex < totalImages) {
                      _currentImageIndex++;
                    }
                  } else if (details.primaryVelocity! < 0) {
                    // Swiping left (right-to-left) -> Go to previous image
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
                child: Image.asset(
                  getImagePath(_currentImageIndex),
                  key: ValueKey<int>(
                      _currentImageIndex), // Key to track the current image
                  fit: BoxFit.fill, // Make the image cover the entire screen
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),
          ),
          // AppBar
          if (_showAppBar)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AppBar(
                title: Text(
                  'Surah Images',
                  style: TextStyle(color: Colors.white),
                ),
                automaticallyImplyLeading:
                    false, // Removes the default back button
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
                ],
                backgroundColor:
                    Colors.black.withOpacity(0.8), // Transparent background
                elevation: 0, // Remove shadow
              ),
            ),
          // Drawer
          SlideTransition(
            position: _offsetAnimation,
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 8, top: 100),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  child: Container(
                    width: MediaQuery.of(context).size.width *
                        0.7, // Custom width (70% of screen width)
                    height: MediaQuery.of(context).size.height *
                        0.7, // Custom height (70% of screen height)
                    color: Colors.black
                        .withOpacity(0.8), // Transparent black background
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        _buildDrawerItem(
                          icon: Icons.book,
                          text: 'البند الأول', // "Item 1" in Arabic
                          onTap: () {
                            // Handle item 1 tap
                          },
                        ),
                        _buildDrawerItem(
                          icon: Icons.favorite,
                          text: 'البند الثاني', // "Item 2" in Arabic
                          onTap: () {
                            // Handle item 2 tap
                          },
                        ),
                        // Add more items as needed
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

  // Helper method to build a custom drawer item
  Widget _buildDrawerItem(
      {required IconData icon,
      required String text,
      required GestureTapCallback onTap}) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: Colors.white),
          title: Text(
            text,
            style: TextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
            textAlign: TextAlign.right, // Align text to the right
          ),
          onTap: onTap,
          tileColor: Colors.black.withOpacity(0.2), // Tile background
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: BorderSide(color: Colors.white.withOpacity(0.4)), // Border
          ),
        ),
        Divider(color: Colors.white.withOpacity(0.3)), // Divider between items
      ],
    );
  }
}
