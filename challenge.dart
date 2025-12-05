import 'dart:math';

void main(){
//1. 로또 번호 6개 뽑기 - 중복❌
List<int> myLotto = makeLotto();
print("발급번호 : $myLotto");

//2. 당첨 번호 설정하기
List<int> winNums = [3,14,19,23,36,43];
print("당첨번호 : $winNums");

//3. 내 번호와 당첨번호 비교 - 일치 개수 세기
int sameCount = checkSame(myLotto, winNums);
print("일치개수 : $sameCount");

//4. 일치 개수로 등수 판단
String rank = checkRank(sameCount);
print("등수 : $rank");

//5. 로또 번호 초기화
myLotto.clear();
print("현재 발급한 로또 번호 : $myLotto");
}

//———————————————————————————-------------------------------

//1. 로또 번호 6개 뽑기 (중복제거)
List<int> makeLotto(){
  Set<int> nums = {};
  while(nums.length < 6){
  int n = Random().nextInt(45) + 1; // 1~45
  nums.add(n);
  }
  return nums.toList();
}

//3. 내 번호와 당첨번호 비교
int checkSame(List<int>myLotto, List<int>winNums){
int  count = 0;
for(int n in myLotto){
  if(winNums.contains(n)){
    count++;
  }
}
return count;
}

//4. 일치한 개수로 등수 판단
String checkRank(int count){
if(count >=5) {return "1등";}
else if (count == 4) {return "2등";}
else if (count == 3) {return "3등";}
else {return "실패";}
}


