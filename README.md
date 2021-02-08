# Map View
 - 맵 뷰를 이용해 위도와 경도 그리고 범위를 설정하여 지도에 나타내고, 원하는 곳에 핀을 설치하여 원하는 글자를 나타내게 할 것.
 - 위치를 선택하기 위해 버튼 대신 '세그먼트 컨트롤'을 이용할 것.
 - 세그먼트란 세분화된 기능을 가진 버튼을 말하며, 세그먼트 컨트롤은 여러 개의 세그먼트를 수평으로 나열하여 구성한 수평 컨트롤러를 말함.
 
 ## 맵뷰(MapView)란?
 - 기본적으로 많이 사용하는 지도 앱은 지도화면에 현재 내위치를 알려 주는 것은 물론이고 이동도 가능한 기능이 있다.
 - 구글 지도, 네이버 지도, 다음 지도 외에 '런타스틱(Runtastic)' 같은 운동 관련 앱, '청주 버스'앱과 같은 버스 앱이 그 예
 - 맵 뷰를 이용해 앱을 만들게 되면 사용자의 경도, 위도 및 고도와 같은 위치 정보를 이용하여 사용자의 위치를 지도에 표시하고 추적할 수 있음
 - 특정 위치를 표시하고 사용자의 터치를 인식해 확대, 축소 및 이동 기능도 제공함.
 
 <hr/>
 
 ~~~Swift
 알아두면 좋아요 
 1.버튼과 세그먼트 컨트롤의 차이
   - 세그먼트 컨트롤은 여러 세그먼트로 구성된 수평 컨트롤
   - 세그먼트는 각 세분화된 기능을 가진 버튼
   - 기능상으로는 세그먼트는 버튼과 동일하다고 볼 수 있음
   - 다만, 세그먼트 컨트롤은 관련이 있는 버튼들을 모아 놓은 것이라 생각하면 됨
   - 그리고 모아 놓은 버튼에 '선택'의 개념이 더해져있음
   - ex) 세 개의 버튼을 나열할 경우 세 개의 버튼이 관련이 있는지는 알 수 없음.
         세그먼트 컨트롤에 사용된 세그먼트는 관련이 있다고 볼 수 있음
         또한 버튼의 경우 세 개 중 어느 것을 선택했는지 알 수가 없지만
         세그먼트 컨트롤의 경우 세 개 중에 어느 세그먼트를 선택했는지 알 수 있음
 2. 세그먼트 컨트롤의 세부 항목
   세그먼트 컨트롤의 세부 항목별 역할은 다음과 같다.
      -> 스토리보드에서 세그먼트 컨트롤을 클릭하면 오른쪽 인스펙터 영역 Attributes Inspector 버튼을 클릭 후 확인할 수 있다
   1) Style : Plain, Bordered, Bar를 선택할 수 있지만 현재는 어느 것을 선택해도 한 가지 형태로 작동
              그 이유는 중요도가 떨어져 더이상 사용하지 않기 때문
   2) Selected Tine : 세그먼트의 항목을 선택하였을때 색을 정할 수 있다(기본 색상은 흰색)
   3) State : 만약 [Momentary]를 체크하지 않으면 세그먼트를 클릭한 후 선택된 상태를 유지하여 어떤 세그먼트를 선택했는지 알 수 있다.
              반면 체크하면 세그먼트를 선택한 후 바로 원상태로 돌아와 어느 세그먼트를 선택했는지 알 수 없다.
   4) Segments : 세그먼트의 개수를 설정할 수 있다.
   5) Segment/Title : 세그먼트 중 하나를 선택하여 이름 등의 설정을 바꿀 수 있다.
   6) Image : 세그먼트에 글자 대신 이미지를 넣을 수 있다. 이미지는 자동 스케일로 조정되지 않는다.
   7) Behavior :
         - Enabled : 체크하지 않으면 세그먼트가 선택되지 않는다.
         - Selected : 체크하면 화면에 선택된 형태의 세그먼트로 표시된다. 하지만 실제로 동작은 하지 않는다.
   8) Content Offset : 세그먼트 내에서 텍스트의 위치에 x,y 값을 주어 이동할 수 있다.
                       왼쪽과 위쪽 여백을 주는 효과와 동일하다.
 
 3. 세그먼트 컨트롤의 크기 조절
   - 세그먼트 컨트롤의 크기 조절은 가로만 가능하고 세로는 불가능 
       ( 세그먼트 컨트롤의 가로 폭에 비해 글자가 너무 길면 말줄임표(...)와 함께 일부글자만 보임 )
   - Offset 값을 이용해 세그먼트 내의 글씨 위치도 변경할 수 있음
   - 세그먼트를 동일한 크기로 나누거나 글자 수에 비례해서 크기 조절도 가능
   - 사이즈 인스펙터(Size inspector)에서 'Auto-Size-Mo...'을 [Equal Widths]에서 
     [Proportional to Content]로 수정하면 글자 수에 맞게 세그먼트가 수정됨
 ~~~
 
 ~~~swift
 스위프트 문법 1. 
   Self란?
   - Self란 보통 클래스나 구조체 자신을 가르킬 때 사용
   - 예를 들어 Point 클래스 내부에 x라는 변수가 있다. 그런데 setX 함수는 입력 파라미터로 x를 가지고 있다.
   - setX 함수 안에서 파라미터의 x와 클래스 내부의 x를 구분하기 위해 클래스 내부를 가르키는 self 키워드를 사용한다.
   - self.x는 Point 클래스 내부의 변수를 나타내고, self를 붙히지 않은 x는 setX 함수의 파라미터 x를 나타낸다.
   - 이와 같은 방법은 메서드(함수)에서 동일하게 사용할 수 있다.
   - 또한 self. 함수는 자기 자신의 클래스 함수를 나타낸다
   
   class Point {
       var x = 0
       func setX(x:Int) ->> () {
          self.x = x
       }
   }
 ~~~
 
 ~~~swift
 스위프트 문법 2.
   nil이란?
   - 스위프트에서 nil은 값이 존재하지 않음을 의미
   - 예를 들어 아래와 같이 나열한 flightCode 중 flightNumber "aa"는 존재하지 않으므로 결과로 "항공사 코드 aa는 nil입니다."를 출력한다.
   - 즉, "aa"의 항공사 코드는 존재하지 않으므로 nil을 표시
   
   var flightCode = [
       "oz":"아시아나항공",
       "ke":"대한항공",
       "ze":"이스타항공",
       "lj":"진에어",
       "7c":":제주항공"
   ]
   
   flightNumber = "aa"
   print("항공사 코드 \(flightNumber)는 \(flightCode[flightNumber])입니다.")
   
   
   
   항공사 코드가 존재하는지 확인하려면 if문과 nil을 활용해서 코드를 작성할 수 있다.
   결과는 "없는 항공사 코드입니다"를 출력한다.
   
   if flightCode[flightNumber] != nil {
       print("항공사 코드\(flightNumber)는 \(flightCode[flightNumber]!)입니다.")
   } else {
       print("없는 항공사 코드입니다.")
   }
 ~~~
 
