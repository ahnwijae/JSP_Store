<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="../../etc/color.jspf"%> 

<%
String managerId ="";
try{
	managerId = (String)session.getAttribute("managerId");
	if(managerId==null || managerId.equals("")){
       response.sendRedirect("../logon/managerLoginForm.jsp");
	}else{
       int product_id = Integer.parseInt(request.getParameter("product_id"));
       String product_kind = request.getParameter("product_kind");
%>

<html>
<head>
<title>상품삭제</title>
<link href="../../etc/style.css" rel="stylesheet" type="text/css">
</head>
<body bgcolor="<%=bodyback_c%>">
<table style='border:0 solid white'>  
<tr><td width="">  
<p>상품삭제 페이지</p>
</td></tr>
</table>

<br>
<form method="POST" name="delForm"  
   action="productDeletePro.jsp?product_id=<%= product_id%>&product_kind=<%=product_kind%>" 
   onsubmit="return deleteSave()"> 
 <table style='border:0 solid white'> 
 <tr><td>
 <a href='productList.jsp?product_kind=all'>전체 목록</a> 
 </td></tr>
 </table>
 <table>
 <tr>
     <td align="right"  bgcolor="<%=value_c%>">
	    <a href="../managerMain.jsp"> 관리자 메인으로</a> &nbsp;
	    <a href="productList.jsp?product_kind=<%=product_kind%>">이전으로</a>
	    
     </td>
  </tr>
  
 <tr height="30">
    <td align=center bgcolor="<%=value_c%>">
      <input type="submit" value="삭제" >  
   </td>
 </tr>  
</table> 
</form>
</body>
</html>
<% 
   }
}catch(Exception e){
	e.printStackTrace();
}
%>