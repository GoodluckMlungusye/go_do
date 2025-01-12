import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:go_do/view_models/home_model.dart';
import 'package:go_do/views/components/main/home_page_column.dart';
import 'package:go_do/services/service_injector/dependency_container.dart';
import 'package:go_do/services/ui_service.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final _uiService = locator.get<UiService>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeModel>.reactive(
        builder: (context, model, child) => SafeArea(
              child: Scaffold(
                  appBar: _uiService.getAppBar('GoDo'),
                  body: model.todayTasks.isNotEmpty
                      ? HomePageColumn()
                      : const Center(
                          child: Text("No tasks scheduled today!"),
                        )),
            ),
        viewModelBuilder: () => HomeModel());
  }
}
