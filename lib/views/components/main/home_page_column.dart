import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:go_do/themes/theme_assets.dart';
import 'package:go_do/view_models/home_model.dart';
import 'package:go_do/views/components/child/home_expandable_widget.dart';

class HomePageColumn extends StatelessWidget {
  final HomeModel model;
  const HomePageColumn({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final areTasksIncomplete = model.getTotalTasksToday() == 0 ||
        model.getTotalTasksAccomplishedToday() == 0;
    final percentAccomplished = model.getPercentAccomplishedToday() * 100;
    final displayPercentage =
        areTasksIncomplete ? 0 : percentAccomplished.toInt();
    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 30, left: 16, right: 18, bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Today's progress",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                "$displayPercentage%",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: LinearPercentIndicator(
              animation: true,
              animationDuration: 1000,
              lineHeight: 20,
              percent:
                  areTasksIncomplete ? 0 : model.getPercentAccomplishedToday(),
              progressColor: AppColors.primaryColorLight,
              backgroundColor: AppColors.lightGray,
              barRadius: const Radius.circular(8),
            )),
        const Padding(
          padding: EdgeInsets.only(top: 30, left: 16, bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Today's Tasks",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        HomeExpandableWidget(model: model)
      ],
    );
  }
}
