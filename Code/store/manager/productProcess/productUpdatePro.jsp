<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="store.master.StoreDBBean" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>

<% request.setCharacterEncoding("utf-8");%>

<%
String realFolder = "";
String filename ="";
MultipartRequest imageUp = null;

String saveFolder = "/imageFile";
String encType = "utf-8"; 
int maxSize = 2*1024*1024;  
ServletContext context = getServletContext();
realFolder = context.getRealPath(saveFolder);  

try{
    imageUp = new MultipartRequest(
		   request,realFolder,maxSize,encType,new DefaultFileRenamePolicy());
   
   Enumeration<?> files = imageUp.getFileNames();
   
   while(files.hasMoreElements()){
      String name = (String)files.nextElement();
   
      filename = imageUp.getFilesystemName(name);
   }
}catch(IOException ioe){
 System.out.println(ioe);
}catch(Exception ex){
 System.out.println(ex);
}
%>

<jsp:useBean id="product" scope="page" 
     class="store.master.StoreDataBean">
</jsp:useBean>

<%
 int product_id= Integer.parseInt(imageUp.getParameter("product_id"));
 String product_kind = imageUp.getParameter("product_kind");
 String product_name = imageUp.getParameter("product_name");
 String product_price = imageUp.getParameter("product_price");
 String product_count = imageUp.getParameter("product_count");
 String product_weight = imageUp.getParameter("product_weight");
 String publishing_com = imageUp.getParameter("publishing_com");
 String discount_rate = imageUp.getParameter("discount_rate");

 String year = imageUp.getParameter("publishing_year");
 String month = 
		 (imageUp.getParameter("publishing_month").length()==1)?
		 "0"+ imageUp.getParameter("publishing_month"): 
			 imageUp.getParameter("publishing_month");
 String day =  (imageUp.getParameter("publishing_day").length()==1)?
		 "0"+ imageUp.getParameter("publishing_day"): 
			 imageUp.getParameter("publishing_day");

 product.setProduct_kind(product_kind);
 product.setProduct_name(product_name);
 product.setProduct_price(Integer.parseInt(product_price));
 product.setProduct_count(Short.parseShort(product_count));
 product.setProduct_weight(Short.parseShort(product_weight)); 
 product.setPublishing_com(publishing_com);
 product.setPublishing_date(year+"-"+month+"-"+day);
 product.setProduct_image(filename);
 product.setDiscount_rate(Byte.parseByte(discount_rate));
 product.setReg_date(new Timestamp(System.currentTimeMillis()));

StoreDBBean productProcess = StoreDBBean.getInstance();
productProcess.updateProduct(product, product_id); 

response.sendRedirect("productList.jsp?product_kind="+product_kind);
%>
