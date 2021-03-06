<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>个人主页 - 萌课网</title>
<link rel="Shortcut Icon" href="<c:url value="/resource/pic/icon.ico" />" />
<link rel="stylesheet" href="<c:url value="/resource/bootstrap/css/bootstrap.css"/>" media="screen">
<script type="text/javascript" src="<c:url value="/resource/bootstrap/js/jquery-1.8.3.min.js"/>"></script>
<link rel="stylesheet" href="<c:url value="/resource/css/components.css"/>">
<link rel="stylesheet" href="<c:url value="/resource/css/site.css"/>">
<link rel="stylesheet" href="<c:url value="/resource/css/site_v2.css"/>">
<link rel="stylesheet" href="<c:url value="/resource/css/site_v3.css"/>">
<script type="text/javascript" src="<c:url value="/resource/js/ga.js"/>"></script>

<script type="text/javascript">
	$(function(){
            // a为ok代表已经关注 no代表尚未关注
			var a=$("#att").val();
			var userId=$("#btt").val();

			if(a=="no"){
                $("#follow-user").css("display","inline-block");
                $("#unfollow-user").css("display","none");
				}
			if(a=="ok"){
				$("#follow-user").css("display","none");
				$("#unfollow-user").css("display","inline-block");
				}
			$("#follow-user").click(function(){
				 $.ajax({
		            	type:"post",
		            	url:"addAttention.htm",
		            	data:"userBid="+userId,
		            	success:function(msg){
		            		if(msg=="true"){
		            			$("#follow-user").css("display","none");
		        				$("#unfollow-user").css("display","inline-block");
		            		} else {
                                $("#follow-user").css("display","none");
                                $("#unfollow-user").css("display","inline-block");
                            }
		            	}
		          
		            });
				});
			$("#unfollow-user").click(function(){
				$.ajax({
	            	type:"post",
	            	url:"delAttention.htm",
	            	data:"userBid="+userId,
	            	success:function(msg){
	            		if(msg=="delOk"){
	            			$("#follow-user").css("display","inline-block");
	        				$("#unfollow-user").css("display","none");
	            		} else {

                        }
	            	}
	            });
			});
		});
</script>

</head>
<body class="lily-theme">

<jsp:include page="/jsp/include/head2.jsp"></jsp:include>

<section class="content container">
  <div class="container-padding clearfix">
    <div class="user-side">
      <div class="mod uportrait-mod">
      <div class="portrait">
                  <img src="<c:url value="${user1.headImage.imageLarge}"/>" alt="">
              </div>
      </div>
      
      <div class="mod uinfo-mod">
                
          <div class="info-item"><span class="info-item-name">昵称：</span> <strong>${user1.userName}</strong></div>

          <c:if test="${empty user1.city}">
          <div class="info-item"><span class="info-item-name">现居：地球村</span></div>
          </c:if>
          <c:if test="${!empty user1.city}">
          <div class="info-item"><span class="info-item-name">现居：${user1.city}</span></div>
          </c:if>

          <div class="info-item"><span class="fr">${user1.credit}学分</span><span class="info-item-name">等级：${level.lv}级&nbsp;${level.title}</span></div>

          <c:if test="${empty user1.intro}">
          <div class="info-item"><span class="info-item-name">简介：</span> 还什么都没写</div>
          </c:if>
          <c:if test="${!empty user1.intro}">	
          <div class="info-item"><span class="info-item-name">简介：</span> ${user1.intro}</div>
          </c:if>

          <c:if test="${empty user1.qq}">
              <div class="info-item"><span class="info-item-name">QQ：</span> 尚未绑定</div>
          </c:if>
          <c:if test="${!empty user1.qq}">
              <div class="info-item"><span class="info-item-name">QQ：</span> ${user1.qq}</div>
          </c:if>

          <c:if test="${empty user1.wechat}">
              <div class="info-item"><span class="info-item-name">微信：</span> 尚未绑定</div>
          </c:if>
          <c:if test="${!empty user1.wechat}">
              <div class="info-item"><span class="info-item-name">微信：</span> ${user1.wechat}</div>
          </c:if>

          <c:if test="${user1.userId==user.userId}">
           <div class="info-item"> <a href="account.htm">编辑个人资料</a> <span class="info-item-name mhs">|</span>  <a href="goAccountAvatar.htm">更新头像</a> </div>
            </c:if>
            <c:if test="${user1.userId!=user.userId}">
           		<div class="info-item"><a href="goSendMail1.htm?userName=${user1.userName}" class="btn-n2sec">发私信</a></div>
            </c:if>               
                
      </div>
      
            
      <div class="mod">
        <h3>关注</h3>
        	
                <div class="mini-users-panel clearfix">
                <c:forEach items="${attentionList}" var="att">
          			<a href="goPersonnal.htm?userId=${att.userByAttentionedUserId.userId}"><img src="<c:url value="${att.userByAttentionedUserId.headImage.imageMid}"/>" title="${att.userByAttentionedUserId.userName}"></a>
          		 </c:forEach> 
          		</div>
       </div>
      
      <div class="mod">
        <h3>粉丝</h3>
       	  <div class="mini-users-panel clearfix">
       	  <c:forEach items="${fansList}" var="fans">
         	 <a href="goPersonnal.htm?userId=${fans.userByUserId.userId}"><img src="<c:url value="${fans.userByUserId.headImage.imageMid}"/>" title="${fans.userByUserId.userName}" ></a>
          </c:forEach>
          </div>
      </div>
    </div>
  
    <div class="user-main">
      <div class="UIImageBlock upage-top clearfix">
    <div class="UIImageBlock_Content">
    <div class="head">
    <c:if test="${user1.userId!=user.userId}">
    	<div class="fr" id="follow-user-opts">
          <a href="javascript:;" id="follow-user" class="btn btn-success ajax-action" style="display: inline-block;"><i class="icon-plus icon-white"></i> 关注TA</a>
          <a href="javascript:;" id="unfollow-user" class="btn btn-success active ajax-action" style="display: none;">已关注 | 取消 </a>
          <input type="hidden" name="aa" value="${isOk}" id="att">
          <input type="hidden" name="bb" value="${user1.userId}" id="btt">
        </div>
    </c:if>

      <div class=""><h2>${user1.userName}</h2></div>
    </div>


    <div class="nav clearfix">
      <a href="goPersonnal.htm?userId=${user1.userId}" class="on">主页</a>
      <a href="goPersonalTeam.htm?userId=${user1.userId}">小组</a>
      <a href="goPersonalAtt.htm?userId=${user1.userId}">好友</a>
      <a href="goPersonalNote.htm?userId=${user1.userId}">笔记</a>
    </div>
  </div>
