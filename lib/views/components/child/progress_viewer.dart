import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_do/themes/theme_assets.dart';
import 'package:go_do/views/starters/navigation.dart';

class ProgressViewer extends StatefulWidget {
  final bool isFinished;

  const ProgressViewer({super.key, required this.isFinished});

  @override
  State<ProgressViewer> createState() => _ProgressViewerState();
}

class _ProgressViewerState extends State<ProgressViewer> {
  Future<void> _navigateAfterDelay() async {
    await Future.delayed(const Duration(seconds: 2));
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => const Navigation()));
  }

  @override
  void initState() {
    super.initState();
    _navigateAfterDelay();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.isFinished
                    ? 'Accomplishing task...'
                    : 'Re-assigning task...',
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 20),
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
