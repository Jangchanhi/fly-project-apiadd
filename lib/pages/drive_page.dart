import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmap_ui_sdk/event/data/sdkStatus/tmap_sdk_status.dart';
import 'package:tmap_ui_sdk/event/data/driveStatus/tmap_drivestatus.dart';
import 'package:tmap_ui_sdk/tmap_ui_sdk_manager.dart';
import 'package:tmap_ui_sdk/widget/tmap_view_widget.dart';
import 'package:tmap_raster_flutter_sample/config/drive_route_data.dart';
import 'package:tmap_raster_flutter_sample/pages/nav_find.dart';

class DrivePage extends StatefulWidget {
  const DrivePage({super.key});

  @override
  State<DrivePage> createState() => _DrivePageState();
}

class _DrivePageState extends State<DrivePage> {
  @override
  void initState() {
    super.initState();
    TmapUISDKManager().startTmapSDKStatusStream(onStatusListener);
    TmapUISDKManager().startTmapDriveStatusStream(onDriveStatus);
  }

  void onDriveStatus(TmapDriveStatus status) {
    log("status ============ ${status.text}");
  }

  void onStatusListener(TmapSDKStatus status) {
    log("status : ${status.text}");
    switch (status) {
      case TmapSDKStatus.dismissReq:
        onDismiss(); // 운행이 종료되면 화면을 닫는다.
        break;
      default:
        break;
    }
  }

  void onDismiss() {
    if (context.mounted) {
      Navigator.of(context).popUntil((route) {
        return route.settings.name == '/';
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    TmapUISDKManager().stopTmapSDKStatusStream();
    TmapUISDKManager().stopTmapDriveStatusStream();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await TmapUISDKManager().stopDriving();
        return true;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              Container(
                color: Colors.white,
                child: Consumer<DriveRouteData>(
                  builder: (context, drive, child) =>
                      TmapViewWidget(data: drive.getRouteRequestData()),
                ),
              ),
              Positioned(
                top: 650,
                right: 16,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const NavFind()), // SecondPage는 이동하려는 페이지입니다.
                    );
                  },
                  child: const Text('버튼'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
