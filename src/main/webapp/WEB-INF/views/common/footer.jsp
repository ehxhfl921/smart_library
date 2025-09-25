<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<footer>
	<div class="information">
		<p>⦁ ${info.library_name}</p>
		<p>전화번호 : ${info.tel}</p>
		<p>위치 : ${info.location}</p>
		<p>운영 시간 : ${info.operating_hour}</p>
	</div>
	
	<div class="copyright">
		<p>Copyright &copy; 2025 SMARTLIBRARY. All rights reserved.</p>
	</div>
	
	<div class="policy">
		<a href="${path}/privacyPolicy" target="_blank">개인정보처리방침</a>
	</div>
</footer>
	
</body>
</html>