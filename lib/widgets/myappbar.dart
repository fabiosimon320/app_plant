import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {

  final String title;
  final bool showBackButton;

   const MyAppBar({
    super.key,
    required this.title,
    this.showBackButton = false,
  });



  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: GoogleFonts.roboto(
            color: Color.fromARGB(255, 0, 167, 107),
            fontWeight: FontWeight.bold,
        ),
      ),

      scrolledUnderElevation: 0.0,
      backgroundColor : Colors.white,
      foregroundColor: Color.fromARGB(255, 0, 167, 107),
      centerTitle: true,

      leading: showBackButton
          ? IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
        )
          : null, // null significa nessun tasto a sinistra
      );
    }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

}