<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>查询车位</title>
	<link rel="icon" href="${APP_PATH}/static/img/stop.ico" type="image/x-icon">
	<link rel="stylesheet" type="text/css" href="${APP_PATH}/static/css/default.css"/>
	<link rel="stylesheet" type="text/css" href="${APP_PATH}/static/css/carselect.css"/>
	<script src="${APP_PATH}/static/js/jquery.min.js"></script>
</head>
<body>
	<!--
       	作者：offline
       	时间：2018-07-17
       	描述：top
       -->
	<div class="top" id="item4">
		<div class="container clearfix">
			<ul class="fr clearfix">
			 <c:choose>
			    <c:when test="${userObj==null }">
				<li><a class="a_login" href="toUserLogin" title="登录">登录</a></li>
				</c:when>
				<c:otherwise>
				<li><a class="a_account" href="">${userObj.getAccount() }</a></li>
				<li><a class="a_logout" href="logout" onclick="alert('注销成功！');">退出登录</a></li>
				<li><a class="a_personal" href="usercenter/showOrder">个人中心</a></li>
				</c:otherwise>
			</c:choose>
			</ul>
		</div>
	</div>
	<!--
       	作者：offline
       	时间：2018-07-17
       	描述：header
       -->
	<div class="header">
		<div class="container clearfix">
			<div class="logo fl">
				<a href="userLoginToMain">
					<img src="${APP_PATH}/static/img/logo.png" alt="什么冬梅" />
				</a>
			</div>
			<div class="mm fr clearfix">
				<a href="carSelect">查车位</a>
			</div>
		</div>
	</div>
	<!--
       	作者：offline
       	时间：2018-07-18
       	描述：list-main
       -->
       <div class="list-main">
       	<div class="container">
       		<div class="bread" style="margin-bottom: 0;">当前位置：
				<a href="userLoginToMain">首页</a> &gt;
				<a href="carSelect">查车位</a>
			</div>
			<ul class="select">
				<li class="select-result">
					<dl>
						<dt>筛选条件：</dt>
						<dd class="select-no">
							<select class="form-control" name="selectId" id="selectId">
								<option value="-1">全部</option>
								<option value="0">可预约</option>
								<option value="1">已预约</option>
							</select>
						</dd>
					</dl>
				</li>
			</ul>
			<div class="tabs book clearfix" id="selectPark">
			<c:forEach items="${lotList }" var="item">
				<dl>
					<dt>
					<c:choose>
						<c:when test="${item.status==0 }">
							<a href="parkDetail?lotId=${item.id }">
								<img alt="可预约" src="${APP_PATH}/static/img/cw.png" title="可预约" />
							</a>
						</c:when>
						<c:otherwise>
							<img alt="已使用" src="${APP_PATH}/static/img/cw2.png" title="已使用" />
						</c:otherwise>
						</c:choose>
					</dt>
					<dd>
						<p><a href="parkDetail?lotId=${item.id }">${item.number }</a></p>
						<p></p>
						<p>￥${item.price }</p>
					</dd>
				</dl>
			</c:forEach>
			</div>
       	</div>
       </div>
	<!--
       	作者：offline
       	时间：2018-07-17
       	描述：footer
       -->
	<div class="footer">
		<div class="container">
			<div class="zhinan">
				<ul class="clearfix">
					<li class="item-li">关于我们
						<ul>
							<li><a href="#">联系我们</a></li>
							<li><a href="#">网站公告</a></li>
						</ul>
					</li>
					<li class="item-li">新手指南
						<ul>
							<li><a href="#">如何买票</a></li>
							<li><a href="#">修改密码</a></li>
						</ul>
					</li>
					<li class="item-li">配送方式
						<ul>
							<li><a href="#">配送范围</a></li>
							<li><a href="#">配送时间</a></li>
						</ul>
					</li>
					<li class="item-li">售后服务
						<ul>
							<li><a href="#">退票申请</a></li>
							<li><a href="#">改签申请</a></li>
						</ul>
					</li>
				</ul>
			</div>

			<div class="bottom">
				<p>友情链接：百度</p>
				<p>本站所有信息均为用户自由发布，本站不对信息的真实性负任何责任，交易时请注意识别信息的真假如有网站内容侵害了您的权益请联系我们删除</p>
				<p>Copyright &copy;1956-2018 什么冬梅停车系统.</p>
			</div>
		</div>
	</div>
	<!-- 
		2018.8.4 
		马伟涛   
		完成车位选择下拉联动
	 -->
	
	<script type="text/javascript">
		$(function(){	
			$("#selectId").val(-1);
			$("#selectId").on("change",function(){
				var selectId = $("#selectId").val();
				$.ajax({
					url:"carClassfiy",
					type:"GET",
					data:{"selectId":selectId},
					success:function(data){
						console.log(data);
						$("#selectPark").empty();
						for(var i = 0;i <= data.length;i++){
							var dl = $("<dl></dl>");
							$("#selectPark").append(dl);
							if(data[i].status === 0){
								var dt = $("<dt></dt>");
								var dta = $("<a href='parkDetail?lotId="+data[i].id+"'></a>");
								dt.append(dta);
								var dtImg = $("<img alt='可预约' src='${APP_PATH}/static/img/cw.png' title='可预约' />");
								dta.append(dtImg);
							}
							else{
								var dt = $("<dt></dt>");
								var dtImg = $("<img alt='已使用' src='${APP_PATH}/static/img/cw2.png' title='已使用' />");
								dt.append(dtImg);
							}
							dl.append(dt);
							var dd = $("<dd></dd>");
							dl.append(dd);
							var ddp1 = $("<p><a href='parkDetail?lotId="+data[i].id+"'>"+data[i].number+"</p>");
							dd.append(ddp1);
							var ddp2 = $("<p></p>");
							dd.append(ddp2);
							var ddp3 = $("<p>"+data[i].price+"</p>");
							dd.append(ddp3);
						}
					},
					error:function(){
						alert("加载失败！");
					}
				});
			});
		});
	</script>
</body>
</html>