import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tmap_raster_flutter_sample/pages/drive_page.dart';
import 'package:tmap_raster_flutter_sample/pages/find.dart';
import 'package:tmap_raster_flutter_sample/pages/root_page.dart';
import 'package:tmap_raster_flutter_sample/config/config_car.dart';
import 'package:tmap_raster_flutter_sample/config/drive_route_data.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(routes: [
  GoRoute(
      path: '/',
      builder: (context, state) => const MyHomePage(
            title: 'Home',
          ),
      routes: [
        GoRoute(path: 'drive', builder: (context, state) => const DrivePage()),
        GoRoute(path: 'find', builder: (context, state) => const FindPage()),
        GoRoute(path: 'root', builder: (context, state) => const RootPage()),
      ])
]);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider(create: (context) => ConfigCarModel()),
          Provider(create: (context) => DriveRouteData())
        ],
        child: MaterialApp.router(
          title: "SKT FLY AI PROJECT",
          theme: ThemeData(primarySwatch: Colors.blue),
          debugShowCheckedModeBanner: false,
          routerConfig: _router,
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final platform = const MethodChannel("testing.flutter.android");

  Future<void> _showActivity() async {
    try {
      await platform.invokeMethod('showActivity');
    } on PlatformException catch (e) {
      log("Error : $e");
    }
  }

  TextEditingController? _idTextController;
  TextEditingController? _pwTextController;
  @override
  void initState() {
    super.initState();
    _idTextController = TextEditingController();
    _pwTextController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(children: [
                const SizedBox(
                  height: 50,
                ),
                Image.asset(
                  'image/logo.png',
                  width: 300,
                  height: 300,
                ),
                SizedBox(
                    width: 300,
                    child: TextField(
                      controller: _idTextController,
                      maxLines: 1,
                      decoration: const InputDecoration(
                        labelText: '아이디',
                        border: OutlineInputBorder(),
                      ),
                    )),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                    width: 300,
                    child: TextField(
                      controller: _pwTextController,
                      maxLines: 1,
                      decoration: const InputDecoration(
                        labelText: '비밀번호',
                        border: OutlineInputBorder(),
                      ),
                    )),
                const SizedBox(
                  height: 20,
                  width: 300,
                ),
                TextButton(
                  onPressed: () {
                    _showActivity();
                  },
                  style: ButtonStyle(
                    fixedSize:
                        MaterialStateProperty.all<Size>(const Size(150, 50)),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.blue), // 버튼의 크기 지정
                  ),
                  child: const Text(
                    "로그인",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    context.go('/root');
                  },
                  style: ButtonStyle(
                    fixedSize:
                        MaterialStateProperty.all<Size>(const Size(150, 50)),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.blue), // 버튼의 크기 지정
                  ),
                  child: const Text(
                    "nav",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
