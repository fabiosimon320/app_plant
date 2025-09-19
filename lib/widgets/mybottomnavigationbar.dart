import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:plant_app/screens/plantscreen.dart';

class MyBottomNavigationBar extends StatelessWidget {
  const MyBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
        tabs: [
          PersistentTabConfig(
            screen: PlantScreen(),
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



}
