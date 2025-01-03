import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:stacked/stacked.dart';
import 'package:go_do/models/Category.dart';
import 'package:go_do/view_models/category_model.dart';
import 'package:go_do/views/components/child/category_gesture_detector.dart';

class CategoryExpandableWidget extends StatelessWidget {
  const CategoryExpandableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CategoryModel>.reactive(
        builder: (context, model, child) => Expanded(
              child: ValueListenableBuilder(
                  valueListenable: model.categoryBox.listenable(),
                  builder: (context, box, child) {
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 2,
                      ),
                      itemCount: model.categoryBox.length,
                      itemBuilder: (BuildContext context, int index) {
                        final category =
                            model.categoryBox.getAt(index) as Category;
                        final totalCategoryTasks =
                            model.getTotalCategoryTasks(category.name);
                        return CategoryGestureDetector(
                            category: category,
                            totalCategoryTasks: totalCategoryTasks);
                      },
                    );
                  }),
            ),
        viewModelBuilder: () => CategoryModel());
  }
}
