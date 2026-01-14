import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:book_search/data/model/book.dart';

class DetailPage extends StatelessWidget {
  final Book book;
  const DetailPage(this.book);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(book.title)),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: WebUri(book.link)),
        initialSettings: InAppWebViewSettings(),
      ),
    );
  }
}