<hr/>
 
 # 문법04. 함수, 익명 함수, nil, 옵셔널 변수, self 이해하기
 1. 함수는 어떻게 만드나요?
    - 함수는 특정 일을 수행하는 코드의 집합.
    - 보통의 함수는 값을 전달받아 이 값을 이용해서 특정 일을 수행하고, 그 결과를 리턴하는 형태를 취한다.
    - 여기서 전달 받은 값을 '파라미터'라 하고, 리턴하는 값을 '반환값'이라고 한다.
    - 스위프트의 함수는 다음과 같은 형태를 취한다
    - 실행 코드에서는 파리미터명을 이용해 작업이 이루어진다.
    
~~~ swift
  func 함수명(파라미터명1: 자료형, 파라미터명2: 자료형) -> 반환값의 자료형 { 실행 코드 }
~~~  
       
   - 실제 예를 들어 살펴보면, 문자열 두개의 파라미터를 입력받아 문자열을 출력하는 삼수인 today함수를 정의한다.  
   - today 함수는 문자열로 month와 day 파라미터를 전달받아 오늘 날짜를 알려 주는 문자열을 만들어서 이 문자열을 리턴하는 함수이다.  

~~~ swift
  func today(month: String, day: String) -> String {
     return "오늘은 \(month)월 \(day)일입니다."
  }
