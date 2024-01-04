import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

class AppDrawerHeader extends StatelessWidget {
  // ignore: unused_element
  const AppDrawerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      child: Row(
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
            child: WebsafeSvg.asset('assets/akurat-icon.svg', width: 32),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Akurat Mobile',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              Opacity(
                opacity: 0.8,
                child: Text(
                  'Cepat, Tepat, Benar.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
