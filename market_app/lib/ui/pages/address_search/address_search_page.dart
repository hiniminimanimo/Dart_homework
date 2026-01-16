import 'package:flutter/material.dart';

class AddressSearchPage extends StatelessWidget {
  const AddressSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('주소 검색')),
      body: Column(children: [Text('주소를 입력해주세요')]),
    );
  }
}
