<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="edu.neu.lovesports.orm.dao.*, java.util.*, edu.neu.lovesports.orm.method.*, edu.neu.lovesports.orm.models.*, java.sql.*, javax.script.*,javax.servlet.jsp.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>LoveSports</title>
</head>
<body>
<form action="doUpload.jsp" method="POST" enctype="multipart/form-data">
File Name: <input type="text" name="name"/><br>
Select: <input type="file" name="file1"/>
<input type="submit" value="upload"/>
</form>     
<%
	//注意：enctype="multipart/form-data"这个一定要这样设置，具体什么意思我也不是很清楚.....（呵呵） 提交到执行的页面如下：      //实例化上传组件
    SmartUpload upload = new SmartUpload();
    //初始化上传组件
    upload.initialize(this.getServletConfig(), request, response);
    //开始上传
    upload.upload();
    //获取上传的文件列表对象
    Files f = upload.getFiles();
    //获取文件对象
    File fil = f.getFile(0);
    //去掉文件后缀
    String ext = fil.getFileExt();
    //判断文件类型是否是jpg格式jpg,gif,bmp,png,JPG,GIF,BMP,PNG
     if (!(ext.equals("jpg")) && !(ext.equals("gif")) && !(ext.equals("bmp")) && !(ext.equals("png")) && !(ext.equals("JPG")) && !(ext.equals("GIF")) && !(ext.equals("BMP")) && !(ext.equals("PNG"))) {
            out.println("<script type='text/javascript'>alert('文件类型错误');location.replace('upLoadPhoto.jsp');</script>");
            return;
     }
    //满足条件进行文件的上传uploadImages在webRoot文件夹下的一个目录
    fil.saveAs("uploadImages/" + fil.getFileName());
    String filepath = "uploadImages/" + fil.getFileName();       //保存到数据库的路径 OK.这样就可以了.....
    %>
</body>
</html>