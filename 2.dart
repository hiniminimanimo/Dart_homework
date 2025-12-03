void main(){
  print("필수과제 2 - 쇼핑몰 만들기");
  print("-----------------------------------------✨"); 
  // 쇼핑몰에서 판매하는 상품 (Map)
  Map <String, int> shop = {
    '티셔츠':10000,
    '바지':5000,
    '모자':3000,
    '가방':50000
  };
  
  // 장바구니 (List)
  List <String> cart = ['모자','바지'];
  int cartcount = (cart.length);

  // 장바구니 비어있을 때
  if(cartcount == 0){
    print("장바구니가 비어있습니다");
  }
  // 장바구니에 아이템이 있을 때
  else if(cartcount > 0){
    print("🛍️🛒Item in cart : $cartcount개 🛍️🛒");
    print ("  ");
  }

  // 총합 계산
  int total = 0;
  for(String item in cart){
    total += shop[item]!;
  }
  
  // 총합 2만원 이상 → 10% 할인 적용
  if(total >= 20000){
    double discountd = total * 0.9; // 할인된 가격
    double minusd = total * 0.1;    // 할인 금액

    int discount = discountd.toInt(); //소수점 없애기
    int minus = minusd.toInt(); //소수점 없애기

    print ("❤️총 $minus원 할인❤️");
    print ("💸10% 할인된 가격💸 결제 예상 금액 $discount원");
    print ("  ");
    print ("구매해주셔서 감사합니다🥰"); 
  }
  // 총합 2만원 미만 + 0원 초과 → 정상 금액 안내
  else if(total < 20000 && total > 0){
    print ("결제 예상 금액 $total 원");
    print ("  ");
    print ("구매해주셔서 감사합니다🥰"); 
  }
  // 장바구니가 비어있을 때 추가 안내
  else{
    print ("오늘 하루 2만원 이상 10% 할인!!");
    print ("그냥 가실건가요?🥺");
  }
}