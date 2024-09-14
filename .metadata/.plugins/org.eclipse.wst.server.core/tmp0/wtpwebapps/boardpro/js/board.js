/**
 * js는 java Script의 약자!

 */
//댓글 수정
$.replyUpdateServer = function(){

	$.ajax({
		url : `${mypath}/UpdateReply.do`,
		data : JSON.stringify(reply),//직렬화해서 가는것
		contentType : 'application/json',
		type : 'post', 	//form-action-method 썼었쟈나, 여기서  method라고 써도 됭 ㅋㅋ
		
		success : res=>{
			alert(res.flag);
			//ok라면 화면을 수정
			$(vp3).html(modiout); //화면수정
		},
		error : xhr => {
			alert("오류 : "+xhr.status);	
		},
		dataType : 'json'
		
	})	
}


//댓글삭제
$.deleteReply = function(){
	$.getJSON(
		//게시글 삭제 아래있는거랑 비슷하죠?
		//key없이 value만 쓰는 방식으로 해볼게여(밑에서 복사 해보세요~~)
		//간단한 방식에는 실패 부분 없음
		`${mypath}/DeleteReply.do`,
		{renum : vidx},
		res =>{
			alert(res.flag);
			
			//ok이면 현 화면에서 reply-body를 지우는거죠? 
			//remove로 지워야하죠?
			//분홍색자체가 지워지는거니까
			
			//댓글과 댓글삭제의 관계는 조상이죠?
			//<div class="reply-body">
			//<input idx="9" value="댓글삭제">
			
			//ok이면 현 화면에서 reply-body지우기 - remove()
			$(target).parents('.reply-body').remove();
		}
	)	
}

//게시글 수정
$.updateBoardServer = function(){
	//$.post(url,data,success,dataType);//단축메뉴인데 이거 못씀 
	//serialize했을떄는 contentType필요한데 저기 없쟈농
	
	$.ajax({
		url : `${mypath}/UpdateBoard.do`,
		data : JSON.stringify(udata),
		type : 'post',
		contentType : 'application/json', //;charset=utf-8써도 됨여
		success : res =>{
			alert(res.flag);
			//성공했냐 실패했냐 찍어보려고 flag를 만들었었죠?
			//ok이면 화면수정 하셔야해여 - modal에 입력한 내용을 가져와서 본문에 출력
			
			//모달에 입력한 내용 가져오기 - writer, password,num제외하고 가져온것
			vsub = $('#usubject').val();
			vm = $('#umail').val();
			vc = $('#ucontent').val();
			
		/*	//udata -> 뭔가 두번째 방법과 관련된?
			vsub=udata.subject;
			vm=udata.mail;
			vc=udata.content;*/
			
			
			//이걸 어떻게해?
			//원글본문의 내용을 변경하는거죠
			//본문은 target을 기준으로 하는거죠?
			$(vcard).find('a').text(vsub);//text파라미텅ㅔ vsub대입해서 저 부분 내용 바꾸기
			$(vcard).find('.em').text(vm);
			
			vc = vc.replaceAll(/\n/g, "<br>");	//띄워쓰기를 <br>로 바꿔라????????
			$(vcard).find('.p3').html(vc)//html인거 주목 ( \n 있어서)
			
			
			//원래 jsp usend누를때 있었다.
			//모달창에 입력된 내용 지우고
			$('#uform .txt').val("");
			//모달창 닫기
			$('#uModal').modal('hide'); 
			
			
		},
		error : xhr => {
			alert("오류 : " + xhr.status)
		},
		dataType : 'json'
		
	})	
}

//게시글 삭제
$.deleteBoardServer=function(){
	//$.get( url, data, success, dataType);
	//$.getJSON( url, data, success)
	//출처 ppt5-3비동기 맨마지막페이지 ajax단축메뉴
	//특징 : KEY값이 없는걸 관찰 가능
	
	$.getJSON(
		`${mypath}/DeleteBoard.do`,
		{num : vidx},
		function(res){
			alert(res.flag)
			//리스ㄹㅗ 다시 출력할거야 성공했으면
			$.listPageServer();
		}
	)
}