~~~  
   
   - 그래서 today(month: "1", day: "23" )는 today 함수를 호출하고 month에는 "1"이 전달되고 day에는 "23"이 전달되어  
   - 그 결과 "오늘은 1월 23일입니다."의 문자열이 출력된다.  
   - 오늘 날자를 출력하고 싶을 때 today 함수를 호출하여 사용하면 된다.  
    
~~~swift
  func today(month: String, day: String) -> String {
    return "오늘은 \(month)월 \(day)일입니다."
  }
  
  today(month: "1", day:"23")
  print(today(month: "1", day: "23")
~~~
~~~
결과

오늘은 1월 23일 입니다.
~~~
<hr/>
  - 함수를 만들 때 자주하는 실수
  1) 첫 번째 파라미터 명을 생략하면 안된다!
     - 함수를 호출하여 사용할 때 첫 번째 파라미터명을 생략하면 에러가 발생한다.
     - 예를 들어 앞의 소스처럼 사용하면 에러가 발생한다.
     - 아래처럼 첫 번째 파라미터명도 함께 사용해야 에러가 발생하지 않는다
     
~~~swift
  today("1", day:"23")              -  1
  
  today(month: "1", day: "23")      -  2
~~~


  2) 인자라벨을 쓰면 안된다.
     - func 함수명(인자라벨 파라미터명1: 자료형, 인자라벨 파라미터형2: 자료형) -> 반환값의 자료형 {실행 코드} 형태로 구현하면 경고 메세지가 나온다
