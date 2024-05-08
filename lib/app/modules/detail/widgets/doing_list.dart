import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_todo_project/app/core/utils/extensions.dart';
import 'package:getx_todo_project/app/modules/home/home_controller.dart';

class DoingList extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  DoingList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => homeCtrl.doingTodos.isEmpty && homeCtrl.doneTodos.isEmpty
          ? Column(
              children: [
                Image.asset(
                  "assets/photos/task_two.png",
                  fit: BoxFit.cover,
                  width: 200.0.sp,
                ),
                Text(
                  "Add Task",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0.sp),
                )
              ],
            )
          : ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                ...homeCtrl.doingTodos
                    .map((element) => Padding(
                      padding:  EdgeInsets.symmetric(vertical: 3.0.wp,horizontal: 9.0.wp),
                      child: Row(
                            children: [
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: Checkbox(
                                    fillColor: MaterialStateProperty.resolveWith(
                                        (states) => Colors.white),
                                    value: element["done"],
                                    onChanged: (value) {
                                      homeCtrl.doneTodo(element["title"]);
                                    }),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
                                child: Text(
                                  element["title"],
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            ],
                          ),
                    ))
                    .toList(),
                if(homeCtrl.doingTodos.isNotEmpty)
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 5.0.wp),
                    child: Divider(thickness: 2,),
                  )
              ],
            ),
    );
  }
}
