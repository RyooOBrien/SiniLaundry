import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'package:sinilaundry_customer/core/routes/app_router.dart';

void main() {
  runApp(const SiniLaundryApp());
}

class SiniLaundryApp extends StatelessWidget {
  const SiniLaundryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'SiniLaundry',
      theme: AppTheme.lightTheme,
      routerConfig: AppRouter.router,
    );
  }
}