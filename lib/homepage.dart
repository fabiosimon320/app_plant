import 'package:flutter/material.dart';
import 'package:plant_app/widgets/mybottomnavigationbar.dart';

class HomePage extends StatelessWidget{
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: MyBottomNavigationBar(),),

    );
  }

}