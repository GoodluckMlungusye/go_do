import 'package:flutter/material.dart';
import 'package:go_do/view_models/category_model.dart';
import 'package:go_do/views/components/child/category_form.dart';
import 'package:go_do/views/components/child/new_category_expandable_widget.dart';

class NewCategoryColumn extends StatelessWidget {
  final CategoryModel model;
  const NewCategoryColumn({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CategoryForm(model: model),
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.only(left: 16, right: 16, bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Category List',
                style:
                TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        NewCategoryExpandableWidget(model: model)
      ],
    );
  }
}
