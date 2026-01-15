import 'package:blog_app/core/datetime_extension.dart';
import 'package:blog_app/data/model/post.dart';
import 'package:blog_app/ui/detail/detail_view_model.dart';
import 'package:blog_app/ui/write/write_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailPage extends ConsumerWidget {
  DetailPage(this.post);

  Post post;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(detailViewModelProvider(post));
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        actions: [
          iconButton(Icons.delete, () async {
            print('삭제아이콘터치');
            final vm = ref.read(detailViewModelProvider(post).notifier);
            final result = await vm.deletePost();
            if (result) {
              Navigator.pop(context);
            }
          }),
          iconButton(Icons.edit, () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return WritePage(post);
                },
              ),
            );
          }),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.only(bottom: 500),
        children: [
          Image.network(state.imageUrl, fit: BoxFit.cover),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  state.title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(height: 8),
                Text(state.writer, style: TextStyle(fontSize: 16)),

                Text(
                  state.createdAt.formatted,
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(height: 8),
                Text(state.content),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget iconButton(IconData icon, void Function() onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: 50,
      height: 50,
      color: Colors.transparent,
      child: Icon(icon),
    ),
  );
}
