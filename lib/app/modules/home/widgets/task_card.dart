import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_todo_project/app/core/utils/extensions.dart';
import 'package:getx_todo_project/app/modules/detail/detail_screen.dart';
import 'package:getx_todo_project/app/modules/home/home_controller.dart';
import 'package:getx_todo_project/app/modules/task.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class TaskCard extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  final Task task;
  TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final color = HexColor.fromHex(task.color);
    final squareWidth = Get.width - 12.0.wp;
    return GestureDetector(
      onTap: (){
        homeCtrl.changeTask(task);
        homeCtrl.changeTodos(task.todos ?? []);
        Get.to(DetailScreen());
      },
      child: Container(
        width: squareWidth / 2,
        height: squareWidth / 2,
        margin: EdgeInsets.all(3.0.wp),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            color: Colors.grey[300]!,
            blurRadius: 7,
            offset: const Offset(0, 7),
          ),
        ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StepProgressIndicator(
                totalSteps: homeCtrl.isTodosEmpty(task) ? 1 : task.todos!.length,
              currentStep: homeCtrl.isTodosEmpty(task) ? 0 : homeCtrl.getDoneTodo(task),
              size: 5,
              padding: 0,
              selectedGradientColor: LinearGradient(
                begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [color.withOpacity(0.5),color]
              ),
              unselectedGradientColor: const LinearGradient(
                begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.white, Colors.white]
              ),
            ),
            Padding(
              padding:  EdgeInsets.all(6.0.wp),
              child: Icon(IconData(task.icon,fontFamily: "MaterialIcons"),color: color,),
            ),
            Padding(
              padding:  EdgeInsets.all(5.0.wp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0.sp
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 2.0.wp,),
                  Text("${task.todos?.length ?? 0} Task",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey
                    ),),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
