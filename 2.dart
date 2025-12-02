void main(){
  print("필수과제 2 - 쇼핑몰 만들기");
  
  //쇼핑몰 품목 - 키와 값이 들어있으니까, Map 사용_제품:가격
  Map <String, int> shop = {
    '티셔츠':10000,
    '바지':5000,
    '모자':3000,
    '가방':50000
  };
  
  //장바구니 리스트 - 중복허용, 인덱스 대괄호 사용
  List <String> cart = ['티셔츠','바지'];
  
  //가격 총합 - 가격을 의미하는 int 총합의 total,0원으로 시작
  //for문으로 카트 안에(in) 있는 아이템(문자)를 꺼내서 계산한다
  //총합은 기존의 total(0원)에 shop에 있던 아이템을 더한다.
  //리스트에 없을 수도 있으니까 Null을 허용하는 ! 붙여줍니다.
  int total = 0;
    for(String item in cart){
    total += shop[item]!;}
  
  //할인 - 2만원 이상 10% 할인
  //0.9라는 소숫점이 나오니까 double 사용 할인된 가격 이름은 discount
  //원래 합계 total에 0.9를 곱한 값 = 할인 적용된 최종 가격
  //추가로 얼마나 할인되었는지 할인가격까지 안내해보자
  if(total >= 20000){
    double discount = total * 0.9;
    double minus = total * 0.1;
    print ("이 상품은 10% 할인된 가격으로 총 $discount원이 들어있습니다.");
    print ("❤️고객님께 총 $minus원을 할인해드렸습니다❤️");
    print ("  ");
    print ("구매해주셔서 감사합니다🥰"); 
  }
  //2만원 이하, 할인 없음 가격 안내
  else if(total < 20000){
    print ("이 장바구니에는 총 $total 원이 들어있습니다.");
    print ("구매해주셔서 감사합니다🥰"); 
}
}