</div>


      <div class="upage-content">
        <c:if test="${user1.userId==user.userId}">
        <div class="mod">
        
          <div class="mod-head">
          <h3><span>我的标签</span></h3>
        	</div>
           <div class="tags">
        	<c:forEach items="${labelList}" var="lablist">
             	<a href="" class="tag">${lablist.label.labelName}</a>
        	</c:forEach>
        	</div>
        	<div class="info-item"> <a href="queryLabel.htm?type=user">编辑标签</a></div>
        </div>
        </c:if>

          <c:if test="${user1.userId!=user.userId}">
        <div class="mod">
        
           <div class="mod-head">
          <h3><span>他的标签</span></h3>
        	</div>
          <div class="tags">
        	<c:forEach items="${labelList}" var="label">
             	<a href="" class="tag">${label.label.labelName}</a>
        	</c:forEach>
        	</div>
        </div>
        </c:if>

       	<hr>
        <div class="mod">
          			<h3>在学的课程</h3>
      				 <ul class="course-cards">
      				 <c:forEach items="${currentCourseList}" var="course">
                        <li>
							<div class="course-item">
  								<div class="thumb"><a href=""><img src="/resource/pic/daa.jpg"></a></div>
 									<p class="title"><a href="" title="新版课程创建指南">${course.course.courseTitle}</a></p>
    								<p class="metas clearfix">
    									
										<span class="fr view mrm" title="查看次数">浏览次数：${course.course.scanNum}</span>
  									</p>
							</div>
						</li>
						</c:forEach>
         			</ul>
         </div>
        	<hr>
                <div class="mod">
          				<h3>学过的课程</h3>
      				 <ul class="course-cards">
      				  <c:forEach items="${endCourseList}" var="course">
                        <li>
							<div class="course-item">
  								<div class="thumb"><a href=""><img src="/resource/pic/daa.jpg"></a></div>
 									<p class="title"><a href="" title="新版课程创建指南">${course.course.courseTitle}</a></p>
    								<p class="metas clearfix">
										<span class="fr view mrm" title="查看次数">浏览次数：${course.course.scanNum}</span>
  									</p>
							</div>
						</li>
						</c:forEach>
         			</ul>
                  </div>
     
    </div>
  
</div>
</div></section>
<jsp:include page="/jsp/include/foot.jsp"></jsp:include>

</body>
</html>