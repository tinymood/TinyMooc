<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="/resource/jspf/commons.jspf" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>${currentCourse.course.courseTitle} - 萌课网</title>

    <script type="text/javascript">
        $(document).ready(function () {
            var stepW = 24;

            var a = $("#aa").val();

            var stars = $("#star > li");
            $("#showb1").css({"width": stepW * a/2});
            $("#showb").css("width", 0);
            stars.each(function (i) {
                $(stars[i]).click(function (e) {
                    var n = i + 1;
                    $("#showb").css({"width": stepW * n});

                    $(this).find('a').blur();

                    var courseId = $("#courseId").val();

                    $("#score").val(n);

                    $.ajax({
                        type: "post",
                        url: "doGrade.htm",
                        data: "score=" + n + "&courseId=" + courseId,
                        success: function (msg) {
                            if (msg == "ok") {
                                alert("评价成功！");
                            }
                            if (msg == "no") {
                                $("#showb").css("width", 0);
                                alert("你已经评价过了，不能重复评价！");

                            }
                            if (msg == "go") {

                                alert("请登录后再评价");

                            }
                        }

                    });
                    return stopDefault(e);

                });
            });
        });

        function stopDefault(e) {
            if (e && e.preventDefault)
                e.preventDefault();
            else
                window.event.returnValue = false;
            return false;
        }
        ;
    </script>

    <script type="text/javascript">
        $("#start").live("click", function () {
            <c:if test="${empty user}">
                $.scojs_message("登录后才可以加入学习计划哦(づ￣3￣)づ╭❤～", $.scojs_message.TYPE_OK);
                return false;
            </c:if>
            <c:if test="${!empty user}">
            if ($("#start").html() == "学习中") {
                alert("暂不支持取消课程的学习┗( T﹏T )┛");
            }
            if ($("#start").html() == "开始学习") {
                var courseId = $("#courseId").val();
                location.href = "startStudy.htm?courseId=" + courseId;
            }
            </c:if>
        });

        //$("#status").children("li.lili").each(function(){
        //var a=$(this).children(".lesson-learned-status").html();
        //alert("a");
        //});
    </script>

</head>

<body class="flats-theme">

<c:if test="${empty user.userId}">
    <jsp:include page="/jsp/include/head1.jsp"></jsp:include>
</c:if>
<c:if test="${!empty user.userId}">
    <jsp:include page="/jsp/include/head2.jsp"></jsp:include>
</c:if>

