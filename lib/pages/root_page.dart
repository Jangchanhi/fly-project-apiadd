import 'package:flutter/material.dart';

import 'package:tmap_raster_flutter_sample/config/config_car.dart';
import 'package:tmap_raster_flutter_sample/config/drive_route_data.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:tmap_ui_sdk/auth/data/auth_data.dart';
import 'package:tmap_ui_sdk/auth/data/init_result.dart';
import 'package:tmap_ui_sdk/tmap_ui_sdk.dart';
import 'package:tmap_ui_sdk/tmap_ui_sdk_manager.dart';
import 'package:go_router/go_router.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  bool isInit = false;
  String platformVersion = "Unknown";
  String initStatus = "Unknown";
  InitResult tmapUISDKInitResult = InitResult.notGranted;

  @override
  void initState() {
    super.initState();

    //위치 권한
    permissionLocation();
  }

  Future<void> permissionLocation() async {
    var status = await Permission.location.request();

    if (status.isGranted) {
      initTmap();
    } else {
      Fluttertoast.showToast(msg: "위치 권한을 허용해야 초기화가 완료 됩니다.");
    }
  }

  Future<void> initTmap() async {
    if (isInit) {
      // 초기화 완료됐을 때
      Fluttertoast.showToast(msg: "이미 초기화 완료");
    } else {
      String? pv;
      var isInitGranted = InitResult.notGranted.text;
      try {
        pv = await TmapUiSdk().getPlatformVersion();

        AuthData authInfo = AuthData(
            clientApiKey: "JEK9BypcTk7mELuqYhBxk1XQDzBkAncx38APA3Pv",
            userKey: "");

        var result = await TmapUISDKManager().initSDK(authInfo);

        if (result != null && pv != null) {
          isInitGranted = result.text;

          if (result == InitResult.granted) {
            isInit = true;
          }
        }
      } catch (e) {
        pv = "Unknown Platform Version";
        isInitGranted = InitResult.notGranted.text;
      }

      setState(() {
        platformVersion = 'pv';
        initStatus = isInitGranted;
      });
    }
  }

  Future<void> clickPermission() async {
    var status = await Permission.location.status;
    if (status.isDenied) {
      openAppSettings();
    } else {
      Fluttertoast.showToast(msg: "이미 위치 권한을 허용 하였습니다.");
    }
  }

  Future<bool?> setCarConfig() async {
    ConfigCarModel model = context.read<ConfigCarModel>();

    bool? result = await TmapUISDKManager().setConfigSDK(model.nomalCar);

    Fluttertoast.showToast(
        msg: result == true ? "set car config success" : "set car config fail");

    return result;
  }

  Future<bool?> setTruckConfig() async {
    ConfigCarModel model = context.read<ConfigCarModel>();

    bool? result = await TmapUISDKManager().setConfigSDK(model.truck);

    Fluttertoast.showToast(
        msg: result == true
            ? "set truck option success"
            : "set truck option fail");

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("navi sdk sample"),
        centerTitle: true,
      ),
      body: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Running on : $platformVersion"),
          Text("init status : $initStatus"),
          TextButton(
            onPressed: clickPermission,
            child: const Text("위치 권한"),
          ),
          TextButton(onPressed: initTmap, child: const Text("초기화")),
          TextButton(onPressed: setCarConfig, child: const Text("차량 설정")),
          TextButton(onPressed: setTruckConfig, child: const Text("트럭 설정")),
          TextButton(
              onPressed: () {
                DriveRouteData.isSafeDriving = false;
                context.go("/drive");
              },
              child: const Text("경로안내"))
        ],
      )),
    );
  }
}
