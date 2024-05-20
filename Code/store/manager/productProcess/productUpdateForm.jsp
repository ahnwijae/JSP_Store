<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.Timestamp" %>
<%@ page import = "store.master.StoreDBBean" %>
<%@ page import = "store.master.StoreDataBean" %>

<%@ include file="../../etc/color.jspf"%> 
 
<%
String managerId ="";
try{
   managerId = (String)session.getAttribute("managerId");
   if(managerId==null || managerId.equals("")){
      response.sendRedirect("../logon/managerLoginForm.jsp");
}else{
%>
<%
int product_id = Integer.parseInt(request.getParameter("product_id"));
String product_kind = request.getParameter("product_kind");
try{
	StoreDBBean productProcess = StoreDBBean.getInstance();
    StoreDataBean product =  productProcess.getProduct(product_id); 
%>
<html>
<head>
<title>상품수정</title>
<link href="../../etc/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../../etc/script.js"></script>
</head>
<body bgcolor="<%=bodyback_c%>">
<p>상품 수정</p>
<br>

<form method="post" name="writeform" 
   action="productUpdatePro.jsp"  enctype="multipart/form-data">
<table>
   <tr>
    <td align="right" colspan="2" bgcolor="<%=value_c%>">
	    <a href="../managerMain.jsp"> 관리자 메인으로</a> &nbsp;
	    <a href="productList.jsp?product_kind=<%=product_kind%>">목록으로</a>
   </td>
   </tr>
   <tr>
    <td  width="100"  bgcolor="<%=value_c%>">분류 선택</td>
    <td  width="400"  align="left">
       <select name="product_kind">
           <option value="100" 
             <%if (product.getProduct_kind().equals("100")) {%>selected<%} %>
              >과자</option>
           <option value="200" 
             <%if (product.getProduct_kind().equals("200")) {%>selected<%} %>
             >음료수</option>
           <option value="300" 
             <%if (product.getProduct_kind().equals("300")) {%>selected<%} %>
             >문구</option>
       </select>
    </td>
  </tr>
  <tr>
    <td  width="100"  bgcolor="<%=value_c%>">이 름</td>
    <td  width="400" align="left">
        <input type="text" size="50" maxlength="50" name="product_name" 
            value="<%=product.getProduct_name() %>">
        <input type="hidden" name="product_id" value="<%=product_id%>"></td>
  </tr>
  <tr>
    <td  width="100"  bgcolor="<%=value_c%>">가 격</td>
    <td  width="400" align="left">
        <input type="text" size="10" maxlength="9" name="product_price" 
          value="<%=product.getProduct_price() %>">원</td>
  </tr>
  <tr>
    <td  width="100"  bgcolor="<%=value_c%>">수량</td>
    <td  width="400" align="left">
        <input type="text" size="10" maxlength="5" name="product_count" 
          value="<%=product.getProduct_count() %>">개</td>
  </tr>
   <tr>
    <td  width="100"  bgcolor="<%=value_c%>">중량</td>
    <td  width="400" align="left">
        <input type="text" size="10" maxlength="5" name="product_weight" 
          value="<%=product.getProduct_weight()%>">g</td>
  </tr>
  <tr>
    <td  width="100"  bgcolor="<%=value_c%>">제조사</td>
    <td  width="400" align="left">
        <input type="text" size="20" maxlength="30" name="publishing_com" 
          value="<%=product.getPublishing_com() %>"></td>
  </tr>
  <tr>
    <td  width="100"  bgcolor="<%=value_c%>">제조일</td>
    <td  width="400" align="left">
        <select name="publishing_year">
        <%
        Timestamp nowTime  = new Timestamp(System.currentTimeMillis());
        int lastYear = Integer.parseInt(nowTime.toString().substring(0,4));
           for(int i=lastYear;i>=2010;i--){
        %>
             <option value="<%=i %>"  
             <%if (Integer.parseInt(product.getPublishing_date().substring(0,4))==i) {%>
             selected<%} %>><%=i %></option>
        <%} %>
        </select>년
        
        <select name="publishing_month">
        <%
           for(int i=1;i<=12;i++){
        %>
             <option value="<%=i %>" 
             <%if (Integer.parseInt(product.getPublishing_date().substring(5,7))==i) {%>
               selected<%} %>><%=i %></option>
        <%} %>
        </select>월
        
        <select name="publishing_day">
        <%
           for(int i=1;i<=31;i++){
        %>
             <option value="<%=i %>" 
             <%if (Integer.parseInt(product.getPublishing_date().substring(8))==i) {%>
               selected<%} %>><%=i %></option>
        <%} %>
        </select>일
     </td>
  </tr>
  <tr>
    <td  width="100"  bgcolor="<%=value_c%>">이미지</td>
    <td  width="400" align="left">
        <input type="file" name="product_image"><%=product.getProduct_image() %></td>
  </tr>
 <tr>
    <td  width="100"  bgcolor="<%=value_c%>">할인율</td>
    <td  width="400" align="left">
        <input type="text" size="5" maxlength="2" name="discount_rate" 
          value="<%=product.getDiscount_rate() %>">%</td>
  </tr>
<tr>      
 <td colspan=2 bgcolor="<%=value_c%>" align="center"> 
  <input type="button" value="상품수정" onclick="updateCheckForm(this.form)">  
  <input type="reset" value="다시작성">
</td></tr></table>         
</form>   
<%
}catch(Exception e){
	e.printStackTrace();
}%>         
</body>
</html>
<% 
  }
}catch(Exception e){
	e.printStackTrace();
}
%>
