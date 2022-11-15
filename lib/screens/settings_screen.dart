import 'package:flutter/material.dart';
import 'package:ninety/api/camera_service.dart';
import 'package:ninety/constants/constants.dart';
import 'package:ninety/models/camera.dart';
import 'package:ninety/models/user.dart';
import 'package:ninety/providers/system.dart';
import 'package:ninety/screens/home_screen.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  final String systemId;
  final AppUser appUser;

  const SettingsScreen({
    super.key,
    required this.systemId,
    required this.appUser,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  List<Camera> _systemCameras = [];

  _getCameras() async {
    var _camService = CameraService();
    var _result = await _camService.getAllCameras(widget.systemId);
    if (_result != null) {
      setState(() {
        _systemCameras = _result;
      });
    }
  }

  _updateStatus(BuildContext context, newStatus) async {
    CameraService cameraService = CameraService();
    var result =
        await cameraService.updateSystemStatus(widget.systemId, newStatus);
    if (result) {
      // Updating success
      for (var camera in _systemCameras) {
        camera.status = newStatus;
        setState(() {});
      }
    } else {
      // Error in updating the status
      if (newStatus == 'RUNNING') {
        context.read<System>().stopSystem();
      } else {
        context.read<System>().startSystem();
      }
    }
  }

  _updateCameraStatus(BuildContext context, Camera camera, newStatus) async {
    CameraService cameraService = CameraService();
    var result = await cameraService.updateCameraStatus(
        camera.camId, widget.systemId, newStatus);
    if (!result) {
      camera.status = newStatus == "STOP" ? "RUNNING" : "STOP";
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getCameras();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainPurple,
        title: const Text(
          "Settings",
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(
            top: 20,
            left: PADDING_LEFT,
            right: PADDING_RIGHT,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.appUser.role != "OWNER"
                  ? const Text(
                      "You do not have access to control the system",
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Full System Controlling",
                          style: TextStyle(
                            color: Color(0xfffACB2B8),
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: const [
                                Icon(
                                  Icons.monitor,
                                  size: 30,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Monitoring",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                            Switch(
                                value: context.watch<System>().systemStatus ==
                                    'RUNNING',
                                onChanged: (newValue) {
                                  if (newValue) {
                                    context.read<System>().startSystem();
                                    _updateStatus(context, 'RUNNING');
                                  } else {
                                    context.read<System>().stopSystem();
                                    _updateStatus(context, 'STOP');
                                  }
                                  setState(() {});
                                })
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        _systemCameras.isNotEmpty
                            ? const Text(
                                "Seperate Camera Controlling",
                                style: TextStyle(
                                  color: Color(0xfffACB2B8),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              )
                            : const SizedBox(),
                        const SizedBox(
                          height: 10,
                        ),
                        ..._systemCameras
                            .map(
                              (item) => Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                      bottom: 10,
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.monitor,
                                          size: 30,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          item.name,
                                          style: const TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Switch(
                                      value: item.status == 'RUNNING',
                                      onChanged: (newValue) {
                                        if (newValue) {
                                          item.status = "RUNNING";
                                          _updateCameraStatus(
                                              context, item, "RUNNING");
                                        } else {
                                          item.status = "STOP";
                                          _updateCameraStatus(
                                              context, item, "STOP");
                                        }
                                        setState(() {});
                                      })
                                ],
                              ),
                            )
                            .toList(),
                      ],
                    ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      _createSignOutRoute(),
                      (route) => false,
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.logout,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Log out",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Route _createSignOutRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const HomeScreen(),
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
