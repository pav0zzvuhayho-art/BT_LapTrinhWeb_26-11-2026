<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>${category.categoryId == null ? 'Thêm' : 'Sửa'} Category</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5" style="max-width: 550px;">
    <div class="card shadow-sm p-4">
        <h4 class="mb-3">${category.categoryId == null ? 'Thêm mới' : 'Cập nhật'} Category</h4>
        <form action="${pageContext.request.contextPath}/admin/categories/save" method="post" enctype="multipart/form-data">
            <input type="hidden" name="categoryId" value="${category.categoryId}">
            <div class="mb-3">
                <label class="form-label">Tên danh mục</label>
                <input type="text" name="categoryName" value="${category.categoryName}" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Hình ảnh</label>
                <input type="file" name="imageFile" class="form-control" accept="image/*">
                <c:if test="${not empty category.images}">
                    <div class="mt-2">
                        <small class="text-muted d-block mb-1">Ảnh hiện tại:</small>
                        <c:choose>
                            <c:when test="${category.images.startsWith('http')}">
                                <img src="${category.images}" alt="" style="height: 80px; object-fit: cover;" class="rounded border">
                            </c:when>
                            <c:otherwise>
                                <img src="${pageContext.request.contextPath}/uploads/${category.images}" alt="" style="height: 80px; object-fit: cover;" class="rounded border">
                            </c:otherwise>
                        </c:choose>
                    </div>
                </c:if>
            </div>
            <div class="mb-3">
                <label class="form-label">Trạng thái</label>
                <select name="status" class="form-select">
                    <option value="1" ${category.status == 1 ? 'selected' : ''}>Hoạt động</option>
                    <option value="0" ${category.status == 0 ? 'selected' : ''}>Ẩn</option>
                </select>
            </div>
            <button type="submit" class="btn btn-primary">Lưu lại</button>
            <a href="${pageContext.request.contextPath}/admin/categories" class="btn btn-secondary">Quay lại</a>
        </form>
    </div>
</div>
</body>
</html>