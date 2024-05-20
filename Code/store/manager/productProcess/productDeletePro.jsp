<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import = "store.master.StoreDBBean" %>

<% request.setCharacterEncoding("utf-8");%>

<%
  int product_id = Integer.parseInt(request.getParameter("product_id"));
  String product_kind = request.getParameter("product_kind");
 
  StoreDBBean productProcess = StoreDBBean.getInstance();
  productProcess.deleteProduct(product_id); 

  response.sendRedirect("productList.jsp?product_kind="+product_kind);
%>
