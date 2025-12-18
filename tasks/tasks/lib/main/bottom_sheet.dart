import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomSheetTest extends StatelessWidget {
  final _controller = TextEditingController();

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
            TextField(controller: _controller),
            SizedBox(height: 16),
            Row(
              children: [
                Icon(CupertinoIcons.text_alignleft),
                SizedBox(width: 16),
                Icon(CupertinoIcons.star),
                Spacer(),
                Text('저장'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
