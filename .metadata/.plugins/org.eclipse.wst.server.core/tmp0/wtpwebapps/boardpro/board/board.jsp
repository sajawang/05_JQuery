<%@page import="com.google.gson.Gson"%>
<%@page import="kr.or.ddit.member.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isELIgnored="true" %>    
    
    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
  
   <!--외부스크립트-->
  <script src="../js/jquery-3.7.1.js"></script>
  
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>

   <!--만든 외부스크립트-->
   <script src="../js/board.js"></script>
   
   
   <!--외부스크립트-->
   <script src="../js/jquery.serializejson.min.js"></script>
<style>
html, body {padding:-10; margin:-10; height:100%; width: 100%;   }

body *{
  box-sizing:   border-box;
}

body{
  min-width : 1000px;
}
/* #result{
  width : 100%;
  padding : 1px;
} */
.container{
   margin : 5px;
   max-width : 99%;
}
.p12{
  display: flex;
  flex-direction:  row;
}
p{
   border  : 1px dotted lightgray;
   padding : 5px;
   margin  :2px;
}
.p1{
   flex:  70%;
   word-break:keep-all; /* 줄바꿈: 단어단위로  */
}
.p2{
   flex : 30%;
   text-align:  right;
}

.card-body{
   display:  flex;
   flex-direction:  column;
}
input[name=reply]{
   height : 55px;
   vertical-align: top;
}
textarea {
	width : 70%;
}

nav {
  margin: 2%;
}

nav a{
 visibility: hidden;
}
#pagelist{
   margin-left : 10%;
}

.card-header:hover{
  background : #0078FF;
}

.reply-body{
  border : 1px dotted orange;
  background : #efdada;
  margin : 2px;
  padding : 2px;
}

.modal label{
  width : 100px;
  height : 30px;
}

span.pa{
 display : none;/* listPageServer에서 password  를 안보이도록*/
}

#modifyform{
  display: none;
}
#btnok, #btnreset{
  height : 40px;
  vertical-align: bottom;
}


</style>

<!--로그인 기능 구현하기 위한 자바 문장을 쓸거야-->
<%
	//로그인 상태
	MemberVO vo = (MemberVO)session.getAttribute("loginok");
	
	String ss = null;
	
	Gson gson = new Gson();
	if(vo != null) ss=gson.toJson(vo);
	/*
	ss = { "mem_id" : "a001" , "mem_pass" : "asdfasdf", "mem_name" : "김은대"}
	*/
%>



<script>
//JSP 실행 순서가  Java =>  => HTML => javascript
 
//자바 스크립트 객체 - 동적으로 속성을 추가한다 
reply={}; //전역변수

uvo=<%=ss%> //쓰는 방법 uvo.mem_id,  uvo.mem_pass, uvo.mem_name
currentPage = 1;
mypath =  '<%= request.getContextPath()%>';


