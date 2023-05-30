import 'package:flutter/cupertino.dart';
import 'package:meca_service/data/event.dart';

import '../utils/datetime_utils.dart';

class EventCard extends StatelessWidget {
  const EventCard({super.key, required this.event});
  final Event event;

  @override
  Widget build(BuildContext context) {
    String startTime = DatetimeUtils().dayToYearFomart(event.startTime);
    String endTime = DatetimeUtils().dayToYearFomart(event.endTime);

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.11,
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    event.imgUrl,
                    height: double.infinity,
                    fit: BoxFit.fill,
                  ))),
          const SizedBox(width: 10),
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  event.name,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5),
                ),
                Text('$startTime ~ $endTime')
              ],
            ),
          )
        ],
      ),
    );
  }
}
