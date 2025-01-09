import 'package:flutter/material.dart';
import 'package:go_do/themes/theme_assets.dart';
import 'package:stacked/stacked.dart';
import 'package:go_do/view_models/category_model.dart';

class CategoryForm extends StatelessWidget {
  const CategoryForm({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CategoryModel>.reactive(
        builder: (context, model, child) {
          return Form(
            key: model.formKey,
            child: Padding(
              padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
              child: Column(
                children: [
                  TextFormField(
                      controller: model.nameController,
                      decoration: InputDecoration(
                        labelText: 'Category Name',
                        focusColor: AppColors.primaryColor,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6)),
                        focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.primaryColor)),
                      ),
                      validator: model.validateInputLength),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Select favourite category color',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Container(
                              width: 25,
                              height: 25,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: model.categoryColor),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 45,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                        onPressed: () => _pickColor(context, model),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                            side: const BorderSide(
                                color: AppColors.primaryColor)),
                        child: const Text("Choose Color",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: AppColors.primaryColor))),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    height: 45,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                        onPressed: () {
                          model.addCategory();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                        ),
                        child: const Text("Save",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18))),
                  ),
                ],
              ),
            ),
          );
        },
        viewModelBuilder: () => CategoryModel());
  }
}

void _pickColor(BuildContext context, CategoryModel model) => showDialog(
    context: context,
    builder: (context) => SingleChildScrollView(
          child: AlertDialog(
            title: const Text('Pick Your Color'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                model.buildColorPicker(),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('SELECT'),
                ),
              ],
            ),
          ),
        ));
