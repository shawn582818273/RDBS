<%@ page language="java" 
 pageEncoding="GB2312" 
 contentType="text/html; charset=GB2312" 
 import="java.awt.*,
   java.awt.image.*, 
   javax.swing.*,
   com.sun.image.codec.jpeg.*,
   javax.imageio.*"
%>

<html>
<head>
<title>我的图画</title>
</head>
<body>
<%

 System.out.println("----------");
 int width=400,height=400;
 BufferedImage image = new BufferedImage(width,height,BufferedImage.TYPE_INT_RGB);
 Graphics g = image.getGraphics();

 g.setColor(Color.WHITE);
 g.fillRect(0,0,width,height);

 g.setColor(Color.BLACK);
 g.drawString("交通工具使用率",10,10);

 g.setColor(Color.RED);
 //填充图形
 g.fillRect(30,30,100,20);
 g.setColor(Color.BLACK);
 //画边框
 g.drawRect(30,30,100,20);
 //写字
 g.drawString("飞机",135,45);

 g.setColor(Color.BLUE);
 g.fillRect(30,55,120,20);
 g.setColor(Color.BLACK);
 g.drawRect(30,55,120,20);
 g.drawString("火车",155,70);

 g.setColor(Color.YELLOW);
 g.fillRect(30,80,90,20);
 g.setColor(Color.BLACK);
 g.drawRect(30,80,90,20);
 g.drawString("轮船",125,95);
// 这种方式也可以输出,在jdk1.3中常常使用 
// 将ContentType设为"image/jpeg", 以让浏览器识别图像格式。
response.setContentType("image/jpeg");
// 建立JPEG图像编码器，将BufferedImage编码成jpeg格式输出到response的输出流。
JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(response.getOutputStream());
JPEGEncodeParam param = encoder.getDefaultJPEGEncodeParam(image);
param.setQuality(1.0F, true);
encoder.encode(image, param);

 // 在jdk1.4开始，引入了一个新的imageio库，提供了一个新的工具类ImageIO来进行图像的输出和输出操作。使用ImageIO进行图像的输 出操作，可使代码更加简洁，如下：
 
 // 关闭缓存(缺省情况下是开启的)。在实际应用中我们发现，
    // 如果不关闭缓存，在IE5.5上可能无法正常运行本程序。
    // 而IE5.0和IE6.0则不会有问题。 
    ImageIO.setUseCache(false);
    // 将图像以jpg格式写入到输出流。
    ImageIO.write(image, "jpg", response.getOutputStream());
    
    
    // 从数据库取得图片并在上面加水印字
 // 一般我们将图片以二进制格式存在数据库中。借助ImageIO的read方法，我们可以直接将数据库中的图片生成BufferedImage. 
 
 // 这里我们假设在数据库表tabimage中有一个myimage字段存放有图片。
 PreparedStatement ps = conn.prepareStatement("SELECT myimage FROM tblimage WHERE id=119");
 ResultSet rs = ps.executeQuery();
 InputStream data = null;
 if (rs.next()) 
 {
     // 取得图片的输入流
     data = rs.getBinaryStream("signet");
 }
 rs.close();
 ps.close();
 if (data == null) {
 conn.close();
 return null;
 }
 ImageIO.setUseCache(false);
 // 将图片读入到BufferedImage对象中。
 BufferedImage image = ImageIO.read(data);
 conn.close();
 // 取得图像的graphics对象，
 Graphics graphics = image.createGraphics()
 // 通过graphics对象在图片上写上文字
 graphics.drawString("Hello World!",10,10);
 // 余下的代码就是将图像输出，请参考前面的例子。由于这个例子涉及到数据库的操作，无法给出完整的例子。 
 
 // 制作缩略图
 
 // 在很多在线购物的网站，通常将商品的介绍图片以缩略图的形式显示在商品目录清单中，用户点击缩略图后再弹出商品的详细内容及     原始图片。 
 
 // 所谓缩略图就是将原图以一定比例缩小。同样，借助ImageIO, 我们先从数据库(或文件)读入一个图片(参考上面的例子)， 
 
 //生成缩略图
 // 读入原始图的image对象
 InputStream inputstream = new FileInputStream("E://tomcat5//webapps//testset//web.gif");
 BufferedImage src = ImageIO.read(inputstream);
 // 得到原图的宽度和高度
 int wideth=src.getWidth(); 
 int height=src.getHeight(); 
 // 生成原图1/2大小的内存图像，你也可以指定固定大小
 BufferedImage taget = new BufferedImage(wideth/2,height/2,BufferedImage.TYPE_INT_RGB);
 // 将原图绘制在缩小后的内存图像上 
 taget.getGraphics().drawImage(src,0,0,wideth/2,height/2,null); 
    ImageIO.setUseCache(false);
    ImageIO.write(taget, "jpg", response.getOutputStream()); 
%>
</body>
</html>