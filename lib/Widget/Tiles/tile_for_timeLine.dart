import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:x_pro_delivery_app/model/time_line.dart';

class TileForTimeline extends StatelessWidget {
  const TileForTimeline(
      {super.key, required this.timeLineModel, required this.isLatest});

  final TimeLineModel timeLineModel;
  final bool isLatest;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    timeLineModel.iconDescription.icon,
                    size: 32.0,
                    color: isLatest
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.outline,
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          timeLineModel.title,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isLatest
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.outline),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          timeLineModel.subtitle_1,
                          style: TextStyle(
                              color: isLatest
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.outline),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          timeLineModel.subtitle_2,
                          style: TextStyle(
                              color: isLatest
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.outline),
                        ),
                        const SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              DateFormat('HH:mm:ss a')
                                  .format(timeLineModel.time),
                              style: TextStyle(
                                  color: isLatest
                                      ? Theme.of(context).colorScheme.primary
                                      : Theme.of(context).colorScheme.outline),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 16.0,
                              color: Colors.grey[600]!,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
