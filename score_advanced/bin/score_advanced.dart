import 'dart:io';

//   1) Score (부모 클래스)
class Score {
  int score;

  Score(this.score);

  void show() {
    print('점수 : $score');
  }
}

//   2) StudentScore (자식 클래스)
class StudentScore extends Score {
  String name;

  StudentScore(this.name, int score) : super(score);

  @override
  void show() {
    print('이름 : $name, 점수 : $score');
  }
}

//   3) 파일 읽기 loadData()
List<StudentScore> loadData(String filePath) {
  List<StudentScore> studentList = [];

  try {
    final file = File(filePath);
    final lines = file.readAsLinesSync(); // 파일 전체 줄 읽기

    for (var line in lines) {
      // 빈 줄 스킵
      if (line.trim().isEmpty) {
        continue;
      }

      // 쉼표 기준 둘로 나눴는지 확인
      final parts = line.split(',');
      if (parts.length != 2) {
        print('형식 오류 : $line');
        continue;
      }

      String name = parts[0];
      String scoreText = parts[1];

      // 점수 변환 오류
      int? score = int.tryParse(scoreText);
      if (score == null) {
        print('점수 변환 오류 : $line');
        continue;
      }
      // 점수 범위 
      if (score < 0 || score > 100) {
        print('점수 오류 : $line');
        continue;
      }
      // 객체 리스트 추가
      studentList.add(StudentScore(name, score));
    }
  } catch (e) {
    print('학생 데이터를 불러오는 데 실패했습니다 : $e');
  }

  return studentList;
}

//   4) 사용자 입력 → 평균 계산
String getResult(List<StudentScore> list) {
  while (true) {
    print('어떤 학생의 통계를 확인하시겠습니까?');
    print('이름을 입력하세요:');

    String? nameCheck = stdin.readLineSync();

    // 입력 검증
    if (nameCheck == null || nameCheck.trim().isEmpty) {
      print('입력이 잘못되었습니다. 다시 입력해주세요.');
      continue;
    }

    String name = nameCheck.trim();

    // 평균 계산
    int sum = 0;
    int eo = 0;

    for (var s in list) {
      if (s.name == name) {
        sum += s.score;
        eo++;
      }
    }

    if (eo == 0) {
      print('잘못된 학생 이름입니다. 다시 입력해주세요.');
      continue;
    }

    int getAverage = sum ~/ eo;

    String line = '이름 : $name, 평균 점수 : $getAverage';

    print(line);
    return line;
  }
}

//   5) 결과 파일 저장 saveResult()
void saveResult(String filePath, String result) {
  try {
    final file = File(filePath);
    file.writeAsStringSync(result);
    print('저장이 완료되었습니다.');
  } catch (e) {
    print('저장에 실패했습니다: $e');
  }
}
//   6) main()
void main(List<String> arguments) {
  final student = loadData('./students.txt');
  final result = getResult(student);
  saveResult('result.txt', result);
}