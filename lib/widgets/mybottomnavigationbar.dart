import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:plant_app/screens/addplantscreen.dart';
import 'package:plant_app/screens/calendarscreen.dart';
import 'package:plant_app/screens/plantscreen.dart';

class MyBottomNavigationBar extends StatelessWidget {
  const MyBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {

    final PersistentTabController controller = PersistentTabController(initialIndex: 0);
    return PersistentTabView(
        tabs: [
          PersistentTabConfig(
            screen: PlantScreen(),
            item: ItemConfig(
              icon: Icon(Icons.home),
              title: "Le tue piante",
              activeForegroundColor: Color.fromARGB(255, 0, 167, 107),
            ),
          ),
          PersistentTabConfig(
            screen: AddPlantScreen(controller: controller),
            item: ItemConfig(
              icon: Icon(Icons.add_a_photo),
              title: "Aggiungi pianta",
              activeForegroundColor: Color.fromARGB(255, 0, 167, 107),
            ),
          ),

          PersistentTabConfig(
            screen: CalendarScreen(),
            item: ItemConfig(
                icon: Icon(Icons.calendar_today),
                title: 'calendario',
                activeForegroundColor: Color.fromARGB(255, 0, 167, 107),
            ),
          ),
          PersistentTabConfig(
            screen: Center(),
            item: ItemConfig(
              icon: Icon(Icons.eco),
              title: "Piante consigliate",
              activeForegroundColor: Color.fromARGB(255, 0, 167, 107),
            ),
          ),
        ],
        navBarBuilder: (navBarConfig) => Style1BottomNavBar(
          navBarConfig: navBarConfig,
        )
    );

  }



}
