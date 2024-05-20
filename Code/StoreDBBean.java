package store.master;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import store.shopping.CustomerDataBean;

public class StoreDBBean {
	
    private static StoreDBBean instance 
                          = new StoreDBBean();
    
    public static StoreDBBean getInstance() {
        return instance;
    }
    
    private StoreDBBean() {}
    
    private Connection getConnection() throws Exception {
        Context initCtx = new InitialContext();
        Context envCtx = (Context) initCtx.lookup("java:comp/env");
        DataSource ds = (DataSource)envCtx.lookup("jdbc/store");
        return ds.getConnection();
    }
    
    
    public int managerCheck(String id, String passwd) 
	throws Exception {
		Connection conn = null;
        PreparedStatement pstmt = null;
		ResultSet rs= null;
        String dbpasswd="";
		int x=-1;
        
		try {
            conn = getConnection();
            
            pstmt = conn.prepareStatement(
            	"select managerPasswd from manager where managerId = ? ");
            pstmt.setString(1, id);
            
            rs= pstmt.executeQuery();

			if(rs.next()){
				dbpasswd= rs.getString("managerPasswd"); 
				if(dbpasswd.equals(passwd))
					x= 1; 
				else
					x= 0; 
			}else
				x= -1;
			
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
			if (rs != null) 
				try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) 
            	try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) 
            	try { conn.close(); } catch(SQLException ex) {}
        }
		return x;
	}
    
    
    public void insertProduct(StoreDataBean product) 
    throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = getConnection();
            
            pstmt = conn.prepareStatement(
            	"insert into product values (?,?,?,?,?,?,?,?,?,?,?)");
            pstmt.setInt(1,product.getProduct_id());
            pstmt.setString(2, product.getProduct_kind());
            pstmt.setString(3, product.getProduct_name());
            pstmt.setInt(4, product.getProduct_price());
            pstmt.setShort(5, product.getProduct_count());
            pstmt.setShort(6, product.getProduct_weight());
            pstmt.setString(7, product.getPublishing_com());
			pstmt.setString(8, product.getPublishing_date());
			pstmt.setString(9, product.getProduct_image());
			pstmt.setByte(10,product.getDiscount_rate());
			pstmt.setTimestamp(11, product.getReg_date());
			
            pstmt.executeUpdate();
            
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
            if (pstmt != null) 
            	try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) 
            	try { conn.close(); } catch(SQLException ex) {}
        }
    }
        
	public int getProductCount()
    throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        int x=0;

        try {
            conn = getConnection();
            
            pstmt = conn.prepareStatement("select count(*) from product");
            rs = pstmt.executeQuery();

            if (rs.next()) 
               x= rs.getInt(1);
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
            if (rs != null) 
            	try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) 
            	try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) 
            	try { conn.close(); } catch(SQLException ex) {}
        }
		return x;
    }
	
	
	public List<StoreDataBean> getProducts(String product_kind)
    throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<StoreDataBean> productList=null;
        
        try {
            conn = getConnection();
            
            String sql1 = "select * from product";
            String sql2 = "select * from product ";
            sql2 += "where product_kind = ? order by reg_date desc";
            
            if(product_kind.equals("all")){
            	 pstmt = conn.prepareStatement(sql1);
            }else{
                pstmt = conn.prepareStatement(sql2);
                pstmt.setString(1, product_kind);
            }
        	rs = pstmt.executeQuery();
            
            if (rs.next()) {
            	productList = new ArrayList<StoreDataBean>();
                do{
                     StoreDataBean product= new StoreDataBean();
                     
                     product.setProduct_id(rs.getInt("product_id"));
                     product.setProduct_kind(rs.getString("product_kind"));
                     product.setProduct_name(rs.getString("product_name"));
                     product.setProduct_price(rs.getInt("product_price"));
                     product.setProduct_count(rs.getShort("product_count"));
                     product.setProduct_weight(rs.getShort("product_weight"));
                     product.setPublishing_com(rs.getString("publishing_com"));
                     product.setPublishing_date(rs.getString("publishing_date"));
                     product.setProduct_image(rs.getString("product_image"));
                     product.setDiscount_rate(rs.getByte("discount_rate"));
                     product.setReg_date(rs.getTimestamp("reg_date"));
                     
                     productList.add(product);
			    }while(rs.next());
			}
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
            if (rs != null) 
            	try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) 
            	try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) 
            	try { conn.close(); } catch(SQLException ex) {}
        }
		return productList;
    }
	
	public StoreDataBean[] getProducts(String product_kind,int count)
    throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        StoreDataBean productList[]=null;
        int i=0;
        
        try {
            conn = getConnection();
            
            String sql = "select * from product where product_kind = ? ";
            sql += "order by reg_date desc limit ?,?";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, product_kind);
            pstmt.setInt(2, 0);
            pstmt.setInt(3, count);
        	rs = pstmt.executeQuery();

            if (rs.next()) {
            	productList = new StoreDataBean[count];
                do{
                     StoreDataBean product= new StoreDataBean();
                     product.setProduct_id(rs.getInt("product_id"));
                     product.setProduct_kind(rs.getString("product_kind"));
                     product.setProduct_name(rs.getString("product_name"));
                     product.setProduct_price(rs.getInt("product_price"));
                     product.setProduct_count(rs.getShort("product_count"));
                     product.setProduct_weight(rs.getShort("product_weight"));
                     product.setPublishing_com(rs.getString("publishing_com"));
                     product.setPublishing_date(rs.getString("publishing_date"));
                     product.setProduct_image(rs.getString("product_image"));
                     product.setDiscount_rate(rs.getByte("discount_rate"));
                     product.setReg_date(rs.getTimestamp("reg_date"));
                     
                     productList[i]=product;
                     
                     i++;
			    }while(rs.next());
			}
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
            if (rs != null) 
            	try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) 
            	try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) 
            	try { conn.close(); } catch(SQLException ex) {}
        }
		return productList;
    }
	
	
	public StoreDataBean getProduct(int productId)
    throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        StoreDataBean product=null;
        
        try {
            conn = getConnection();
            
            pstmt = conn.prepareStatement(
            	"select * from product where product_id = ?");
            pstmt.setInt(1, productId);
            
            rs = pstmt.executeQuery();

            if (rs.next()) {
            	product = new StoreDataBean();
                
            	product.setProduct_kind(rs.getString("product_kind"));
            	product.setProduct_name(rs.getString("product_name"));
            	product.setProduct_price(rs.getInt("product_price"));
            	product.setProduct_count(rs.getShort("product_count"));
            	product.setProduct_weight(rs.getShort("product_weight"));
            	product.setPublishing_com(rs.getString("publishing_com"));
            	product.setPublishing_date(rs.getString("publishing_date"));
            	product.setProduct_image(rs.getString("product_image"));
            	product.setDiscount_rate(rs.getByte("discount_rate"));
			}
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
            if (rs != null) 
            	try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) 
            	try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) 
            	try { conn.close(); } catch(SQLException ex) {}
        }
		return product;
    }
    
   
    public void updateProduct(StoreDataBean product, int productId)
    throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql;
        
        try {
            conn = getConnection();
            
            sql = "update product set product_kind=?,product_name=?,product_price=?";
            sql += ",product_count=?,product_weight=?,publishing_com=?,publishing_date=?";
            sql += ",product_image=?,discount_rate=?";
            sql += " where product_id=?"; 
            
            //sql = "update product set product_kind=?, product_name=?, product_price=?, product_count=?, product_weight=?,publishing_com=?, publishing_date=?,product_image, discount_rate=?, where product_id=?";
            
            pstmt = conn.prepareStatement(sql);
            
            pstmt.setString(1, product.getProduct_kind());
            pstmt.setString(2, product.getProduct_name());
            pstmt.setInt(3, product.getProduct_price());
            pstmt.setShort(4, product.getProduct_count());
            pstmt.setShort(5, product.getProduct_weight());
            pstmt.setString(6, product.getPublishing_com());
			pstmt.setString(7, product.getPublishing_date());
			pstmt.setString(8, product.getProduct_image());
			pstmt.setByte(9, product.getDiscount_rate());
			pstmt.setInt(10, productId);
            
            pstmt.executeUpdate();
            
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
            if (pstmt != null) 
            	try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) 
            	try { conn.close(); } catch(SQLException ex) {}
        }
    }
    
   
    public void deleteProduct(int productId)
    throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs= null;
        
        try {
			conn = getConnection();

            pstmt = conn.prepareStatement(
            	"delete from product where product_id=?");
            pstmt.setInt(1, productId);
            
            pstmt.executeUpdate();
            
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
            if (rs != null) 
            	try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) 
            	try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) 
            	try { conn.close(); } catch(SQLException ex) {}
        }
    }
    
    public List<StoreDataBean> getProducts(int start, int end)
            throws Exception {
       Connection conn = null;
       PreparedStatement pstmt = null;
       ResultSet rs = null;
       List<StoreDataBean> productList=null;
       try {
           conn = getConnection();
           
           pstmt = conn.prepareStatement(
           	"select * from product order by reg_date");
           rs = pstmt.executeQuery();

           if (rs.next()) {
               productList = new ArrayList<StoreDataBean>(end);
               do{
                 StoreDataBean product= new StoreDataBean();
                 product.setProduct_id(rs.getInt("product_id"));
                 product.setProduct_kind(rs.getString("product_kind"));
                 product.setProduct_name(rs.getString("product_name"));
                 product.setProduct_price(rs.getInt("product_price"));
                 product.setProduct_count(rs.getShort("product_count"));
                 product.setProduct_weight(rs.getShort("product_weight"));
                 product.setPublishing_com(rs.getString("publishing_com"));
                 product.setPublishing_date(rs.getString("publishing_date"));
                 product.setProduct_image(rs.getString("product_image"));
                 product.setDiscount_rate(rs.getByte("discount_rate"));
                 product.setReg_date(rs.getTimestamp("reg_date"));
				  
                 productList.add(product);
			    }while(rs.next());
			}
       } catch(Exception ex) {
           ex.printStackTrace();
       } finally {
           if (rs != null) try { rs.close(); } catch(SQLException ex) {}
           if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
           if (conn != null) try { conn.close(); } catch(SQLException ex) {}
       }
		return productList;
   }
}