//게시글 쓰기
$.boardWriteServer=function(){
	$.ajax({
		
		/*
		-1. data에 따른 type, contentType관찰
		0. contenttype저거는 기본이라 생략가능
		1.서블릿(컨트롤러,서버)에서 읽을때 getparameter로 읽는다
		
		data : "id="+idvalue +"&name="+nameValue
		type : get, post
		contentType : 'application/x-www.form-urlencode'
		
		data : {id : idvalue, name : namavalue}
		type : get, post
		contentType : 'application/x-www.form-urlencode'
		*/
		
		url : `${mypath}/InsertBoard.do`,
		type : 'post',
		data : JSON.stringify(fdata3),
		contentType : 'application/json', //이렇게 안하면 일반 문자열로 넘어간다
		success : res=>{
			alert(res.flag);
			//성공했어, 그러면 어떻게 할래?
			//index로 가도 되고, 
			
			// 성공하면 리스트 페이지로 다시 간다, 혹은 메인
			//이건 메인페이지
			//location.href="${mypath}/start/index.jsp"
			
			//성공하면 리스트페이지로 가기
			$.listPageServer()
		},
		error : xhr=>{
			alert("오류 : "+xhr.status);
		},
		dataType :'json'
	})
}
//조회수 증가하기
$.updateHitServer=function(){
	
	$.ajax({
		url : `${mypath}/UpdateHit.do`,
		type : 'get',
		data : {num : vidx}, //get에서는 직렬화 안됨, post에서만 직렬화 됨
		success : res =>{
			//alert(res.flag);
			
			
			//ok이면 화면을 수정한다.
			//target을 아까 가져왔다.
			//board.jsp에서 this받아서 전역변수로 선언해놨다.
			
			//서블릿이 새로 만들어지면 404가 한번씩 난다
			//서버를 리스탙트 해준다.	
			
			//공통 조상검사가 무슨말
			//화면수정 - 조회수 부분 검색
			vhi = $(target).parents('.card').find('.hi')
			
			//값을 일단 가져와. span에서 가져올때는 html없이 가져올꺼니까 text로 가져올게
			//화면 조회수의 값을 가져온다
			hivalue = parseInt(vhi.text().trim())+1;
			
			//화면의 조회수부분 수정
			vhi.text(hivalue);
		},
		error : xhr =>{
			alert("오류: "+xhr.status)
		},
		dataType : 'json'
	})
}

//댓글리스트 가져오기
$.replyListServer=function(){
	
	$.ajax({
		url : `${mypath}/ReplyList.do`,
		type : 'get',
		data : {bonum : vidx}, //vidx=$(this).attr('idx');	//{bonum : reply.bonum}//얘네들 출처???????????????????
		success : res=>{
			console.log(res)
			
			rcode="";
			
			//댓글 리스트 res를 출력
			$.each(res, function(i,v){
				cont = v.cont;
				cont = cont.replaceAll(/\n/g, "<br>"); //엔터를 <br>로 바꾸라
				
				rcode += `
						<div class="reply-body">
							<div class="p12">
			                	<p class="p1">
			                    	작성자:<span class="rwr">${v.name}</span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		                       	   	날짜 :<span class="rda">${v.redate}</span>         
			               		</p>

			               		<p class ="p2">`
									if(uvo != null && uvo.mem_name ==v.name){
			              				rcode += `<input idx="${v.renum}" type="button"  value="댓글수정" name="r_modify"  class="action">
			          						     <input  idx="${v.renum}" type="button"  value="댓글삭제" name="r_delete"  class="action">`
									}
		            			 	rcode += ` </p>
		          		   </div>

						   <p class="rp3">
                          	 ${cont}
			           	   </p>
			       		 </div>
						 ` 
			})//$each
			
			//출력 : 
				//target변수는 제목, 등록을 클릭할때 this를 받은 변수
				$(target).parents('.card').find('.reply-body').remove();
				$(target).parents('.card').find('.card-body').append(rcode);
			
		},//success
		error : xhr =>{
			alert("오류 : "+xhr.status)			
		},
		dataType : 'json'
	})
}

//댓글 쓰기 요청 - 응답 - 출력
$.replyWriteServer=function(){

	$.ajax({
		url : `${mypath}/InsertReply.do`,
		type : 'post', //json으로 가는건 post밖에 안돼여
		data : JSON.stringify(reply), //bonum : 19, name:"김은대", cont : "kkkk"
		contentType : 'application/json',
		
		success : res=>{
			//alert(res.flag)
			
			//ok? 댓글 리스트 나오도록 
			//댓글리스트 가져오기
			$.replyListServer();

		},
		error : xhr=>{
			alert("오류 :"+xhr.status);
		},
		dataType : 'json'
		
	})	
	
}






