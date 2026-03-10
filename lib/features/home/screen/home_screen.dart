import 'package:flutter/material.dart';
import 'package:newsapp/features/home/controller/home_controller.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeController()..getTopHeadLines(),
      child: Consumer<HomeController>(
        builder: (context, controller, child) {
          return Scaffold(
            body: (controller.errorMessage?.isNotEmpty ?? false)
                ? Center(child: Text(controller.errorMessage!))
                : controller.topHeadLinesLoading
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: controller.NewsTopHeadLinesList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              child: Text(
                                controller.NewsTopHeadLinesList[index].title ??
                                    '',
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}
