import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Text(
          'Tidak tersedia. Fitur masih dalam pengembangan.',
          style: TextStyle(
            color: Theme.of(context).unselectedWidgetColor,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
