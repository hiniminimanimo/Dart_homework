import 'package:blog_app/core/datetime_extension.dart';
import 'package:blog_app/data/model/post.dart';
import 'package:blog_app/ui/detail/detail_page.dart';
import 'package:blog_app/ui/home/home_view_model.dart';
import 'package:blog_app/ui/write/write_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(title: Text('BLOG')),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 200, 14, 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return WritePage(null);
              },
            ),
          );
        },
        child: Icon(Icons.edit, color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('최근글', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Consumer(
              builder: (context, ref, child) {
                final posts = ref.watch(homeViewModelProvider);
                return Expanded(
                  child: ListView.separated(
                    itemCount: posts.length,
                    separatorBuilder: (context, index) => SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final post = posts[index];
                      return item(post);
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget item(Post post) {
    return Builder(
      builder: (context) {
        return GestureDetector(
          onTap: () {
            //
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return DetailPage(post);
                },
              ),
            );
          },
          child: Container(
            width: double.infinity,
            height: 120,
            child: Stack(
              children: [
                Positioned(
                  right: 0,
                  width: 120,
                  height: 120,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(post.imageUrl, fit: BoxFit.cover),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: EdgeInsets.only(right: 100),
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Spacer(),
                      Text(
                        post.content,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      SizedBox(height: 4),
                      Text(
                        post.createdAt.formatted,
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
