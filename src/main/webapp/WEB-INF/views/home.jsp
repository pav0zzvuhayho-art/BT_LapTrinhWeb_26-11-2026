<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Trang chủ</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-dark bg-dark px-4">
    <a class="navbar-brand" href="${pageContext.request.contextPath}/home">Spring Boot 4 App</a>
    <div class="d-flex align-items-center">
        <c:choose>
            <c:when test="${not empty sessionScope.account}">
                <span class="text-white me-3">Xin chào, ${sessionScope.account.fullname}</span>
                <c:if test="${sessionScope.account.roleid == 2}">
                    <a class="btn btn-warning btn-sm me-2" href="${pageContext.request.contextPath}/admin/categories">Quản trị Admin</a>
                </c:if>
                <a class="btn btn-outline-danger btn-sm" href="${pageContext.request.contextPath}/logout">Đăng xuất</a>
            </c:when>
            <c:otherwise>
                <a class="btn btn-outline-light btn-sm me-2" href="${pageContext.request.contextPath}/login">Đăng nhập</a>
                <a class="btn btn-primary btn-sm" href="${pageContext.request.contextPath}/register">Đăng ký</a>
            </c:otherwise>
        </c:choose>
    </div>
</nav>
<div class="container mt-4">
    <h2>Trang chủ hệ thống</h2>
</div>
</body>
</html>