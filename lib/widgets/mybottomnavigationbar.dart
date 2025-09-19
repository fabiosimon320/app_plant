import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class MyBottomNavigationBar extends StatelessWidget {
  const MyBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
        tabs: [
          PersistentTabConfig(
            screen: Center(),
            item: ItemConfig(
              icon: Icon(Icons.home),
              title: "Le tue piante",
              activeForegroundColor: Colors.green,
            ),
          ),
          PersistentTabConfig(
            screen: Center(),
            item: ItemConfig(
              icon: Icon(Icons.add_a_photo),
              title: "Aggiungi pianta",
              activeForegroundColor: Colors.green,
            ),
          ),
          PersistentTabConfig(
            screen: Center(),
            item: ItemConfig(
              icon: Icon(Icons.eco),
              title: "Piante consigliate",
              activeForegroundColor: Colors.green,
            ),
          ),
        ],
        navBarBuilder: (navBarConfig) => Style1BottomNavBar(
          navBarConfig: navBarConfig,
          navBarDecoration: NavBarDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade400,
                blurRadius: 0.5,
                offset: Offset(0,-1),
              )
            ]
          )
        )
    );

  }



 /* Widget build(BuildContext context) {
    return BottomNavigationBar(

      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.add_a_photo), label: 'Inserisci pianta'),
        BottomNavigationBarItem(icon: Icon(Icons.eco), label: 'Piante consigliate'),
      ],

      selectedIconTheme: IconThemeData(
          color: Colors.green
      ),
    );
  }*/




}