$(function(){

	//-----------------------------------------------------------------------------------
	//페이징
	
	//js 파일의 함수를 호출
	$.listPageServer();
	
	//다음버튼 이벤트
	//$('#next') -> 처음엔 #next버튼이 생성되지 않았기 때문에 document로 써야함
	$(document).on('click', '#next', function(){
		//나열되어 있는 페이지 번호들(pageno)의 마지막 값을 가져온다
		currentPage=parseInt($('.pageno').last().text())+1;
					//last함수
					//$('.pageno:last') <-필터 방식
		$.listPageServer();
	})
	
	//이전버튼 이벤트
	$(document).on('click', '#prev', function(){
		currentPage=parseInt($('.pageno').first().text())-1;
		$.listPageServer();
	})
	
	//페이지번호 클릭하는 이벤트
	$(document).on('click', '.pageno', function(){
		currentPage=parseInt($(this).text());
		$.listPageServer();
	})
	
	//검색어 입력 후 검색버튼 클릭이벤트
	$(document).on('click', '#search',function(){
		currentPage=1;
		$.listPageServer();
				
	})
	
	//-----------------------------------------------------------------------------------
	//수정, 삭제, 댓글쓰기, 댓글리스트(제목, 등록), 댓글수정, 댓글삭제 //클릭이벤트
	$(document).on('click', '.action', function(){
										//this쓸거면 화살표함수 쓰면안됑
		
		target = $(this);
										
		vname=$(this).attr('name');
			//클릭이벤트							
		vidx=$(this).attr('idx');
		
		if(vname=="reply"){
			//alert(vidx + "번 글에 댓글을 답니다.")
			
			if(uvo==null){
				alert("로그인하세요");
				return;
			}
			
			//입력한 댓글내용을 가져온다
			vcont = $(this).prev().val().trim();//prev???????
			
			//저장할데이터수집
			reply.bonum = vidx;
			reply.name = uvo.mem_name;
			reply.cont = vcont;
			//cont, name, bonum-> vo에 있는
			
			//전송 -board.js의 함수를 호출
			$.replyWriteServer(); 
			//성공하면 지워라고 하고 싶으면 success콜백에서 하면 된다.
			
			$(this).prev().val("");
			
		} else if(vname =="modify"){
			//alert(vidx+"번 글을 수정합니다.")
			
			//원글의 내용을 가져온다
			//수정버튼을 기준으로 공통조상 찾기
			vcard 	= $(this).parents('.card');			 //조상찾기
			vtitle 	= $(vcard).find('a').text().trim();	 //a태그
			vname 	= $(vcard).find('.wr').text().trim();//wr은 클래스니까 . 점찍었
			vmail	= $(vcard).find('.em').text().trim();
			vcont	= $(vcard).find('.p3').text().trim(); //내용이니까 cont, vcont
											  			 //<br>태그가 포함
			//.html()은 여러개 있으면 첫번째꺼만 가져온다.
			
			vcont = vcont.replaceAll(/<br>/g,""); //<br>태그를 \n 또는 ""로 바꿔본다
			
			//모달창에 출력한다	
			$('#uwriter').val(vname);
			$('#usubject').val(vtitle);
			$('#umail').val(vmail);
			$('#ucontent').val(vcont);
			$('#unum').val(vidx);
											   
			//이름 수정 불가
			$('#uwriter').prop('readonly',true);
			
			//모달창 실행
			$('#uModal').modal('show');
			
			//전송버튼 클릭 별도로 작성
			
		} else if(vname =="delete"){
			//alert(vidx+"번 글을 삭제합니다.")
			
			//함수호출
			$.deleteBoardServer()
			
			
			
		} else if(vname=="title"){
			//vidx 에 관련된 댓글리스트 가져오기
			//함수 호출
			$.replyListServer()
			
			
			
			//조회수 증가하기-함수 호출(자바스크립트에 있따)
			vhit = $(this).attr('aria-expanded');//속성중에 'aria-expanded'=true(접혀있을때) 'aria-expanded'=false(열리면) 
			if (vhit =="true") {
				$.updateHitServer()//db수정
			}
			
		} else if(vname == "r_modify"){
			//alert(vidx + "댓글을 수정합니다"	);
			//글 수정이 복잡하듯이, 댓글수정도 복잡하다.
			//댓글수정 -> 내용, 번호만 있으면 됨
			//번호는 댓글 수정 버튼 안에 들어있따
			//vidx, idx
			
			//댓글 수정폼이 이미 어딘가에 열려있는지 검사
			//만약 열려 있다면 body로 수정폼을 반납하고 body에서 수정 폼을 다시 가져온다
			//반납시에는 원래 내용을 rp3에 원래 내용을 그대로 출력
			if($('#modifyform').css('display') != "none"){	//이렇게 쓰면 getter야.	//none이면 어딘가 열려 있다는거야
				//수정폼이 어딘가에 이미 열려있다
				replyReset();
			}
			//지금 클릭한 버튼(this) 기준으로 rp3을 찾는다
			//html 웹에서 검사버튼 눌러서 관계를 확인하면 됨
			//복잡한 관계면 parents를 해준다.
			vp3 = $(this).parents('.reply-body').find('.rp3')
			
			
			//원래 댓글 내용을 가져온다-<br>태그가 포함되어있다.
			//원래 내용이 사라지지 않고
			//보관하고 있어야 하기 때문에 변수 선언
			//왜 원래 내용을 보관하고 있어야 해요?
			//댓글 수정하려다가 취소하면 다시 나가야 하니깐!!!!!!!!!!!!!!!!					
			modifycont = vp3.html().trim();
			console.log(modifycont);
			
			//<br>태그를 다시 \n으로 줄바꿈 해준다.
			//modifycont를 다시 mcont로 정의해줌
			mcont = modifycont.replaceAll(/<br>/g,"\n");
			
			
			//수정폼의 textarea에 출력
			$('#modifyform textarea').val(mcont);
			
			
			//수정폼을 rp3으로 이동(append) - body의 수정폼은 사라진다
			vp3.empty().append($('#modifyform'));
			
			
			//rp3에는 원래 댓글내용이 들어있죠
			//거기에 append지정해서 
			
			//수정폼을 보이게 한다
			$('#modifyform').show();
			
		
		} else if(vname =="r_delete"){
			//alert(vidx + "댓글을 삭제합니다");
			//쉬운거부터 할게
			
			//js함수 호출
			$.deleteReply();
			//요거만 해주면 돼죠
		}
		
	})//action이벤트
	
	
	//댓글수정 폼에서 취소벝ㅡㄴ 클릭
	$('#btnreset').on('click', function(){
		//취소 버튼을 기준으로 //rp3을 찾아야 한다. //cont넣어야해
		replyReset();
	})
	
	replyReset=function(){
		//수정폼을 기준으로 rp3을 찾는다
		vrp3=$('#modifyform').parent();//부모를 찾는거니까 parent에 s를 안붙인다
		
		//수정폼을 body로 이동 =append
		$('#modifyform').appendTo($('body')); //append할거야 appendTo할거야
		//appendTo body로 
		
		//수정폼을 안보이도록 설정
		$('#modifyform').hide();
		
		//원래 내용을 - modifycont(댓글수정시) 다시 rp3으로 출력
		$(vrp3).html(modifycont);
		//원래 내용에 <br>태그가 들어있었으니 html
	}
	
	//댓글수정폼에서 확인버튼 클릭
	$('#btnok').on('click', function(){
		
		//새롭게 입력된(수정내용)을 ㄱㅏ져온다 - 서버로 전송할내용(db에 저장)-enter가 포함되어 있다.
		modicont = $('#modifyform textarea').val();
		
		//엔터를 <br>태그로 바꾼다 - 화면에 변경할 내용 - db가 성공했을때만 - success콜백함수에서 실행한다
		modiout = modicont.replaceAll(/\n/g,"<br>");
		
			
		//수정폼을 기준으로 rp3을 검색한다
		vp3 = $('#modifyform').parent();
		
		//$(vp3).html(modiout);	//화면변경 ~~ //화면변경 미리 하면 안된다고 -> success 콜백함수에서 하라규~!!!!!!!!!!!!!!!!
		//<br>태그가 있으니까 html
		
		//수정폼을 body로 보냄 - 안보이도록 설정 해준다
		$('body').append($('#modifyform'));
		$('#modifyform').hide();
		
		//서버로 전송할 data를 수집
		reply.cont = modicont;
		reply.renum = vidx;
		
		//자바스크립트 함수 호출
		$.replyUpdateServer(); //js폴더-board.js에서 만들거얌
	})
	
	
	//게시글 수정모달창에서 전송 버튼 클릭
	$('#usend').on('click',function(){
		//입력한 모든 값을 가져온다
		udata = $('#uform').serializeJSON();
		console.log(udata);
		
		
		
		//서버로 전송 - java script함수 호출
		$.updateBoardServer();
		
		//함수 이름을 걍 붙인것 $.은
		//화면수정 - 서버로 전송 - db수정이 완료된 후에 실행 - 비동기 실행시 success 콜백에서 해야한다.
		
	})
	
	//글쓰기 이벤트
	$('#write').on('click',function(){
		//모달 이름에 로그인 한 사람의 이름을 출력
		$('#writer').val(uvo.mem_name);
		
		//모달 이름을 수정할 수 없도록s
		$('#writer').prop('readonly',true); //checked, readonly, disabled,.....를 prop에 줄 수 있다.
		
		//모달창 보이기
		$('#wModal').modal('show');
	})
	
	
	//글쓰기 입력후 전송버튼 클릭
	$('#send').on('click', function(){
		if(uvo==null){
			alert("로그인하세요");
			return;
		}
		
		//입력한 5개 내용 다 가져와야함
		//어떻게 한꺼번에 가져와?
		
		//하나씩 가져오는 방법 $('#writer').val()
		
		//여러개 가져오는 방법
		fdata1 = $('#wform').serialize(); //걍문자열 //writer=%EA%B9%80%EC%9D%80%EB%8C%80&subject=123&mail=1231&password=123&content=12312312313
		fdata2 = $('#wform').serializeArray(); //배열  //[{…}, {…}, {…}, {…}, {…}]
		fdata3 = $('#wform').serializeJSON(); //json형태 //{writer: '김은대', subject: '123', mail: '1231', password: '123', content: '12312312313'}
		
		//참고 jquery.serializejson.min.js 는 json데이터 만들때 쓴다.(자바스크립트 파일, js폴더에 있는)
		console.log(fdata1);
		console.log(fdata2);
		console.log(fdata3);
		
		//함수호출
		$.boardWriteServer();
		//자바스크립트로 써도 되는데 한번 함수 호출해보겠다. 
		
		//location.href="main"
		// 이렇게 쓰면 성공하든 안하든 메인 페이지로 갈 가능성 생김
		
		//$.listPageServer();
		//이렇게 쓰면 성공하든 안하든 저 함수가 실행될 가능성
		
		//모달창 내용 지우기
		$('#wModal txt').val("");
		
		//모달창 닫기
		$('#wModal').modal('hide');
	})

})//$function
</script>