~~~swift
   ex)
   func today(month month: String, day day: String) -> String {            ----->> 에러발생
       return "오늘은 \(month)월 \(day)일입니다."
  }
  
  today(month: "1", day:"23")
  print(today(month: "1", day: "23")
~~~

<hr/>
  2. 익명함수란 무엇인가?
     -  일반적인 함수의 경우 func 키워드와 함수명을 선언하고 사용하지만 효율적인 코드를 작성하기위해
        함수명을 선언하지 않고 바로 함수 몸체만 만들어 사용하는 일회용 함수를 익명함수(Anonymous Functions) 
        혹은 클로저(Closure)라고 한다.
     - 함수의 파라미터로 값이나 변수가 아닌 함수를 사용하고 싶을 때, 함수명을 사용하지 않고 함수의 몸체만 이용할 때 사용한다
~~~swift
  // 보통함수
  func 함수명(파라미터명: 자료형) -> (자료반환형) {
       실행구문
  }
  
  // 익명함수
  
  // func 함수명을 생략한 형태로 바꿀 수 있다. 
  // 또한 익명 함수의 경우 실행 구문이 길지 않아 함수를 한 줄로 구현하는 경우도 있다.
  { (파라미터명: 자료형) -> (반환 타입) in 실행 구문 }
  
  // 반환 자료형을 생략할 수 있다
  { (파라미터명: 자료형) in 실행 구문 }
  
  // 파라미터 자료형을 생략할 수 있다
  { (파라미터명) in 실행 구문 }
  
  // 파라미터 자료형이 생략된 경우 매개변수의 소괄호(,)를 생략할 수 있다
  { 파라미터명 in 실행구문 }
~~~

  - 예를 들어 직접 적용해 보자
  - completeWork  함수는 Bool 타입의 finished 매개변수를 받아 출력하는 함수이며 리턴 타입은 없다.
~~~swift
  // 보통함수
  func completeWork(finished: Bool) -> () {
    print("complete : \(finished)")
  }
  
  // 익명함수
  
  // 익명함수 형태로 바꾸면 이렇게 된다.
  { (finished: Bool) -> () in print("complete : \(finished)") }
  
  // 컴파일러가 반환 타입을 미리 알고 있다면 반환 타입을 생략할 수 있다
  { (finished: Bool) in print("complete : \(finished)") }
  
  // 매개 변수의 파라미터 타입도 생략할 수 있다.
  { (finished) in print("complete : \(finished)")}
  
  // 파라미터 타입이 생략된 경우 매개변수의 소괄호(,)를 생략할 수 있다.
  { finished in print("complete : \(finished)") }
~~~

<hr/>

  3. nil이란 무엇인가?
     - nil은 값이 존재하지 않음을 의미
     - 예를 들어 나열한 flightCode 중 flightNumber "aa"는 존재하지 않으므로 결과를 보면 nil이 발견되었다는 에러메세지를 나타낸다
     - 즉 변수, flightNumber가 존재하지 않기 때문에 에러 메세지가 나타난다.
~~~swift
   var flightCode = [
       "oz":"아시아나항공",
       "ke":"대한항공",
       "ze":"이스타항공",
       "lj":"진에어",
       "7c":":제주항공"
   ]
   
   flightNumber = "aa"
   print("항공사 코드 \(flightNumber)는 \(flightCode[flightNumber])입니다.")
~~~
~~~swift
  결과
  fatal error: unexpectedly found nil while unwrapping an Optional value
~~~
    
   - 그렇다면 이렇게 값이 존재하지 않음을 뜻하는 nil 은 어떤 경우에 사용할까?
   - 위와 같은 경우에는 해당하는 값이 없을 때 '없는 항공사 코드입니다'와 같은 문구를 나타낼 때 사용한다.
   - 아래처럼 if문으로 항공사 코드가 존재하는지를 nil을 이용해 확인한 후 그 결과에 따라 다르게 출력할 수 있다.
~~~swift
  if flightCode[flightNumber] != nil {
       print("항공사 코드\(flightNumber)는 \(flightCode[flightNumber]!)입니다.")
   } else {
       print("없는 항공사 코드입니다.")
   }
~~~
~~~swift
  결과
  없는 항공사 코드입니다.
~~~
  - 추가적으로 flightCode[flightNumber] 값을 flightCodeName 상수에 대입하는 방식으로 옵셔널 바인딩을 활용해서 작성할 수 있다
~~~swift
  if let flightCodeName = flightCode[flightNumber] {
    print("항공사 코드 \(flightNumber)는 \(flightCodeName)입니다.")
  }else{
    print("없는 항공사 코드입니다.")
  }
~~~
~~~swift
  결과
  없는 항공사 코드입니다.
~~~

<hr/>
  4. 옵셔널(Optionals) 변수란 무엇인가?
     - 이러한 nil 값을 변수에 할당하면 어떻게 될까?
     - 앞의 예제에서 위의 코드처럼 수정했을 때 아래와 같은 에러 메세지가 나온다
~~~swift
  var flightNumber = "oz"
  var flightCompany: String = flightCode[flightNumber]
~~~
~~~swift
  결과
  error: value of optional type 'String?' not unwrapped; did you mean to use '!' or '?'?
~~~
   - 스위프트에서는 변수에 값을 대입할 때 반드시 nil이 아닌 값을 대입해야 하지만 위의 예제에서는 이전 예제와 같이
     flightCompany에 nil 값이 할당될 수 있기 때문에 에러가 발생한다
   - 이럴땐 옵셔널 변수를 사용해야한다.
   - 옵셔널 타입으로 선언한 변수는 nil값을 가질 수 있다.
   - 즉, 옵셔널 변수는 nil 값을 대입할 수 있거나 초깃값을 주지 않아 어떤 값이 들어갈지 모를 때 사용한다.
   - 위의 예제를 해결하려면?
     - 만일 어떤 변수에 nil 값을 대입할 수 있다면 옵셔널 변수로 선언해야한다.
     - 즉, 변수의 자료형(위에서는 String) 다음에 '?'를 추가하여 옵셔널 변수라는 것을 선언함으로써 해결할 수 있다.
~~~swift
  var flightCompany: String? = flightCode[flightNumber]
~~~
   - 그러면 이렇게 옵셔널로 선언된 변수는 어떻게 사용할까?
   - 위의 소스처럼 사용하면 경고 메세지가 나온다.
   - 옵셔널로 선언된 변수에 값이 할당되면 그 값은 '옵셔널에 래핑(wrapped)되었다'고 하며,
     이 값은 그냥 사용할 수 없고 아래 소스처럼 '!'를 사용해 강제 언래핑(force unwrapping)하여 값에 접근해야 한다.
~~~swift
  print(flightCompany)      ->   1
  
  
  print(flightCompany!)     ->   2
~~~
   - 반면 옵셔널 변수는 암묵적인 언래핑(implicity unwrapping)이 되도록 선언할 수 있는데,
     이 때는 강제 언래핑을 사용하지 않아도 값에 접근할 수 있다.
   - 즉, 변수를 선언할 때 '?' 대신 '!'를 사용하여 암묵적인 언래핑된 옵셔널 변수로 선언할 수 있다.
   - 이렇게되면 변수의 값에 접근할 때 '!'를 사용하지 않아도 된다.
~~~swift
  var flightNumber = "oz"
  var flightCompany: String! = flightCode[flightNumber]
  
  print(flightCompany)
~~~

<hr/>
 5. if문에서 !의 역할은 무엇인가?
   - if문에서 조건에  '!'가 들어가있는 경우를 종종 볼 수 있다.
   - 여기서 '!'는 논리 연산자의 하나로, 논리 NOT 연산자이다.
   - NOT 연산자의 경우 변수 앞에 '!'가 붙는다.
   - 앞에서 설명한 강제 언래핑 기호로 사용된 '!'나 강제 언래핑 기호를 생략하기 위한 변수 선언에 사용한 '!'는
     변수 뒤에 붙으면 연산자가 아닌 키워드인 데 반해, NOT 연산자는 '!'는 +,-,*,/  등과 같은 연산자이다.
   - 다만 논리 연산자이기 때문에 일반 값이 아닌 논리값(참,거짓)을 연산한다.
   - '!'연산자 뒤에는 논리값(true 또는 false)을 가지는 Bool형의 변수나 상수가 와야한다.
~~~swift
  var on : Bool
  
  on=true
  print(on)
  print(!on)
~~~
   - on에 true값을 대입한 후 on을 출력하면 true가 출력되고, !on을 출력하면 false가 출력되는 것을 확인할 수 있다.
  
<hr/>
  6. self의 의미는 무엇인가?
     - self란 보통 클래스나 구조체 자신을 가리킬 때 사용한다.
     - 예를 들어 Point 클래스 내부에 x라는 변수가 있다고 한다면, 그런데 setX 함수는 입력 파라미터로 x를 가지고 있다.
     - setX함수 안에서 파라미터의 x와 클랫그 내부의 x를 구분하기 위해 클래스 내부를 가르키는 self 키워드를 사용한다.
     - self.x는 Point 클래스 내부의 변수를 나타내고, self를 붙히지 않은 x는 setX 함수의 파라미터 x를 나타낸다.
     - 이와 같은 방법은 메서드(함수)에서 동일하게 사용할 수 있다.
     - 또한 self. 함수는 자기 자신의 클래스 함수를 나타낸다
~~~swift
 class Point {
        var x = 0
        func setX(x:Int) ->> () {
           self.x = x
        }
   }
   
   var p=Point();
   print(p.x)
   
   p.setX(x:10)
   print(p.x)
~~~
   - var p=Point()를 실행한 후 p.x의 값을 보면 x의 초깃값인 0을 확인할 수 있고
   - p.setX(x:10)를 실행한 후 p.x의 값을 보면 10을 확인할 수 있다.
   - 즉, 10인 x가 self.x에 대입되어 p.x가 10이 된 것이다.
