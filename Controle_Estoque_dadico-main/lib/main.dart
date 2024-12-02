// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:controle_estoque_dadico/presentation/pages/dash_board_page.dart';
// import 'package:controle_estoque_dadico/presentation/pages/estoque_page.dart';
// import 'package:controle_estoque_dadico/presentation/pages/main_home_page.dart';
// import 'package:controle_estoque_dadico/presentation/user/login_page.dart';
// import 'package:sqflite_common_ffi/sqflite_ffi.dart';

// void main() {
//   // Verifique se está em um ambiente desktop (Windows, Linux, macOS)
//   if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
//     // Inicializa o factory do banco de dados para uso com sqflite_common_ffi
//     sqfliteFfiInit();
//     databaseFactory = databaseFactoryFfi;
//   }

//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       initialRoute: '/home', // Página inicial
//       routes: {
//         '/home': (context) => const HomePage(), // Rota para MainHomePage
//         '/dashboard': (context) =>
//             const DashboardPage(), // Rota para DashboardPage
//         '/estoque': (context) => const EstoquePage(), // Rota para EstoquePage
//       },
//     );
//   }
// }

import 'dart:io';

import 'package:controle_estoque_dadico/presentation/pages/dash_board_page.dart';
import 'package:controle_estoque_dadico/presentation/pages/estoque_page.dart';
import 'package:controle_estoque_dadico/presentation/pages/main_home_page.dart';
import 'package:controle_estoque_dadico/presentation/user/login_page.dart';
import 'package:controle_estoque_dadico/presentation/user/register_page.dart';

import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  // Verifique se está em um ambiente desktop (Windows, Linux, macOS)
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    // Inicializa o factory do banco de dados para uso com sqflite_common_ffi
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DashboardPage(),
    );
  }
}
