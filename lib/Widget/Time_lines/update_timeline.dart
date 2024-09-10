import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timelines/timelines.dart';
import 'package:x_pro_delivery_app/Widget/Tiles/tile_for_timeLine.dart';
import 'package:x_pro_delivery_app/model/time_line.dart';
import 'package:x_pro_delivery_app/provider/timeline_provider.dart';

class UpdateTimeLine extends StatelessWidget {
  const UpdateTimeLine({
    super.key,
    required this.timeline,
  });
  final List<TimeLineModel> timeline;

  @override
  Widget build(BuildContext context) {
    void showWarningDialog() {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Undo Status'),
          content: const Text('Do you want to undo this status?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Provider.of<TimelineProvider>(context, listen: false)
                    .undoLastStatus();
                Navigator.of(context).pop();
              },
              child: const Text('Undo'),
            ),
          ],
        ),
      );
    }

    return Consumer<TimelineProvider>(
      builder: (context, timelineProvider, child) {
        final reversedTimeline = timelineProvider.timeline.reversed.toList();

        if (reversedTimeline.isEmpty) {
          return const Center(child: Text("No Update Timeline shown"));
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * .8,
                  minHeight: 100,
                ),
                child: Timeline.tileBuilder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  theme: TimelineThemeData(
                    nodePosition: 0.07,
                    color: Theme.of(context).colorScheme.onSurface,
                    indicatorTheme: const IndicatorThemeData(
                      position: 0.3,
                      size: 15.0,
                    ),
                    connectorTheme: const ConnectorThemeData(
                      thickness: 2.0,
                    ),
                  ),
                  builder: TimelineTileBuilder.connected(
                    connectorBuilder: (context, index, type) {
                      final isLatest = index == reversedTimeline.length - 1;
                      return SolidLineConnector(
                        color: isLatest
                            ? Theme.of(context).colorScheme.onSurface
                            : Theme.of(context).colorScheme.outline,
                      );
                    },
                    indicatorBuilder: (context, index) {
                      final isLatest = index == reversedTimeline.length - 1;
                      return DotIndicator(
                        color: isLatest
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.outline,
                      );
                    },
                    contentsBuilder: (context, index) {
                      final item = reversedTimeline[index];
                      return GestureDetector(
                          onLongPress: showWarningDialog,
                          child: TileForTimeline(
                            timeLineModel: item,
                            isLatest: index == reversedTimeline.length - 1,
                          ));
                    },
                    itemCount: reversedTimeline.length,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
