import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import 'package:x_pro_delivery_app/Pages/Auth.dart';
import 'package:x_pro_delivery_app/Pages/checklist_customerlist.dart';
import 'package:x_pro_delivery_app/Pages/delivery_and_invoiceList.dart';
import 'package:x_pro_delivery_app/Pages/mainPage.dart';
import 'package:x_pro_delivery_app/Screens/Delivery_main_screen.dart';
import 'package:x_pro_delivery_app/Pages/HomePage.dart';
import 'package:x_pro_delivery_app/Pages/Return_page.dart';
import 'package:x_pro_delivery_app/Pages/in_route_page.dart';
import 'package:x_pro_delivery_app/Screens/Summary_trips/collection_summary.dart';
import 'package:x_pro_delivery_app/Screens/Summary_trips/view_return_screen.dart';
import 'package:x_pro_delivery_app/Screens/greeting_splash_screen.dart';
import 'package:x_pro_delivery_app/Screens/otp_for_end_delivery.dart';
import 'package:x_pro_delivery_app/Screens/otp_start_delivery.dart';
import 'package:x_pro_delivery_app/Pages/trip_ticker_page.dart';
import 'package:x_pro_delivery_app/Screens/Item_list/document/files/document_files.dart';
import 'package:x_pro_delivery_app/Screens/TransactionDetails/dr_page.dart';
import 'package:x_pro_delivery_app/Screens/TransactionDetails/collection_screen.dart';
import 'package:x_pro_delivery_app/Screens/splashScreen.dart';
import 'package:x_pro_delivery_app/Screens/TransactionDetails/invoice_list.dart';
import 'package:x_pro_delivery_app/Screens/TransactionDetails/item_list.dart';
import 'package:x_pro_delivery_app/Screens/send_update.dart';
import 'package:x_pro_delivery_app/provider/customer_provider.dart';
import 'package:x_pro_delivery_app/provider/return_items_provider.dart';
import 'package:x_pro_delivery_app/provider/timeline_provider.dart';

// Add this line at the top of the file
final ValueNotifier<bool> greetingSplashButtonClicked =
    ValueNotifier<bool>(false);

// Rest of your main.dart code...

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ReturnedItemsProvider()),
        ChangeNotifierProvider(create: (_) => TimelineProvider()),
        ChangeNotifierProvider(create: (_) => CustomerProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/auth',
      builder: (context, state) => const AuthPage(),
    ),
    GoRoute(
      path: '/homepage',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/main-page',
      builder: (context, state) => const MainpageScreen(),
    ),
    GoRoute(
      path: '/tickettrip',
      builder: (context, state) => const TripTickerPage(),
    ),
    GoRoute(
      path: '/checklist-and-customerlist',
      builder: (context, state) => const ChecklistCustomerlist(),
    ),
    GoRoute(
      path: '/otp',
      builder: (context, state) => const OTPScreen(),
    ),
    GoRoute(
      path: '/in-route',
      builder: (context, state) => const InRoutePage(),
    ),
    GoRoute(
      path: '/delivery-and-invoice',
      builder: (context, state) => const DeliveryPage(),
    ),
    GoRoute(
      path: '/return',
      builder: (context, state) => const ReturnPage(),
    ),
    GoRoute(
      path: '/collection',
      builder: (context, state) => const CollectionScreen(),
    ),
    GoRoute(
      path: '/view-return',
      builder: (context, state) => const ViewReturnScreen(),
    ),
    GoRoute(
      path: '/dr',
      builder: (context, state) => const DrPage(),
    ),
    GoRoute(
      path: '/invoice-list',
      builder: (context, state) => const InvoiceNumberList(),
    ),
    GoRoute(
      path: '/delivery',
      builder: (context, state) => const DeliveryMainScreen(),
    ),
    GoRoute(
      path: '/item-list',
      builder: (context, state) => const ItemList(),
    ),
    GoRoute(
      path: '/send-update',
      builder: (context, state) => const SendUpdate(),
    ),
    GoRoute(
      path: '/document',
      builder: (context, state) => const DocumentFilesScreen(),
    ),
    GoRoute(
      path: '/otp-end-delivery',
      builder: (context, state) => const OtpForEndDelivery(),
    ),
    GoRoute(
      path: '/collection-summary',
      builder: (context, state) => const CollectionSummary(),
    ),
    GoRoute(
      path: '/greetingscreen',
      builder: (context, state) => const GreetingSplashScreen(),
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      theme: FlexThemeData.light(scheme: FlexScheme.amber),
      darkTheme: FlexThemeData.dark(scheme: FlexScheme.amber),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
    );
  }
}
