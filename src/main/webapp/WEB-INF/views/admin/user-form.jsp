<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>${user.id == null ? 'Thêm' : 'Sửa'} User</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5" style="max-width: 550px;">
    <div class="card shadow-sm p-4">
        <h4 class="mb-3">${user.id == null ? 'Thêm mới' : 'Cập nhật'} User</h4>
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>
        <form action="${pageContext.request.contextPath}/admin/users/save" method="post">
            <input type="hidden" name="id" value="${user.id}">
            <div class="mb-2">
                <label class="form-label">Username</label>
                <input type="text" name="username" value="${user.username}" class="form-control" required>
            </div>
            <div class="mb-2">
                <label class="form-label">Mật khẩu ${user.id != null ? '(Để trống nếu không đổi)' : ''}</label>
                <input type="password" name="password" class="form-control" ${user.id == null ? 'required' : ''}>
            </div>
            <div class="mb-2">
                <label class="form-label">Họ tên</label>
                <input type="text" name="fullname" value="${user.fullname}" class="form-control" required>
            </div>
            <div class="mb-2">
                <label class="form-label">Email</label>
                <input type="email" name="email" value="${user.email}" class="form-control" required>
            </div>
            <div class="mb-2">
                <label class="form-label">Số điện thoại</label>
                <input type="text" name="phone" value="${user.phone}" class="form-control">
            </div>
            <div class="row mb-3">
                <div class="col">
                    <label class="form-label">Quyền</label>
                    <select name="roleid" class="form-select">
                        <option value="1" ${user.roleid == 1 ? 'selected' : ''}>User</option>
                        <option value="2" ${user.roleid == 2 ? 'selected' : ''}>Admin</option>
                    </select>
                </div>
                <div class="col">
                    <label class="form-label">Trạng thái</label>
                    <select name="status" class="form-select">
                        <option value="1" ${user.status == 1 ? 'selected' : ''}>Active</option>
                        <option value="0" ${user.status == 0 ? 'selected' : ''}>Locked</option>
                    </select>
                </div>
            </div>
            <button type="submit" class="btn btn-primary">Lưu lại</button>
            <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-secondary">Quay lại</a>
        </form>
    </div>
</div>
</body>
</html>	