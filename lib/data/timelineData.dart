import 'package:flutter/material.dart';
import 'package:x_pro_delivery_app/model/time_line.dart';

final dummyTimeLineData = [
  TimeLineModel(
      iconDescription: const Icon(Icons.location_on),
      title: "Arrived",
      subtitle_1: "- Truck has arrived",
      subtitle_2: "",
      time: DateTime.now()),
  TimeLineModel(
      iconDescription: const Icon(Icons.exit_to_app_rounded),
      title: "End Delivery",
      subtitle_1: "- Delivery Completed",
      subtitle_2: "- Preparing for next customer",
      time: DateTime.now()),
  TimeLineModel(
      iconDescription: const Icon(Icons.local_shipping),
      title: "In Transit",
      subtitle_1: "- Locating first customer",
      subtitle_2: "- Truck is on the way to destination",
      time: DateTime.now()),
  TimeLineModel(
      iconDescription: const Icon(Icons.pending_actions),
      title: "Pending",
      subtitle_1: "- TripTicket Accepted",
      subtitle_2: "- TripTicket Assigned to Driver",
      time: DateTime.now()),
  TimeLineModel(
      iconDescription: const Icon(Icons.archive_outlined),
      title: "Unloading",
      subtitle_1: "- Unloading Items from Truck",
      subtitle_2: "",
      time: DateTime.now()),
  TimeLineModel(
      iconDescription: const Icon(Icons.unarchive_outlined),
      title: "Waiting for Customer",
      subtitle_1: "",
      subtitle_2: "",
      time: DateTime.now()),
  TimeLineModel(
      iconDescription: const Icon(Icons.error_outline),
      title: "Mark as Undeliverable",
      subtitle_1: "- Unable to deliver",
      subtitle_2: "-Add Update",
      time: DateTime.now()),
];
