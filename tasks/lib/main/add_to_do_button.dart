import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tasks/main/bottom_sheet.dart';

// 할일 추가 버튼 ->  누르면 바텀시트 올라옴
class AddButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        //모달 바텀시트를 화면 아래에서 띄우기
        showModalBottomSheet(
          context: context,
          builder: (context) {
            // 할일 입력 담당
            return BottomSheetTest();
          },
        );
      },

      //버튼 색, 모양, 아이콘 등 외형 디테일
      backgroundColor: const Color.fromARGB(255, 190, 28, 16),
      shape: const CircleBorder(),
      child: Icon(CupertinoIcons.plus, color: Colors.white),
    );
  }
}
