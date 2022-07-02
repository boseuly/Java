<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@page import="java.util.*, dept.model.DeptDTO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>부서 조회 결과</title>
</head>
	<style type="text/css">
		.required-box {
			margin: 0; padding: 0.3rem 0.6rem;
			box-sizing: border-box;
			display: inline;
			position: relative;
			border: 1px solid black;
			border-radius: 4px;
			background-color: black;
			color: white;
			box-shadow: 2px 2px 2px gray;
			opacity: 0;
			transition: opacity 0.5s;
		}
		.required-box.show {
			opacity: 1;
			transition: opacity 0.5s; /*투명->불투명하게 // 말풍선이 서서히 나오도록 만들기 위해*/
		}
		.required-box:after {
			content: '';
			position: absolute;
			top: 0; left: 15%;
			width: 0; height: 0;
			border: 6px solid transparent;
			/* border-bottom-color: black; */
			border-top: 0;
			margin-left: -6px; margin-top: -6px;
		}
		/*테두리가 필요하면 아래 거를 사용하면 된다.*/
		.required-box:before {
			content: '';
			position: absolute;
			top: 0; left: 15%;
			width: 0; height: 0;
			border: 7px solid transparent;
			border-bottom-color: black;
			border-top: 0;
			margin-left: -7px; margin-top: -7px;
		}
	</style>

<script type="text/javascript">
// 사용자 입력할 때 스크립트에서 확인을 할 수도 있고, service에서 할 수도 있다. -> 
window.onload = function () {
	var form = document.forms[0]; // form은 document.forms 해주면 모든 form을 찾아준다.
	form.addEventListener("submit", formCheck);
}
function formCheck(e){
	if(this.search.value === ""){ // this는 form을 의미, form 안에 있는 search(name)의 값을 가져와라
		e.preventDefault();
		return false;
	}else {
		this.submit(); // 폼을 전송한다.
	} // e.target : submit 이벤트가 발생된 폼을 지칭
	
	function requiredBox(element, message){
		function requiredBox(element, message) {
			var box = document.createElement("div");
			box.setAttribute("class", "required-box");
			box.innerText = message;
			element.parentElement.append(box);
			
			box.style.left = element.offsetLeft - box.offsetLeft + (element.offsetWidth / 10) + "px";
			box.style.top = element.offsetHeight + 16 + "px";
			box.setAttribute("class", "required-box show");
			
			setTimeout(function() {
				box.remove();
			}, 1500);
}
</script>
<body>
	<h1>부서 조회 결과</h1>
	<div>
			<button type="button" onclick="location.href='./depts/add'">추가</button>
	</div>
	<div>
			<form action="./depts" method="get">  <!--  ./depts 에서 db를 조회하도록 보내는 것 -->
					<div>
							<input type="text" name="search" data-required="부서코드를 입력하세요."> <!--  search라는 parameter name으로 특정 데이터를 조회하라 -->
							<button type="submit">조회</button>
					</div>
			</form>
	</div>
	
	<table>
			<tr>
					<th>DeptId</th>
					<th>DeptName</th>
					<th>MngId</th>
					<th>LocalId</th>
					<th></th>
			</tr>	
	<%
			if(request.getAttribute("deptDatas") != null){
				List<DeptDTO> datas =(List<DeptDTO>) request.getAttribute("deptDatas");
				for(DeptDTO data : datas){	// 반복문을 통해서 값을 출력
	%>
			<tr>
					<td><%=data.getDeptId() %></td>
					<td><%=data.getDeptName() %></td>
					<td><%=data.getMngId() %></td>
					<td><a href="./locsController?search=<%=data.getLocationId() %>"><%=data.getLocationId() %></a></td>
					<td>
							<button type="button" onclick="location.href='./depts/mod?id=<%=data.getDeptId() %>'">수정</button> <!--  수정 하는 란으로 이동 -->
					</td>
			</tr>	
	<%
				}
			}
	%>		
	</table> 
</body>
</html>