<section class="container course">
    <div id="course-main">
        <div id="course-header" class="flat course-header course-large-header">

            <div class="imagblock clearfix">
                <div class="imageblock-image posrel">
                    <img src="/resource/pic/courseLogo/course${picSuffix}.jpg" alt="${currentCourse.course.courseTitle}"
                         width=190 height=140/>
                </div>
                <div class="imageblock-content">
                    <div class="clearfix">
                        <h1 class="pull-left">${currentCourse.course.courseTitle}</h1>
                    </div>

                    <ul class="course-metas">
                        <li>
                            <c:if test="${userGrade !='0.0'}">
                                <div id="xzw_starSys">
                                    <div id="xzw_starBox">
                                        <ul class="star" id="star1">
                                            <li><a href="javascript:void(0)" title="很差" class="one-star"></a></li>
                                            <li><a href="javascript:void(0)" title="较差" class="two-stars"></a></li>
                                            <li><a href="javascript:void(0)" title="还行" class="three-stars"></a></li>
                                            <li><a href="javascript:void(0)" title="推荐" class="four-stars"></a></li>
                                            <li><a href="javascript:void(0)" title="力荐" class="five-stars"></a></li>
                                        </ul>
                                        <div class="current-rating" id="showb1">
                                            <input type="hidden" name="grade" value="" id="score1">
                                            <input type="hidden" name="a" value="${userGrade}" id="aa">
                                        </div>
                                    </div>
                                </div>
                                <span><fmt:formatNumber type="number" value="${userGrade}" pattern="0.0" maxFractionDigits="1"/></span>
                            </c:if>
                            <c:if test="${userGrade==0.0}">
                                <span>还没有人评分，快去评分吧</span>
                            </c:if>
                        </li>
                        <li>
                            <span>课时：</span>${lessonNum} 课
                        </li>
                        <li>
                            <span>学员：</span><a href="">${studentNum}</a> 人
                        </li>
                        <li>
                            <span>浏览：</span>${currentCourse.course.scanNum} 次
                        </li>
                    </ul>

                    <div class="action-bar">
                        <c:if test="${currentCourse.user.userId ne user.userId}">
                            <button class="btn btn-large btn-success" id="start">${currentCourseState}</button>
                        </c:if>
                    </div>

                </div>
            </div>

            <div class="course-summary-metas mtl">
                <h2>简介</h2>

                <div class="course-summary mbl">
                    ${currentCourse.course.courseIntro}
                </div>
                <h2>标签</h2>

                <div class="course-tags" id="course-tags">
                    <c:if test="${empty labelList}">
                        <b>暂时没有标签</b>
                        <c:if test="${user.userId eq currentCourse.user.userId}">
                            <a href="">（添加标签）</a>
                        </c:if>
                    </c:if>
                    <c:if test="${!empty labelList}">
                        <c:forEach items="${labelList}" var="label">
                            <a href="" class="tag">${label.label.labelName}</a>
                        </c:forEach>
                    </c:if>
                </div>
            </div>


            <div class="clearfix mvl" align="left">
                <div class="fr">
                    我的评价：

                    <div id="xzw_starSys">
                        <div id="xzw_starBox">
                            <ul class="star" id="star">
                                <li><a href="javascript:void(0)" title="很差" class="one-star"></a></li>
                                <li><a href="javascript:void(0)" title="较差" class="two-stars"></a></li>
                                <li><a href="javascript:void(0)" title="还行" class="three-stars"></a></li>
                                <li><a href="javascript:void(0)" title="推荐" class="four-stars"></a></li>
                                <li><a href="javascript:void(0)" title="力荐" class="five-stars"></a></li>
                            </ul>
                            <div class="current-rating" id="showb">
                                <input type="hidden" name="grade" id="score">
                                <input type="hidden" name="course" id="courseId"
                                       value="${currentCourse.course.courseId}">
                            </div>
                        </div>
                    </div>

                </div>
            </div>

            <div>
                <div class="clearfix mtm">
                    <div class="pills" style="margin-bottom:0px">
                        <a href="" class="on">课时</a>
                    </div>
                </div>
            </div>
        </div>

        <div class="flat">

            <div class="btn-group fr">
                <c:if test="${currentCourse.user.userId==user.userId}">
                    <a class="btn btn-small"
                       href="createLessonPage.htm?courseId=${currentCourse.course.courseId}">新增课时</a>
                </c:if>
            </div>

            <h2>课时 <span class="lessons-total">(共${lessonNum}小节)</span></h2>

            <div class="lessons">
                <ul id="status">
                    <c:if test="${lessonNum==0}">
                        <b>创建者暂时还没有添加课时</b>
                        <c:if test="${user.userId eq currentCourse.user.userId}">
                            <a href="createLessonPage.htm?courseId=${currentCourse.course.courseId}">（添加课时）</a>
                        </c:if>
                    </c:if>
                    <c:if test="${lessonNum>0}">
                        <c:forEach items="${lessonList}" var="lesson" varStatus="vs">
                            <li class="lili">
                                <span class="lesson-index">L${vs.index+1}</span>
                                <span class="lesson-title"><a
                                        href="lessonPage.htm?childrenId=${lesson.course.courseId}">${lesson.course.courseTitle}</a></span>
                                <span class="lesson-learned-status">
                                        ${lesson.learnState}
                                </span>

                                <div class="lesson-summary">
                                        ${fn:substring(lesson.course.courseIntro,0,50)}
                                </div>
                            </li>
                        </c:forEach>
                    </c:if>
                </ul>
            </div>
        </div>
    </div>


    <div id="course-side">
        <div class="flat">
            <h3>课程创建人</h3>

            <div class="course-author-block imageblock clearfix">
                <div class="imageblock-image"><a href="goPersonnal.htm?userId=${currentCourse.user.userId}"
                                                 class="show-user-card"><img
                        src="${currentCourse.user.headImage.imageMid}" alt="${currentCourse.user.userName}"></a>
                </div>
                <div class="imageblock-content">

                    <c:if test="${currentCourse.user.userId ne user.userId}">
                        <c:if test="${isAttention==0}">
                            <a href="" class="btn btn-small action-ajax fr"><i class="icon-plus"></i> 关注TA</a>
                        </c:if>
                        <c:if test="${isAttention==1}">
                            <a href="" class="btn btn-small disabled action-ajax fr"><i class="icon-plus"></i> 已关注</a>
                        </c:if>
                    </c:if>
                    <div class="userName"><a href="goPersonnal.htm?userId=${currentCourse.user.userId}"
                                             class="show-user-card"
                                             title="${currentCourse.user.userName}">${currentCourse.user.userName}<span
                            class="o-ver-icn"></span></a></div>
                    <div>
                        <a href="" class="stats"><em>课程&nbsp;${creatorCourseNum}</em></a>
                        <a href="" class="stats"><em>粉丝&nbsp;${fansNum} </em></a>
                        <a href="" class="stats"><em>关注&nbsp;${followNum} </em></a>
                    </div>
                </div>
                <div class="mtm gray">${currentCourse.user.intro}</div>
            </div>
        </div>


        <div class="flat">
            <h2>最近加入的学员</h2>
            <ul class="grids smallpic-grids">
                <c:if test="${empty userLearnCourseList}">
                    暂无用户学习此课程
                </c:if>
                <c:if test="${!empty userLearnCourseList}">
                    <c:forEach items="${userLearnCourseList}" var="course">
                        <li class="grid">
                            <a href="goPersonnal.htm?userId=${course.user.userId}" class="show-user-card"><img
                                    src="${course.user.headImage.imageMid}" title="${course.user.userName}"></a>

                            <div><a href="" class="show-user-card"
                                    title="${course.user.userName}">${course.user.userName}</a></div>
                        </li>
                    </c:forEach>
                </c:if>
            </ul>
        </div>

        <div class="flat">
            <h2>已完成该课程的学员</h2>
            <ul class="grids smallpic-grids">
                <c:if test="${empty userEndCourseList}">
                    暂无用户学完此课程
                </c:if>
                <c:if test="${!empty userEndCourseList}">
                    <c:forEach items="${userEndCourseList}" var="course">
                        <li class="grid">
                            <a href="" class="show-user-card"><img src="${course.user.userName}"
                                                                   alt="${course.user.headImage.imageMid}"></a>

                            <div><a href="" class="show-user-card"
                                    title="${course.user.headImage.imageMid}">${course.user.headImage.imageMid}</a>
                            </div>
                        </li>
                    </c:forEach>
                </c:if>
            </ul>
        </div>

        <div>

        </div>
    </div>
</section>

<jsp:include page="/jsp/include/foot.jsp"></jsp:include>

</body>
</html>