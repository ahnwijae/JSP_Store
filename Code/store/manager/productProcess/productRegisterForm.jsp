<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.Timestamp" %>

<%@ include file="../../etc/color.jspf"%> 



<%
   String managerId ="";
   try{
	   managerId = (String)session.getAttribute("managerId");
	   if(managerId==null || managerId.equals("")){
           response.sendRedirect("../logon/managerLoginForm.jsp");
	   }else{
%>
<html>
<head>
<title>상품등록</title>
<link href="../../etc/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../../etc/script.js"></script>
</head>
<body bgcolor="<%=bodyback_f%>"> 
<p><table style='border:0 solid white'><td><h2>상품 등록</h2></p></td></table>
<br>

<form method="post" name="writeform" 
     action="productRegisterPro.jsp"  enctype="multipart/form-data">
<table> 
   <tr>
    <td align="right" colspan="2" bgcolor="<%=value_d%>">
	    <a href="../managerMain.jsp"> 관리자 메인으로</a> 
   </td>
   <td></td><td></td>
   <td align="right" colspan="2" bgcolor="<%=value_d%>">
	    <a href='productList.jsp?product_kind=all'>상품리스트로</a>
   </td>
   </tr>
   <tr>
    <td  width="100"  bgcolor="<%=value_f%>">분류 선택</td>
    <td  width="400" align="left">
       <select name="product_kind">
           <option value="100">과자</option>
           <option value="200">음료</option>
           <option value="300">문구</option>
       </select>
    </td>
  </tr>
  <tr>
    <td  width="100"  bgcolor="<%=value_f%>">이 름</td>
    <td  width="400" align="left">
        <input type="text" size="50" maxlength="50" name="product_name"></td>
  </tr>
  <tr>
    <td  width="100"  bgcolor="<%=value_f%>">가 격</td>
    <td  width="400" align="left">
        <input type="text" size="10" maxlength="9" name="product_price">원</td>
  </tr>
  <tr>
    <td  width="100"  bgcolor="<%=value_f%>">수량</td>
    <td  width="400" align="left">
        <input type="text" size="10" maxlength="5" name="product_count">개</td>
  </tr>
  <tr>
    <td  width="100"  bgcolor="<%=value_f%>">중량</td>
    <td  width="400" align="left">
        <input type="text" size="20" maxlength="30" name="product_weight">g</td>
  </tr>
  <tr>
    <td  width="100"  bgcolor="<%=value_f%>">제조사</td>
    <td  width="400" align="left">
        <input type="text" size="20" maxlength="30" name="publishing_com"></td>
  </tr>
  <tr>
    <td  width="100"  bgcolor="<%=value_f%>">제조일</td>
    <td  width="400" align="left">
        <select name="publishing_year">
        <%
        Timestamp nowTime  = new Timestamp(System.currentTimeMillis());
        int lastYear = Integer.parseInt(nowTime.toString().substring(0,4));
           for(int i=lastYear;i>=2010;i--){
        %>
             <option value="<%=i %>"><%=i %></option>
        <%} %>
        </select>년
        
        <select name="publishing_month">
        <%
           for(int i=1;i<=12;i++){
        %>
             <option value="<%=i %>"><%=i %></option>
        <%} %>
        </select>월
        
        <select name="publishing_day">
        <%
           for(int i=1;i<=31;i++){
        %>
             <option value="<%=i %>"><%=i %></option>
        <%} %>
        </select>일
     </td>
  </tr>
  <tr>
    <td  width="100"  bgcolor="<%=value_f%>">이미지</td>
    <td  width="400" align="left">
        <input type="file" name="product_image"></td>
  </tr>
 <tr>
    <td  width="100"  bgcolor="<%=value_f%>">할인율</td>
    <td  width="400" align="left">
        <input type="text" size="5" maxlength="2" name="discount_rate">%</td>
  </tr>
<tr>      
 <td colspan=2 bgcolor="<%=value_d%>" align="center"> 
  <input type="button" value="상품등록" onclick="checkForm(this.form)">
  <input type="reset" value="다시작성">
  
</td></tr></table>         
</form>      
</body>
</html>
<% 
	}
}catch(Exception e){
	e.printStackTrace();
}
%>