import 'package:flutter/material.dart';
import 'package:go_do/views/pages/new_category.dart';
import 'package:go_do/views/pages/new_task.dart';
import 'package:go_do/services/service_injector/dependency_container.dart';
import 'package:go_do/services/ui_service.dart';

class AddOptionPage extends StatelessWidget {
  AddOptionPage({super.key});
  final _uiService = locator.get<UiService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _uiService.getAppBar('Select Option'),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF9D4EDD),Color(0xFFC77DFF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'You can add a new category that matches your task or proceed to create a task based on added categories.',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        offset: Offset(1.0, 1.0),
                        blurRadius: 3.0,
                        color: Colors.black38,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 50),
              _buildOptionButton(
                context: context,
                label: "Add Category",
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const NewCategoryPage()),
                  );
                },
              ),
              const SizedBox(height: 20),
              _buildOptionButton(
                context: context,
                label: "Create Task",
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const NewTaskPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionButton({
    required BuildContext context,
    required String label,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.85,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(14.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          elevation: 5,
          shadowColor: Colors.black45,
          backgroundColor: Colors.white,
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}
