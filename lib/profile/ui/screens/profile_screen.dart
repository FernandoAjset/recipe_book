import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../main.dart';
import '../../../theme/infraestructure/config/app_theme.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    final isDark = theme.brightness == Brightness.dark;
    final themeNotifier = ref.read(themeProvider.notifier);

    return Scaffold(
      body: Center(
        child: ElevatedButton.icon(
          onPressed: () {
            if (isDark) {
              themeNotifier.setTheme(AppTheme.lightTheme);
            } else {
              themeNotifier.setTheme(AppTheme.darkTheme);
            }
          },
          icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
          label: Text(isDark ? 'Light Mode' : 'Dark Mode'),
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.primaryColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ),
    );
  }
}
