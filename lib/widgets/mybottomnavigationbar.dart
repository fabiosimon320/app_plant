import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:plant_app/screens/addplantscreen.dart';
import 'package:plant_app/screens/calendarscreen.dart';
import 'package:plant_app/screens/plantscreen.dart';

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({super.key});

  @override
  State<StatefulWidget> createState() => MyBottomNavigationBarState();


}

class MyBottomNavigationBarState extends State<MyBottomNavigationBar> {

  late PersistentTabController controller;

  @override
  void initState() {
    super.initState();
    controller = PersistentTabController(initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {

    return PersistentTabView(

      controller: controller,
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
        ],
        navBarBuilder: (navBarConfig) => Style1BottomNavBar(
          navBarConfig: navBarConfig,
        )
    );

  }



}
