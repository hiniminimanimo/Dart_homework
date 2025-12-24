import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasks/to_do_entity.dart';

class BottomSheetTest extends StatefulWidget {
  @override
  State<BottomSheetTest> createState() {
    return BottomSheetTestState();
  }
}

class BottomSheetTestState extends State<BottomSheetTest> {
  final titleController = TextEditingController(); // 제목란
  final descController = TextEditingController(); // 설명란

  bool showDescription = false; // 설명란 나오기
  bool isFavorite = false; // 즐겨찾기

  bool get save {
    return titleController.text.trim().isNotEmpty;
  } // 제목 비어있으면 저장 활성화 안됨

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 24, bottom: 0),
      child: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                hintText: '내 할 일',
                hintStyle: TextStyle(
                  color: const Color.fromARGB(255, 143, 143, 143),
                ),
                border: InputBorder.none,
              ),
            ),

            //설명 TextField
            if (showDescription)
              TextField(
                controller: descController,
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: '세부정보 추가',
                  hintStyle: TextStyle(fontSize: 14),
                  border: InputBorder.none,
                ),
              ),
            SizedBox(height: 16),
            Row(
              children: [
                if (!showDescription)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        showDescription = true;
                      });
                    },
                    child: Icon(CupertinoIcons.text_alignleft, size: 24),
                  ),
                SizedBox(width: 32),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isFavorite = !isFavorite;
                    });
                  },
                  child: Icon(
                    isFavorite ? CupertinoIcons.star_fill : CupertinoIcons.star,
                    size: 24,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: save
                      ? () {
                          final todo = ToDo(
                            title: titleController.text.trim(),
                            desc: descController.text.trim(),
                            isFavorite: isFavorite,
                          );
                          Navigator.pop(context, todo);
                        }
                      : null,
                  child: Text(
                    '저장',
                    style: TextStyle(color: save ? Colors.red : Colors.grey),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