//게시글 리스트 요청 - 응답, 출력
$.listPageServer = function(){
	
	stype = $("#stype option:selected").val().trim();
	//option:selected가 이 창에서의 의미?
	//sword내가 입력한거
	sword = $('#sword').val().trim();
	
	//페이지를 한번 만들어보자
	datas={page : currentPage, stype : stype, sword : sword}; //key :콜롬  value형태로 쓴다
	
	//필요한(전송할)데이타를 수집한다			
	$.ajax({
		url : `${mypath}/boardList.do`,
		type : 'post',
		data : JSON.stringify(datas), //datas가져가야 한다고 - 왜 JSON으로 바꾸지? (자바랑 비교)??????????????????????????????????
		contentType : 'application/json', 
		success : function(res){
			//console.log(res)
			//alert("aaaaa");
			//{sp:1, ep:2, tp:7, datas: Array(3)} 데이터가 이렇게 생김
			//꺼내는 방법 res.sp -> console로 key들을 ㅎㅘㄱ인 
			//list꺼내는 방법?
			
			code=`<div class="container mt-3">`
			code += `<h2>Accordion Example</h2>`
			
			$.each(res.datas, function(i,v){
			
				//내용을 가져온다 - 엔터로 저장되어 있는 것을 <br>로 바꾸기 위해서 
				cont = v.content; //console창에 안찍힌 속성이름을 어떻게 가져오나????????????????????????????
				cont = cont.replaceAll(/\n/g, "<br>");	// 	//g는 global이란 뜻 , 저 사이에 \n 엔터를 넣는다
				
				code += `<div class="card">
				
				
		      	<div class="card-header">
			        <a class="btn action"  idx="${v.num}" name="title" data-bs-toggle="collapse" href="#collapse${v.num}">
	                	${v.subject}
			        </a>
		      	</div>


			     <div id="collapse${v.num}" class="collapse" data-bs-parent="#accordion">
					<div class="card-body">
			            <div class="p12">
			               <p class="p1">
                    	    	작성자:<span class="wr">${v.writer}</span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	                          	이메일:<span class="em">${v.mail}</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					                  조회수:<span class="hi">${v.hit}</span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					                  날짜 :<span class="da">${v.wdate}</span>         
			               </p>

			               <p class ="p2">`
								if(uvo != null && uvo.mem_name ==v.writer){
			           			    code += `<input idx="${v.num}" type="button"  value="수정" name="modify"  class="action">
			              					 <input  idx="${v.num}" type="button"  value="삭제" name="delete"  class="action">`
								}
			            		    code += ` </p>
			            </div>

			            <p class="p3">
                      	  ${cont}
			            </p>

			            <p class="p4">
			            	<textarea rows="" cols="60">
							</textarea>
							
			           		 <input  idx="${v.num}" type="button"  value="등록" name="reply"  class="action">
			            </p>
	       		  	</div>
		   	   </div>

			    </div>`
					})
				code += `</div></div>`
			
			//리스트 출력
			$('#result').html(code); //밑에 #result있음
			
			//page정보 출력 - 함수 호출
			vpage = $.pageList(res.sp, res.ep, res.tp);
			$('#pagelist').html(vpage);
		},
		error : function(xhr) {
			alert("오류 : " + xhr.status)
		},
		dataType : 'json'
	})//ajax
	
	
	
	
	
	
}//$.listPageServer

						//startPage, endPage, totalPage의 약자들, sp ep tp
$.pageList = function(sp, ep, tp){
	
	//이전
	pager = "";
	pager += '<ul class="pagination">';
	if(sp>1){
		pager += `<li class="page-item"><a id="prev" class="page-link" href="#">Previous</a></li>`
	}
	
	//currentPage = 7(마지막페이지) 마지막페이지의 모든 데이터 삭제 할 경우
	//currentPage의 값이 새로 구한 totalPage(tp)로 변경 되어야 한다
	if(currentPage > tp) currentPage=tp;
	
	//페이지번호
	for(i=sp; i<=ep; i++){
		if(currentPage==i){
										//active의 역할?
			pager += `<li class="page-item active"><a class="page-link pageno" href="#">${i}</a></li>`
			//currentPage전역변수 (->board.jsp의)	
			
		} else {
			pager += `<li class="page-item"><a class="page-link pageno" href="#">${i}</a></li>`
			
		}
	}
	
	//다음
	if(ep < tp ){
		pager += `<li class="page-item"><a id="next" class="page-link" href="#">Next</a></li>`	
	}
	pager += "</ul>"
	return pager;
}







































