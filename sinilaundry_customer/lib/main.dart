import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';

import 'core/theme/app_theme.dart';
import 'package:sinilaundry_customer/core/routes/app_router.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true, // set ke false kalau mau build production
      builder: (context) => const SiniLaundryApp(),
    ),
  );
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
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
    );
  }
}