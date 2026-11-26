<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý User</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<nav class="navbar navbar-expand-lg navbar-dark bg-dark px-4">
    <a class="navbar-brand" href="${pageContext.request.contextPath}/admin/categories">Admin Panel</a>
    <div class="navbar-nav me-auto">
        <a class="nav-link" href="${pageContext.request.contextPath}/admin/categories">Categories</a>
        <a class="nav-link active" href="${pageContext.request.contextPath}/admin/users">Users</a>
        <a class="nav-link" href="${pageContext.request.contextPath}/home">Trang chủ</a>
    </div>
    <span class="text-white me-3">${sessionScope.account.fullname}</span>
    <a class="btn btn-outline-danger btn-sm" href="${pageContext.request.contextPath}/logout">Đăng xuất</a>
</nav>

<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h3>Danh sách User</h3>
        <a href="${pageContext.request.contextPath}/admin/users/add" class="btn btn-primary">+ Thêm User</a>
    </div>

    <form action="${pageContext.request.contextPath}/admin/users" method="get" class="row g-2 mb-3">
        <div class="col-md-5">
            <input type="text" name="keyword" value="${keyword}" class="form-control" placeholder="Tìm theo username hoặc họ tên...">
        </div>
        <div class="col-auto">
            <button type="submit" class="btn btn-secondary">Tìm kiếm</button>
            <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-outline-secondary">Xóa lọc</a>
        </div>
    </form>

    <table class="table table-bordered table-hover bg-white align-middle">
        <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Username</th>
                <th>Họ tên</th>
                <th>Email</th>
                <th>SĐT</th>
                <th>Quyền</th>
                <th>Trạng thái</th>
                <th width="160">Thao tác</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="u" items="${userPage.content}">
                <tr>
                    <td>${u.id}</td>
                    <td>${u.username}</td>
                    <td>${u.fullname}</td>
                    <td>${u.email}</td>
                    <td>${u.phone}</td>
                    <td>
                        <c:choose>
                            <c:when test="${u.roleid == 2}"><span class="badge bg-danger">Admin</span></c:when>
                            <c:otherwise><span class="badge bg-info text-dark">User</span></c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${u.status == 1}"><span class="badge bg-success">Active</span></c:when>
                            <c:otherwise><span class="badge bg-secondary">Locked</span></c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <a href="${pageContext.request.contextPath}/admin/users/edit/${u.id}" class="btn btn-warning btn-sm">Sửa</a>
                        <a href="${pageContext.request.contextPath}/admin/users/delete/${u.id}"
                           onclick="return confirm('Xóa người dùng này?')" class="btn btn-danger btn-sm">Xóa</a>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty userPage.content}">
                <tr><td colspan="8" class="text-center text-muted">Không có dữ liệu</td></tr>
            </c:if>
        </tbody>
    </table>

    <!-- Phân trang -->
    <c:if test="${userPage.totalPages > 1}">
        <nav>
            <ul class="pagination justify-content-center">
                <li class="page-item ${userPage.first ? 'disabled' : ''}">
                    <a class="page-link" href="?keyword=${keyword}&page=${userPage.number - 1}">Trước</a>
                </li>
                <c:forEach begin="0" end="${userPage.totalPages - 1}" var="i">
                    <li class="page-item ${i == userPage.number ? 'active' : ''}">
                        <a class="page-link" href="?keyword=${keyword}&page=${i}">${i + 1}</a>
                    </li>
                </c:forEach>
                <li class="page-item ${userPage.last ? 'disabled' : ''}">
                    <a class="page-link" href="?keyword=${keyword}&page=${userPage.number + 1}">Sau</a>
                </li>
            </ul>
        </nav>
    </c:if>
</div>
</body>
</html>