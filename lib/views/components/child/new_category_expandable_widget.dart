import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:go_do/models/Category.dart';
import 'package:go_do/view_models/category_model.dart';

class NewCategoryExpandableWidget extends StatelessWidget {
  final CategoryModel model;
  const NewCategoryExpandableWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ValueListenableBuilder(
          valueListenable: model.categoryBox.listenable(),
          builder: (context, box, child) {
            return ListView.builder(
                itemCount: model.categoryBox.length,
                itemBuilder: (BuildContext context, index) {
                  final category = model.categoryBox.getAt(index) as Category;
                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, bottom: 8),
                    child: SizedBox(
                      height: 75,
                      width: double.infinity,
                      child: Card(
                        elevation: 4,
                        child: ListTile(
                          leading: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(category.categoryColor)),
                          ),
                          title: Text(
                            category.name,
                            style: const TextStyle(
                                fontSize: 16, overflow: TextOverflow.ellipsis),
                          ),
                        ),
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
