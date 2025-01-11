import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quadb_assignment/search/screen/search_screen.dart';
import '../../home/screen/home_screen.dart';
import '../providers/navigation_provider.dart';


class BaseScreen extends StatelessWidget {

  final List<Widget> screens = [
    const HomeScreen(),
    const SearchPage()
  ];

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<BottomNavProvider>(context);

    return Scaffold(
      body: screens[provider.currentIndex],
      bottomNavigationBar: BottomAppBar(
        color: Colors.black87 ,
        shape: const CircularNotchedRectangle(),
        elevation: 0,
        notchMargin: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(child: buildIcon(context, Icons.home, 0, provider.currentIndex,"Home")),
            Expanded(child: buildIcon(context, Icons.search, 1, provider.currentIndex,"Search")),
          ],
        ),
      ),
    );
  }

  Widget buildIcon(BuildContext context, IconData icon, int index, int selectedIndex,String text) {
    return IconButton(
      onPressed: () {
        Provider.of<BottomNavProvider>(context, listen: false).changeIndex(index);
      },
      icon: Icon(
        icon,
        color: selectedIndex == index ? Colors.white : Colors.grey
      ),
      tooltip: text,
      );
  }
}


