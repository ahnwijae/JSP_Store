<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="../etc/color.jspf"%>

<%
   String managerId ="";
   try{
	   managerId = (String)session.getAttribute("managerId");
	   
	   if(managerId==null || managerId.equals("")){
          response.sendRedirect("logon/managerLoginForm.jsp");
	   }else{
%>
<html>
<head>
<title>상품관리</title>
</head>
<body bgcolor="<%=bodyback_f%>">
  <form method="post" action="logon/managerLogout.jsp">
	 <b>관리작업중... </b><input type="submit" value="로그아웃">
  </form>
    
   <table>
     <tr><td align="center" bgcolor="<%=bar%>">상품관련 작업</td></tr>
     <tr><td>
     <a href='productProcess/productRegisterForm.jsp'>상품등록</a></td></tr>
     <tr><td>
     <a href='productProcess/productList.jsp?product_kind=all'>상품 리스트</a>
     </td></tr>
     <tr><td>
     <a href='orderedProduct/showChart.jsp'>판매량 통계</a>
     </td></tr>
   </table><br><br>
   
   <table>
     <tr><td align="center" bgcolor="<%=bar%>">구매된 상품관련 작업</td></tr>
     <tr><td>
     <a href='orderedProduct/orderedList.jsp'>전체구매목록 확인</a></td></tr>
   </table> <br><br>
         <table>
     <tr><td align="center" bgcolor="<%=bar%>">회원 관련 작업</td></tr>
     <tr><td>
     <a href='Customers/customerList.jsp'>회원 리스트</a></td></tr>
   </table>
   <br><br>
</body>
</html>
<% 
	   }
    }catch(Exception e){
		e.printStackTrace();
	}
%>