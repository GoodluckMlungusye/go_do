import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:go_do/view_models/category_model.dart';
import 'package:go_do/views/components/child/category_container_column.dart';

class CategoryContainer extends StatelessWidget {
  const CategoryContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CategoryModel>.reactive(
        builder: (context, model, child) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                height: 280,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: const DecorationImage(
                        image: AssetImage(
                          'assets/images/my_tasks.png',
                        ),
                        scale: 1)),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      gradient:
                          LinearGradient(begin: Alignment.bottomRight, colors: [
                        Colors.deepPurple.withOpacity(.2),
                        Colors.deepPurple.withOpacity(.2),
                      ])),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: CategoryContainerColumn(),
                  ),
                ),
              ),
            ),
        viewModelBuilder: () => CategoryModel());
  }
}
