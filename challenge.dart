import 'dart:math';

void main(){
//1. 로또 번호 6개 뽑기 - 중복❌
//myLotto - 발급번호
List<int> myLotto = makeLotto();
print("발급번호 : $myLotto");

//2. 당첨 번호 설정하기
//winNums - 당첨번호
List<int> winNums = [3,14,19,23,36,43];
print("당첨번호 : $winNums");

//3. 내 번호와 당첨번호 비교 - 일치 개수 세기
//sameCount - 일치 개수 세기
//checkSame(myLotto, winNums)
int sameCount = checkSame(myLotto, winNums);
print("일치개수 : $sameCount");

//4. 일치 개수로 등수 판단
//checkRank - 등수 판단하기(sameCount로..)
//결과는 rank
String rank = checkRank(sameCount);

//5. 로또 번호 초기화
//reset  

//———————————————————————————-------------------------------

//1. 로또 번호 6개 뽑기 (중복제거)
//Set -> 중복 방지
//while -> 뽑기 
//Set에 있는 nums에 숫자 6개가 될 때까지
//Random().nextInt(45) + 1 -> 번호 1~45 생성
//toList() -> Set를 List로 바꿔서 숫자 정렬
List<int> makeLotto(){
  Set<int> nums = {};

  while(nums.length < 6);

}
//2번은 패스

//3. 내 번호와 당첨번호 비교
//int checkSame(my, win)
//int  count = 0
//for-in? 하나하나 꺼내서 비교하니까?
//비교해서 똑같으면 포함 contain

//4. 일치한 개수로 등수 판단
//조건문!!!! 

//if(count >=5) 1등
//else if (count == 4) 2등
//else if (count == 3) 3등
//else 꽝

//5. 로또번호 초기화
//return
}
