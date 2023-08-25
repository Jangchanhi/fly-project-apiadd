import 'package:tmap_ui_sdk/route/data/planning_option.dart';
import 'package:tmap_ui_sdk/route/data/route_point.dart';
import 'package:tmap_ui_sdk/route/data/route_request_data.dart';

class DriveRouteData {
  static bool isSafeDriving = false;

  RouteRequestData getRouteRequestData() {
    if (isSafeDriving) {
      return RouteRequestData(
        safeDriving: true,
      );
    }

    List<PlanningOption> option = [
      PlanningOption.recommend,
      PlanningOption.generalRoad,
    ];

    RoutePoint start = RoutePoint(
        latitude: 37.491981, longitude: 126.926028, name: "SKT 보라매사옥");

    RoutePoint dest =
        RoutePoint(latitude: 37.566368, longitude: 126.985089, name: "T타워");

    return RouteRequestData(
        source: start,
        routeOption: option,
        destination: dest,
        guideWithoutPreview: false);
  }
}
