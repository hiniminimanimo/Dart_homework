import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tasks/main/bottom_sheet.dart';

class AddButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        print("버튼누름");
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return BottomSheetTest();
          },
        );
      },
      backgroundColor: const Color.fromARGB(255, 190, 28, 16),
      shape: const CircleBorder(),
      child: Icon(CupertinoIcons.plus, color: Colors.white),
    );
  }
}
