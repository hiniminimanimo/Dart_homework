import 'package:flutter/material.dart';

class EmptyTaskcard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        width: double.infinity,
        height: 235,
        decoration: BoxDecoration(
          color: const Color.fromARGB(241, 245, 245, 245),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/image/peko.webp', width: 100, height: 100),
              SizedBox(height: 12),
              Text(
                '아직 할 일이 없음',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Text(
                "할 일을 추가하고 희은's Tasks에서 \n할 일을 추적하세요.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, height: 1.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
