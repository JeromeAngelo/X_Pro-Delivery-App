// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:x_pro_delivery_app/model/updates_in_route_models.dart';

class TileForInrouteTimeLine extends StatelessWidget {
  TileForInrouteTimeLine({super.key, required this.updatesInRouteModels});

  UpdatesInRouteModels updatesInRouteModels;
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
                    updatesInRouteModels.iconDescription.icon,
                    size: 32.0,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          updatesInRouteModels.businessName,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onSurface),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          updatesInRouteModels.location,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                  color: Theme.of(context)
                                      .copyWith()
                                      .colorScheme
                                      .onSurface),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          updatesInRouteModels.subtitle_1,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: Theme.of(context).colorScheme.outline),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          updatesInRouteModels.subtitle_2,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: Theme.of(context).colorScheme.outline),
                        ),
                        const SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              updatesInRouteModels.time,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                    color: Colors.grey[500],
                                  ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 16.0,
                              color: Colors.grey[600],
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
