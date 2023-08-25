import 'package:flutter/material.dart';
import 'package:tmap_raster_flutter_sample/models/station_info.dart';
import 'dart:math';

import 'package:tmap_raster_flutter_sample/pages/detail_page.dart';

class NavFind extends StatefulWidget {
  const NavFind({super.key});

  @override
  State<NavFind> createState() => _NavFindState();
}

class _NavFindState extends State<NavFind> {
  //final Future<List<StationInfo>> stations = ApiService.getStationInfo();

  List<StationInfo> stationlist = [
    StationInfo(
        address: "서울시",
        name: "보라매전기차",
        sid: 1,
        occupancy_20: 0.95,
        occupancy_40: 0.88,
        occupancy_60: 0.65,
        occupancy_120: 0.33),
    StationInfo(
        address: "서울아님",
        name: "보라기전기차",
        sid: 2,
        occupancy_20: 0.95,
        occupancy_40: 0.88,
        occupancy_60: 0.65,
        occupancy_120: 0.33),
    StationInfo(
        address: "서울시립",
        name: "보라색전기차",
        sid: 3,
        occupancy_20: 0.95,
        occupancy_40: 0.88,
        occupancy_60: 0.65,
        occupancy_120: 0.33),
    StationInfo(
        address: "서울시라고",
        name: "보라전기차",
        sid: 4,
        occupancy_20: 0.95,
        occupancy_40: 0.88,
        occupancy_60: 0.65,
        occupancy_120: 0.33),
    StationInfo(
        address: "서울시라고",
        name: "보라전기차",
        sid: 4,
        occupancy_20: 0.95,
        occupancy_40: 0.88,
        occupancy_60: 0.65,
        occupancy_120: 0.33),
    StationInfo(
        address: "서울시라고",
        name: "보라전기차",
        sid: 4,
        occupancy_20: 0.95,
        occupancy_40: 0.88,
        occupancy_60: 0.65,
        occupancy_120: 0.33),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 70,
          elevation: 4,
          centerTitle: true,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          title: const Text(
            "주변 전기차충전소",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
          ),
        ),
        body: ListView.separated(
          scrollDirection: Axis.vertical,
          itemCount: 6,
          padding: const EdgeInsets.all(10),
          itemBuilder: (context, index) {
            final random = Random();
            var randomNumber = random.nextInt(6) + 1;
            var randomNumber2 = random.nextInt(10) + 1;
            var station = stationlist[index];
            return ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    station.name,
                    style: const TextStyle(
                        fontSize: 26, fontWeight: FontWeight.w600),
                  ),
                  RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        const TextSpan(
                          text: '급속 ',
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: Color.fromARGB(255, 9, 171, 225)),
                        ),
                        TextSpan(
                          text: '$randomNumber 대 가능 ㆍ $randomNumber2시간 전 사용',
                          style: const TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 9, 171, 225)),
                        )
                      ],
                    ),
                  ),
                  Text(
                    station.address,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              subtitle: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 270,
                  ),
                  SizedBox(
                    width: 80,
                    height: 40,
                    child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailScreen(stationInfo: station),
                            ),
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor: const MaterialStatePropertyAll(
                              Color.fromARGB(255, 228, 228, 228)),
                          shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                        child: const Text(
                          '자세히',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                              fontWeight: FontWeight.w500),
                        )),
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const Divider(
              thickness: 2,
            );
          },
        )

        /*body: FutureBuilder(
        future: stations,
        builder: (context, snapshot) {
          return ListView.separated(
              itemBuilder: (context, index) {
                var station = snapshot.data![index];
                return Text(station.title);
              },
              separatorBuilder: (context, index) => const SizedBox(
                    height: 30,
                  ),
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data!.length);
        },
      ),*/
        );
  }
}
