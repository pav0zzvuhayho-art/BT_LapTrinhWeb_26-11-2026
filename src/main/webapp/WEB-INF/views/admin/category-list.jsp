<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Category</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<nav class="navbar navbar-expand-lg navbar-dark bg-dark px-4">
    <a class="navbar-brand" href="${pageContext.request.contextPath}/admin/categories">Admin Panel</a>
    <div class="navbar-nav me-auto">
        <a class="nav-link active" href="${pageContext.request.contextPath}/admin/categories">Categories</a>
        <a class="nav-link" href="${pageContext.request.contextPath}/admin/users">Users</a>
        <a class="nav-link" href="${pageContext.request.contextPath}/home">Trang chủ</a>
    </div>
    <span class="text-white me-3">${sessionScope.account.fullname}</span>
    <a class="btn btn-outline-danger btn-sm" href="${pageContext.request.contextPath}/logout">Đăng xuất</a>
</nav>

<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h3>Danh sách Category</h3>
        <a href="${pageContext.request.contextPath}/admin/categories/add" class="btn btn-primary">+ Thêm Category</a>
    </div>

    <form action="${pageContext.request.contextPath}/admin/categories" method="get" class="row g-2 mb-3">
        <div class="col-md-5">
            <input type="text" name="keyword" value="${keyword}" class="form-control" placeholder="Tìm theo tên danh mục...">
        </div>
        <div class="col-auto">
            <button type="submit" class="btn btn-secondary">Tìm kiếm</button>
            <a href="${pageContext.request.contextPath}/admin/categories" class="btn btn-outline-secondary">Xóa lọc</a>
        </div>
    </form>

    <table class="table table-bordered table-hover bg-white align-middle">
        <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Tên danh mục</th>
                <th>Hình ảnh</th>
                <th>Trạng thái</th>
                <th width="160">Thao tác</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="cat" items="${categoryPage.content}">
                <tr>
                    <td>${cat.categoryId}</td>
                    <td>${cat.categoryName}</td>
                   <td>
					<c:if test="${not empty cat.images}">
					        <c:choose>
					            <c:when test="${cat.images.startsWith('http')}">
					                <img src="${cat.images}" alt="" style="height: 45px; width: 45px; object-fit: cover;" class="rounded">
					            </c:when>
					            <c:otherwise>
					                <img src="${pageContext.request.contextPath}/uploads/${cat.images}" alt="" style="height: 45px; width: 45px; object-fit: cover;" class="rounded">
					            </c:otherwise>
					        </c:choose>
					    </c:if>
					</td>	
                    <td>
                        <c:choose>
                            <c:when test="${cat.status == 1}">
                                <span class="badge bg-success">Hoạt động</span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge bg-secondary">Ẩn</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <a href="${pageContext.request.contextPath}/admin/categories/edit/${cat.categoryId}" class="btn btn-warning btn-sm">Sửa</a>
                        <a href="${pageContext.request.contextPath}/admin/categories/delete/${cat.categoryId}"
                           onclick="return confirm('Xóa danh mục này?')" class="btn btn-danger btn-sm">Xóa</a>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty categoryPage.content}">
                <tr><td colspan="5" class="text-center text-muted">Không có dữ liệu</td></tr>
            </c:if>
        </tbody>
    </table>

    <!-- Phân trang -->
    <c:if test="${categoryPage.totalPages > 1}">
        <nav>
            <ul class="pagination justify-content-center">
                <li class="page-item ${categoryPage.first ? 'disabled' : ''}">
                    <a class="page-link" href="?keyword=${keyword}&page=${categoryPage.number - 1}">Trước</a>
                </li>		
                <c:forEach begin="0" end="${categoryPage.totalPages - 1}" var="i">
                    <li class="page-item ${i == categoryPage.number ? 'active' : ''}">
                        <a class="page-link" href="?keyword=${keyword}&page=${i}">${i + 1}</a>
                    </li>
                </c:forEach>
                <li class="page-item ${categoryPage.last ? 'disabled' : ''}">
                    <a class="page-link" href="?keyword=${keyword}&page=${categoryPage.number + 1}">Sau</a>
                </li>
            </ul>
        </nav>
    </c:if>
</div>
</body>
</html>