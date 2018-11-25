<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- ===============필수포함=============== -->
<!-- Bootstrap core CSS -->
<link href="/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="/css/notice.css" rel="stylesheet">
<link href="/css/common.css" rel="stylesheet">



<link href="https://fonts.googleapis.com/css?family=Jua" rel="stylesheet">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css"
	integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU"
	crossorigin="anonymous">
<!-- ===============필수포함=============== -->
</head>
<body>
	<div id="wrap" style="background-color: #fff">
		<div class="col" style="position: absolute; height: 105px; background-color: white">
			<!-- 헤더 배경색 적용 -->
		</div>

		<div class="container">
			<div class="row">
				<div class="col" style="position: absolute; height: 105px; background-color: white">
					<!-- 헤더 배경색 적용 -->
				</div>

				<div class="col-lg-12" style="z-index: 100">
					<jsp:include page="../headerMain.jsp"></jsp:include>
				</div>

				<!-- 카테고리 nav (스크립트로 임시 inclue) -->
				<div class="col-lg-12">
					<jsp:include page="../headerNav.jsp"></jsp:include>
				</div>


				<div class="container col-lg-10 mt-3">
					<c:forEach items="${noticeList}" var="nl" varStatus="i">
						
						<div class="notice notice-lg" id="rmv${nl.no}" onclick="location.href='${nl.url}'">
							<span> <img src="${nl.phot}" alt="${nl.phot}" width="100px" height="100px">
							</span> <span> <strong>[${nl.type}]${nl.titl}</strong> ${nl.conts}
							</span> <span style="float: right; cursor: pointer;" onclick="del(${nl.no})"><i class="fas fa-trash-alt"></i> </span>
						</div>

					</c:forEach>
				</div>
			</div>
		</div>
		
	</div>
	<footer>
            <div class="col px-0">
                <jsp:include page="../footer.jsp"></jsp:include>
            </div>
        </footer>
</body>
<!-- Bootstrap core JavaScript -->
<script src="/vendor/jquery/jquery.min.js"></script>
<script src="/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script>
var fadeTime = 200;
function del(no){
    removeItem(no)
    $.ajax({
        type : 'POST',
        data : {
            no : no
        },
        url : "notiRemove.do",
        success : location.href="#"
    });
}
function removeItem(no) {
    /* Remove row from DOM and recalc cart total */
    var getRow = document.getElementById("rmv"+no);
    getRow = $(getRow);
    getRow.slideUp(fadeTime, function () {
        getRow.remove();
    });
}
</script>
</html>