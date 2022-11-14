import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ninety/api/intrusion_service.dart';
import 'package:ninety/constants/constants.dart';
import 'package:ninety/models/intrusion.dart';
import 'package:ninety/models/user.dart';
import 'package:ninety/screens/intrusion_details.dart';
import 'package:ninety/screens/previous_intrusions.dart';

class DashboardScreen extends StatefulWidget {
  final AppUser appUser;
  const DashboardScreen({super.key, required this.appUser});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Intrusion? _lastestIntrusion;
  String? _latestIntrusionTime;

  String? _lastIntrusionDate;

  _calculateLatestTime(date1) {
    var date = DateFormat.yMEd().add_jms().format(DateTime.parse(date1));
    final dayOne = DateTime.parse(date1);
    final today = DateTime.now();
    final diff = today.difference(dayOne).inSeconds;
    var diffString = "";
    if (diff < 60) {
      diffString = "$diff seconds ago";
    } else if (diff / 60 < 60) {
      int time = (diff / 60).round();
      diffString = "$time minutes ago";
    } else if (diff / 3600 < 24) {
      int time = (diff / 3600).round();
      diffString = "$time hours ago";
    } else {
      int time = (diff / (3600 * 24)).round();
      diffString = "$time days ago";
    }
    setState(() {
      _latestIntrusionTime = diffString;
      _lastIntrusionDate = date;
    });
  }

  _getLatestIntrusion() async {
    var intrusionService = IntrusionService();
    var _intrusion = await intrusionService
        .getLatestIntrusion(widget.appUser.cctvSystem!.id);
    if (_intrusion != null) {
      _calculateLatestTime(_intrusion.occuredAt);
      setState(() {
        _lastestIntrusion = _intrusion;
      });
    } else {
      print("No intrusion get");
    }
  }

  @override
  void initState() {
    super.initState();
    _getLatestIntrusion();
  }

  @override
  Widget build(BuildContext context) {
    _getLatestIntrusion();

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(
            top: PADDING_TOP,
            left: PADDING_LEFT,
            right: PADDING_RIGHT,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Dashboard",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.settings,
                      size: 25,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                    color: mainPurple, borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "System status",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          widget.appUser.cctvSystem!.status.toString(),
                          style: const TextStyle(
                            color: Color(0xff00FF47),
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Camera Count",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          widget.appUser.cctvSystem!.cameraCount.toString(),
                          style: const TextStyle(
                            color: Color(0xff00FF47),
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Recent Intrusion",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          _latestIntrusionTime != null
                              ? _latestIntrusionTime!
                              : "Loading",
                          style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              TextButton(
                onPressed: () {
                  _getLatestIntrusion();
                },
                child: Text(
                  "Sync now",
                  style: TextStyle(
                    color: mainPurple,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Last Intrusion",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    _lastIntrusionDate != null
                        ? _lastIntrusionDate!
                        : "Loading",
                    style: const TextStyle(
                      color: Colors.red,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              _lastestIntrusion != null
                  ? SizedBox(
                      width: double.infinity,
                      child: Image.network(
                        _lastestIntrusion!.intrusionImages[0].link,
                      ),
                    )
                  : const SizedBox(),
              const SizedBox(
                height: 5,
              ),
              _lastestIntrusion != null
                  ? TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                            _createIntrusionDetailsRoute(_lastestIntrusion!));
                      },
                      child: Text(
                        "View details",
                        style: TextStyle(
                          color: mainPurple,
                          fontSize: 15,
                        ),
                      ),
                    )
                  : const SizedBox(),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                style: raisedButtonStyleRed,
                onPressed: () {
                  Navigator.of(context).push(_createPreviousIntrusionsRoute(
                      widget.appUser.cctvSystem!.id));
                },
                child: const Text(
                  "View previous intrusions",
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Route _createIntrusionDetailsRoute(intrusion) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        IntrusionDetails(intrusion: intrusion),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

Route _createPreviousIntrusionsRoute(systemId) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        PreviousIntrusions(systemId: systemId),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
