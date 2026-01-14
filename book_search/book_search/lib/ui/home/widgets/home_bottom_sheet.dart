import 'package:book_search/data/model/book.dart';
import 'package:book_search/ui/detail/detail_page.dart';
import 'package:flutter/material.dart';

class HomeBottomSheet extends StatelessWidget {
  HomeBottomSheet(this.book);

  Book book;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      padding: EdgeInsets.only(top: 20, bottom: 50, left: 20, right: 20),
      child: Row(
        children: [
          Image.network(book.image, fit: BoxFit.cover),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  book.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  book.author,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  book.description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14, height: 1.2),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return DetailPage(book);
                        },
                      ),
                    );
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    child: Text(
                      '자세히 보기',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
