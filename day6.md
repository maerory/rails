

DAY 06



Controller

- 역할?
  - 서비스로직을 가지고 있음
  - 그동안 app.rb에서 작성했던 모든 내용이 Controller에 들어감
- Controller는 하나의 서비스에 대해서만 관련한다.
- Controller를 만들 떄에는 $ rails g controller 컨드롤러명을 이용한다.

    $ rails g controller name
    # app/controllers/home_controller.rb 파일 생성

    Running via Spring preloader in process 1729
          create  app/controllers/home_controller.rb
          invoke  erb
          create    app/views/home
          invoke  test_unit
          create    test/controllers/home_controller_test.rb
          invoke  helper
          create    app/helpers/home_helper.rb
          invoke    test_unit
          invoke  assets
          invoke    coffee
          create      app/assets/javascripts/home.coffee
          invoke    scss
          create      app/assets/stylesheets/home.scss



app/controllers/home_controller.rb

    class HomeController < ApplicationController
    	#모든 컨트롤러는 ApplicationController를 상속한다.
    end



home_controller.rb

    class HomeController < ApplicationController
        
        def index
            @lotto = [1..45].to_a.sample(6)
        end
        
    end

- HomeController를 만들면 *app/views` 하위에 컨트롤러 명과 일치하는 폴더가 생긴다.
- HomeController에서 액션(def)를 작성하면 해당 액션명과 일치하는 view 파일을 app/views/home 폴터 밑에 작성한다.
- 사용자의 요청을 받는 url 설정은 config/routes.rb에서 한다

Rails에는 Development, Test, Production 환경(모드)가 있4다.

Development 환경에서는 변경사항이 자동적으로 확인되고, 모든 로그가 적힌다.

Production 환경에서는 변경사항도 자동으로 저장되지 않고, 로그도 일부만 적힌다. $ rails s로 서버를 실행하지는 않는다.



routes.rb

    Rails.application.routes.draw do
      get '/home/index' => 'home#index'
    end

 routes.rb에서 컨트롤러에 대한 매칭을 명시해준다.



과제 01

- 점심메뉴를 무작위로 출력한다.
- 글자 + 이미지가 출력된다.
- 점심메뉴를 저장하는 변수는 Hash타입으로 한다.
  - @lunch = {"점심메뉴 이름" => "img src"}
  - hash에서 모든 key 값을 가져오는 메소드는 .keys이다.
- 요청은 /lunch로 받는다.



home_controller.erb

        def menu
            @lunchs = {
                "20층" => "https://scontent-sea1-1.cdninstagram.com/vp/90ffb84a809b0714026d392a3cf58f62/5BBEC8CC/t51.2885-15/e35/32859163_192201064758460_1303143212759646208_n.jpg?se=7&ig_cache_key=MTc4MTcwMDUzNzQ0NDcwOTczMA%3D%3D.2",
                "순남시레기" => "http://mblogthumb2.phinf.naver.net/20141025_85/yeoma86_1414239233821ujCoB_JPEG/IMG_5972.JPG?type=w2",
                "한솥" => "http://file.mk.co.kr/meet/neds/2017/12/image_readtop_2017_863575_15146784063153509.png",
                "편의점" => "http://cfile10.uf.tistory.com/image/2139A939590B52102170A1"
            }
            #puts (0..(lunchs.length-1)).to_a
            @lunch = @lunchs.keys.sample
        end



routes.rb

    get '/lunch' => 'home#menu'



menu.html.erb

    <h1>오늘의 점심 메뉴</h1>
    
    <h3><%=@lunch%></h3>
    <img src = "<%=@lunchs[@lunch]%>">



Model

    $ rails g model <모델명>

Schema : DB를 구성하는 레코드의 크키, DB의 모습

    # 실제 DB에 스키마 파일대로 적용하기
    $ rake db:migrate
    # DB구조를 수정할 경우 drop을 통해 DB를 날린다음 다시 migrate 필요
    $ rake db:drop 

- Rails는 ORM(Object Relation Mapper)을 기본적으로 장착하고 있음 (Active Record)
- Migrate 파일을 이용해서 DB의 구조를 잡아주고 명령어를 통해 실제 DB를 생성/변경 한다.
- Model 파일을 이요해서 DB에 있는 자료 조작

    > u1 = User.new # 빈 껍데기(테이블에서 row 한줄) 생성
    > u1.user_name = "<ID> # 자료 조작
    > u1.password = "1234"
    > u1.save #실제 DB에 반영(저장)
    > u1.password = "4321"
    > u1.save



간단과제

- 그동안 뽑았던 내역을 저장해주는 로또번호 추천기
- /lotto 새로 추천받은 번호
  - a 태그를 이용해서 새로운 번호를 발급
  - 새로 발급된 번호가 가장 마지막과 최상단에 같이 뜬다
  - 최상단의 메시지는 이번주 로또 번호는 [...] 입니다 
- /lotto/new 신규 번호를 발급, 저장 후 /lotto로 리디렉션
- 모델명: Lotto, 컨트롤러명: LottoController

Tips:

- DB 부터 설계하고 시작!
- Controller, Model을 generate하고 DB migrate
- controller 수정, 뷰 수정
- 디버깅할 때는 puts 대신 p 로!
