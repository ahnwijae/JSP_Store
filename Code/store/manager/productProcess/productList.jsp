<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "store.master.StoreDBBean" %>
<%@ page import = "store.master.StoreDataBean" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.text.SimpleDateFormat" %>

<%@ include file="../../etc/color.jspf"%> 

<%
String managerId ="";
try{
	managerId = (String)session.getAttribute("managerId");
	if(managerId==null || managerId.equals("")){
       response.sendRedirect("../logon/managerLoginForm.jsp");
	}else{
%> 

<%!
    SimpleDateFormat sdf = 
        new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>

<%
    List<StoreDataBean> productList = null; 
    int number =0;
    String product_kind="";
    
    product_kind = request.getParameter("product_kind");
 
    StoreDBBean productProcess = StoreDBBean.getInstance();
    int count = productProcess.getProductCount();
    
    if (count > 0) {
    	productList = productProcess.getProducts(product_kind);
    }
%>
<html>
<head>
<title>등록된 상품 목록</title>
<link href="../../etc/style.css" rel="stylesheet" type="text/css">
</head>
<body bgcolor="<%=bodyback_f%>">
<%
   String product_kindName="";
   if(product_kind.equals("100")){
	   product_kindName="과자";
   }else if(product_kind.equals("200")){
	   product_kindName="음료";  
   }else if(product_kind.equals("300")){
	   product_kindName="문구";
   }else if(product_kind.equals("all")){
	   product_kindName="전체";
   }
%>
<center><table style='border:0 solid white'>
   <tr>
    <td align="right" colspan="2" bgcolor="<%=value_d%>">
	    <a href="../managerMain.jsp"> <h3>관리자 메인으로</h3></a> 
   </td>
  </tr>
</table></center>
<p>
<p>

<%
  if (count == 0) {
%>
<table>
<tr>
   <td align="center">
           등록된 상품이 없습니다.
   </td>
</table>

<%} else {%>
<center><table>
     <td colspan="2" align="right" bgcolor="<%=value_b%>">
       <a href="productRegisterForm.jsp">상품 등록</a> 
     </td>
	 <td aligh="right" bgcolor="<%=value_e%>">
       <a href='productList.jsp?product_kind=all'>전체목록</a>
	 </td>
	 <td aligh="right" bgcolor="<%=value_e%>">
       <a href="productList.jsp?product_kind=<%=100%>">과자</a>
    </td>
    
    <td aligh="right" bgcolor="<%=value_e%>">
       <a href="productList.jsp?product_kind=<%=200%>">음료</a>
    </td>
    
    <td aligh="right" bgcolor="<%=value_e%>">
       <a href="productList.jsp?product_kind=<%=300%>">문구</a>
    </td>
     <tr height="30" bgcolor="<%=value_f%>"> 
      <td align="center"  width="30">번호</td> 
      <td align="center"  width="30">상품분류</td> 
      <td align="center"  width="100">이름</td>
      <td align="center"  width="50">가격</td> 
      <td align="center"  width="50">수량</td> 
      <td align="center"  width="70">중량</td>
      <td align="center"  width="70">제조사</td>
      <td align="center"  width="50">제조일</td>
      <td align="center"  width="50">상품이미지</td>
      <td align="center"  width="30">할인율</td>
      <td align="center"  width="70">등록일</td>
      <td align="center"  width="50">수정</td>
      <td align="center"  width="50">삭제</td>         
    </tr>
<%  
    for (int i = 0 ; i <productList.size() ; i++) {
      StoreDataBean product = 
    		  (StoreDataBean)productList.get(i);
%>
   <tr height="30">
      <td width="30"><%=++number%></td> 
      <td width="30"><%=product.getProduct_kind()%></td> 
      <td width="100" align="left">
           <%=product.getProduct_name()%></td>
      <td width="50" align="right"><%=product.getProduct_price()%>원</td> 
      <td width="50" align="right">
      <% if(product.getProduct_count()==0) {%>
         <font color="red"><%="일시품절"%></font>
      <% }else{ %>
         <%=product.getProduct_count()%>
      <%} %>
      개</td> 
      <td width="70"><%=product.getProduct_weight()%>g</td>
      <td width="70"><%=product.getPublishing_com()%></td>
      <td width="50"><%=product.getPublishing_date()%></td>
      <td width="50"><%=product.getProduct_image()%></td>
      <td width="50"><%=product.getDiscount_rate()%></td>
      <td width="50"><%=sdf.format(product.getReg_date())%></td>
      <td width="50">
         <a href="productUpdateForm.jsp?product_id=<%=product.getProduct_id()%>&product_kind=<%=product.getProduct_kind()%>">수정</a></td>
      <td width="50">
         <a href="productDeleteForm.jsp?product_id=<%=product.getProduct_id()%>&product_kind=<%=product.getProduct_kind()%>">삭제</a></td>    
   </tr>
<%}%>
</table></center> 
<%}%>
<br>
<a href="../managerMain.jsp"> <h2>관리자 메인으로</h2></a> 
<p><%=product_kindName%> 분류의 목록: 
<%if(product_kind.equals("all")){%> 
    <%=count%>개
<%}else{%>
    <%=productList.size() %>개
<%} %>
</p>
</body>
</html>

<% 
   }
}catch(Exception e){
   e.printStackTrace();
}
%>