</head>
<body>

 <div id="modifyform">
<textarea rows="5" cols="50"></textarea>
<input type="button" value="확인" id="btnok">
<input type="button" value="취소" id="btnreset">
</div>
 
  <br>
  <!--  <input type="button" data-bs-toggle="modal" data-bs-target="#wModal"  id="write" value="글쓰기">  -->
<!--  <input type="button" id="write" value="글쓰기"> -->
  <BR>
  <br>
   <nav class="navbar navbar-expand-sm navbar-dark bg-primary">
  <div class="container-fluid">
  <input type="button" id="write" value="글쓰기" >
    <a class="navbar-brand" href="javascript:void(0)">Logo</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#mynavbar">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="mynavbar">
      <ul class="navbar-nav me-auto">
        <li class="nav-item">
          <a class="nav-link" href="javascript:void(0)">Link</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="javascript:void(0)">Link</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="javascript:void(0)">Link</a>
        </li>
      </ul>
      <form class="d-flex">
      
      <select class="form-select" id="stype">
		  <option value="">전체</option>
		  <option value="writer">작성자</option>
		  <option value="subject">제목</option>
		  <option value="content">내용</option>
	  </select>
      
        <input class="form-control me-2" type="text" id="sword" placeholder="Search">
        <button id="search" class="btn btn-primary" type="button">Search</button>
      </form>
    </div>
  </div>
