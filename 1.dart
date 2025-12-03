void main() { 
  print("필수과제 1 - 시험 점수 별 등급 안내"); 
  print("-----------------------------------------✨"); 

  //시험점수 
  int score = 80; 
  
  //점수 별 등급체계 
  if (score <=100 && score >= 90) { 
    print("이 학생의 점수는 $score점 이며, A등급 입니다!"); 
  } 
  else if (score >= 80){ 
    print("이 학생의 점수는 $score점 이며, B등급 입니다!"); 
  } 
  else { 
    print("이 학생의 점수는 $score점 이며, C등급 입니다!"); 
  } 
}