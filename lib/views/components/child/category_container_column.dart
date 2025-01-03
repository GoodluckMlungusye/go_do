import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:stacked/stacked.dart';
import 'package:go_do/themes/theme_assets.dart';
import 'package:go_do/view_models/category_model.dart';

class CategoryContainerColumn extends StatelessWidget {
  const CategoryContainerColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CategoryModel>.reactive(
        builder: (context, model, child) => Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        model.getMotivationalMessage(
                            model.getAccomplishedPercent()),
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        model.getCompletionMessage(
                          model.getTotalTasksAccomplished(),
                          model.getTotalTasks(),
                        ),
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, top: 4),
                  child: LinearPercentIndicator(
                    animation: true,
                    animationDuration: 1000,
                    lineHeight: 15,
                    percent: model.getAccomplishedPercent(),
                    progressColor: AppColors.primaryColorLight,
                    backgroundColor: AppColors.lightGray,
                    barRadius: const Radius.circular(8),
                  ),
                ),
              ],
            ),
        viewModelBuilder: () => CategoryModel());
  }
}