</nav>
   
   

   <!-- 리스트 3개씩을 출력 -->
   <div id="result"></div>
   
   <br>
   <br>
   
   <!-- 페이지정보를 출력  -->
   <div id="pagelist"></div>
   
   
<!------- 글쓰기   The Modal  ------- -->
<div class="modal" id="wModal">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">게시글 작성하기</h4>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>

      <!-- Modal body   w3school에서 modal 가져오고 body만 수정한거에여 -->
      <!-- id는 중요치 않다. name이 vo와 일치해야한다. -->
      <div class="modal-body">
       
       <form name="wfrom" id="wform">
            <label>이름</label>
            <input type="text" class="txt" id="writer" name="writer"> <br> 
            
            <label>제목</label>
            <input type="text" class="txt" id="subject" name="subject"> <br> 
            
            <label>메일</label>
            <input type="text"  class="txt" id="mail" name="mail"> <br> 
            
            <label>비밀번호</label>
            <input type="password"  class="txt" id="password"   name="password"> <br> 
            
            <label>내용</label>
            <br>
            <textarea rows="5" cols="40"  class="txt" id="content"  name="content"></textarea>
            <br>
            <br>
            <input type="button" value="전송" id="send">
        </form>
       
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
      </div>

    </div>
  </div>
</div>
   
  
  
<!----- 글 수정  The Modal    ----->
<div class="modal" id="uModal">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">게시글 수정하기</h4>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
       
       <form name="ufrom" id="uform">
       <!--class="txt"는 삭제할 때 쓴다.  -->
            <input type="hidden" id="unum" name="num">
            <label>이름</label>
            <input type="text" class="txt" id="uwriter" name="writer"> <br> 
            
            <label>제목</label>
            <input type="text" class="txt" id="usubject" name="subject"> <br> 
            
            <label>메일</label>
            <input type="text"  class="txt" id="umail" name="mail"> <br> 
            
            <label>비밀번호</label>
            <input type="password"  class="txt" id="upassword"   name="password"> <br> 
            
            <label>내용</label>
            <br>
            <textarea rows="5" cols="40"  class="txt" id="ucontent"  name="content"></textarea>
            <br>
            <br>
            <input type="button" value="전송" id="usend">
        </form>
       
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
      </div>

    </div>
  </div>
</div>
  
   
</body>
</html>











