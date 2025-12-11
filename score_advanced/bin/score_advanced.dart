import 'dart:io';

// 1단계: Score 클래스만 만들기
// 2단계: showInfo 제대로 동작하게 하기
// 3단계: StudentScore 상속만 붙이기
// 4단계: 파일 없이 리스트로만 테스트
// 5단계: 그 다음 파일 입출력 천천히 추가
// 6단계: 마지막에 통합

// 부모 클래스 Score
class Score {
  int score;

  Score(this.score);

  void show() {
    print('점수 : $score');
  }
}

// 자식 클래스 StudentScore
class StudentScore extends Score {
  String name;

  StudentScore(this.name, int score) : super(score);

  @override
  void show() {
    print('이름 : $name, 점수 : $score');
  }
}

// 파일 불러오기: "이름,점수" 형식의 txt를 읽어서 리스트로 변환
List<StudentScore> loadData(String filePath) {
  List<StudentScore> studentList = [];

  try {
    final file = File(filePath);
    final lines = file.readAsLinesSync();

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

      int? score = int.tryParse(scoreText);
      if (score == null) {
        print('점수 변환 오류 : $line');
        continue;
      }

      if (score < 0 || score > 100) {
        print('점수 오류 : $line');
        continue;
      }

      studentList.add(StudentScore(name, score));
    }
  } catch (e) {
    print('학생 데이터를 불러오는 데 실패했습니다 : $e');
  }

  return studentList;
}

// 이름을 입력받아 평균 점수 계산
String getResult(List<StudentScore> list) {
  while (true) {
    print('어떤 학생의 통계를 확인하시겠습니까?');
    print('이름을 입력하세요:');

    String? nameCheck = stdin.readLineSync();

    if (nameCheck == null || nameCheck.trim().isEmpty) {
      print('입력이 잘못되었습니다. 다시 입력해주세요.');
      continue;
    }

    String name = nameCheck.trim();

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

// 결과를 result.txt에 저장
void saveResult(String filePath, String content) {
  try {
    final file = File(filePath);
    file.writeAsStringSync(content);
    print('저장이 완료되었습니다.');
  } catch (e) {
    print('저장에 실패했습니다: $e');
  }
}

void main(List<String> arguments) {
  final student = loadData('student.txt');
  final result = getResult(student);
  saveResult('result.txt, resultLine');
}