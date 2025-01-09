import 'package:flutter/material.dart';
import 'package:go_do/views/starters/navigation.dart';
import 'package:stacked/stacked.dart';
import 'package:go_do/view_models/category_model.dart';
import 'package:go_do/views/components/main/new_category_column.dart';

class NewCategoryPage extends StatelessWidget {
  const NewCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CategoryModel>.reactive(
        builder: (context, model, child) {
          return SafeArea(
            child: Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const Navigation()));
                      },
                      icon: const Icon(Icons.arrow_back_ios,
                          color: Colors.black26)),
                  title: const Text(
                    'Add Category',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  centerTitle: true,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
                body: NewCategoryColumn()),
          );
        },
        viewModelBuilder: () => CategoryModel());
  }
}
