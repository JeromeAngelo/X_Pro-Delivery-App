import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';
import 'package:x_pro_delivery_app/Widget/Tiles/tile_for_inroute_time_line.dart';

import 'package:x_pro_delivery_app/data/in_route_timeLine.dart';

class InRouteUpdateTimeLine extends StatefulWidget {
  const InRouteUpdateTimeLine({super.key});

  @override
  State<InRouteUpdateTimeLine> createState() => _InRouteUpdateTimeLineState();
}

class _InRouteUpdateTimeLineState extends State<InRouteUpdateTimeLine> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 1.7,
              ),
              child: Timeline.tileBuilder(
                physics: const NeverScrollableScrollPhysics(),
                theme: TimelineThemeData(
                  nodePosition: 0.05,
                  color: Theme.of(context).colorScheme.onSurface,
                  indicatorTheme: const IndicatorThemeData(
                    position: 0.2,
                    size: 15.0,
                  ),
                  connectorTheme: const ConnectorThemeData(
                    thickness: 2.0,
                  ),
                ),
                builder: TimelineTileBuilder.connected(
                  connectorBuilder: (context, index, type) =>
                      const SolidLineConnector(),
                  indicatorBuilder: (context, index) => Indicator.dot(),
                  contentsBuilder: (context, index) {
                    final item = dummyRoutesTimeLine[index];
                    return TileForInrouteTimeLine(updatesInRouteModels: item);
                  },
                  itemCount: dummyRoutesTimeLine.length,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
