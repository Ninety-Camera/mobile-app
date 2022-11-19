import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ninety/api/intrusion_service.dart';
import 'package:ninety/constants/constants.dart';
import 'package:ninety/main.dart';
import 'package:ninety/models/intrusion.dart';
import 'package:ninety/screens/intrusion_details.dart';

class PreviousIntrusions extends StatefulWidget {
  final String systemId;
  const PreviousIntrusions({super.key, required this.systemId});

  @override
  State<PreviousIntrusions> createState() => _PreviousIntrusionsState();
}

class _PreviousIntrusionsState extends State<PreviousIntrusions> {
  List<Intrusion> _previousIntrusions = [];

  _getPreviousIntrusions() async {
    var intrusionService = IntrusionService();
    var intrusions =
        await intrusionService.getPreviousIntrusions(widget.systemId);
    if (intrusions != null) {
      setState(() {
        _previousIntrusions = intrusions;
      });
    } else {
      final snackBar = SnackBar(
        content: const Text('Error in getting the previous intrusions'),
        action: SnackBarAction(
          label: 'okay',
          onPressed: () {
            // Some code to undo the change.
          },
        ),
      );
      if (!mounted) {
        return;
      }
      if (navigatorKey.currentContext != null) {
        ScaffoldMessenger.of(navigatorKey.currentContext!)
            .showSnackBar(snackBar);
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getPreviousIntrusions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainPurple,
        title: const Text(
          "Previous Intrusions",
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(
          left: PADDING_LEFT,
          right: PADDING_RIGHT,
          top: 20,
        ),
        child: ListView.builder(
          itemBuilder: ((context, index) {
            Intrusion intrusion =
                _previousIntrusions[_previousIntrusions.length - index - 1];
            var date = DateFormat.yMEd()
                .add_jms()
                .format(DateTime.parse(intrusion.occuredAt));
            return Container(
                child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Time occured",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      date,
                      style: const TextStyle(
                        color: Colors.red,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Image.network(
                  intrusion.intrusionImages.isNotEmpty
                      ? intrusion.intrusionImages[0].link
                      : "https://ninetycamera.blob.core.windows.net/intrusion-images/broken-image.png",
                ),
                const SizedBox(
                  height: 5,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(_createIntrusionDetailsRoute(intrusion));
                  },
                  child: Text(
                    "View details",
                    style: TextStyle(
                      color: mainPurple,
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ));
          }),
          itemCount: _previousIntrusions.length,
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
