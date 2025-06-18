<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8">
    <title>إضافة مستخدم جديد</title>

    <!-- CSRF tokens for AJAX -->
    <meta name="_csrf" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}"/>

    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50 min-h-screen flex flex-col">
<jsp:include page="navbarlogin.jsp" />


<main class="flex-grow container mx-auto px-4 py-8">
    <h2 class="text-2xl font-bold text-center text-gray-800 mb-6">إضافة مالك أو مشرف جديد</h2>

    <div class="max-w-2xl mx-auto bg-white shadow-md rounded-lg p-6 mb-10">
        <form:form action="/admin/owners" method="post" modelAttribute="newUser" class="space-y-4">

            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                    <form:label path="firstname">الاسم الأول</form:label>
                    <form:input path="firstname" cssClass="form-input"/>
                    <form:errors path="firstname" cssClass="text-red-500 text-sm"/>
                </div>
                <div>
                    <form:label path="lastname">اسم العائلة</form:label>
                    <form:input path="lastname" cssClass="form-input"/>
                    <form:errors path="lastname" cssClass="text-red-500 text-sm"/>
                </div>
            </div>

            <div>
                <form:label path="email">البريد الإلكتروني</form:label>
                <form:input path="email" cssClass="form-input"/>
                <form:errors path="email" cssClass="text-red-500 text-sm"/>
            </div>

            <div>
                <form:label path="password">كلمة المرور</form:label>
                <form:input path="password" type="password" cssClass="form-input"/>
                <form:errors path="password" cssClass="text-red-500 text-sm"/>
            </div>

            <div>
                <form:label path="confirm">تأكيد كلمة المرور</form:label>
                <form:input path="confirm" type="password" cssClass="form-input"/>
                <form:errors path="confirm" cssClass="text-red-500 text-sm"/>
            </div>

            <div>
                <form:label path="role">نوع المستخدم</form:label>
                <form:select path="role" cssClass="form-input">
                    <form:option value="">-- اختر الدور --</form:option>
                    <form:option value="owner">مالك قاعة</form:option>
                    <form:option value="admin">مشرف</form:option>
                </form:select>
                <form:errors path="role" cssClass="text-red-500 text-sm"/>
            </div>

            <button type="submit"
                    class="w-full bg-yellow-500 hover:bg-yellow-600 text-white py-2 px-4 rounded-lg font-semibold">
                إضافة 
            </button>
        </form:form>
    </div>

    <!-- جدول المالكين -->
    <h3 class="text-xl font-semibold mb-2">جميع المالكين</h3>
    <table class="table-auto w-full bg-white shadow rounded-lg mb-10 text-right">
        <thead>
            <tr class="bg-gray-100">
                <th class="p-2">الاسم</th>
                <th class="p-2">البريد الإلكتروني</th>
                <th class="p-2">إجراء</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${owners}" var="owner">
                <tr class="border-b">
                    <td class="p-2">${owner.firstname} ${owner.lastname}</td>
                    <td class="p-2">${owner.email}</td>
                    <td class="p-2">
                        <button 
                            class="delete-btn text-red-500 hover:text-red-700 bg-transparent border-none cursor-pointer"
                            data-id="${owner.id}">
                            حذف
                        </button>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <!-- جدول المشرفين -->
    <h3 class="text-xl font-semibold mb-2">جميع المشرفين</h3>
    <table class="table-auto w-full bg-white shadow rounded-lg text-right">
        <thead>
            <tr class="bg-gray-100">
                <th class="p-2">الاسم</th>
                <th class="p-2">البريد الإلكتروني</th>
                <th class="p-2">إجراء</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${admins}" var="admin">
                <tr class="border-b">
                    <td class="p-2">${admin.firstname} ${admin.lastname}</td>
                    <td class="p-2">${admin.email}</td>
                    <td class="p-2">
                        <button 
                            class="delete-btn text-red-500 hover:text-red-700 bg-transparent border-none cursor-pointer"
                            data-id="${admin.id}">
                            حذف
                        </button>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</main>

<script>
    const csrfToken = document.querySelector('meta[name="_csrf"]').getAttribute('content');
    const csrfHeader = document.querySelector('meta[name="_csrf_header"]').getAttribute('content');

    document.querySelectorAll('.delete-btn').forEach(btn => {
        btn.addEventListener('click', function (e) {
            e.preventDefault(); 

            const userId = this.dataset.id;
            const row = this.closest('tr');

            if (confirm('هل أنت متأكد أنك تريد حذف هذا المستخدم؟')) {
                const headers = {
                    'Content-Type': 'application/json',
                    'X-Requested-With': 'XMLHttpRequest'
                };
                if (csrfHeader && csrfHeader.trim() !== "") {
                    headers[csrfHeader] = csrfToken;
                }

                fetch(`/admin/delete/${userId}`, {
                    method: 'POST',
                    headers: headers
                })
                .then(response => response.text())
                .then(text => {
                    if (text === 'success') {
                        row.remove();
                        alert("تم حذف المستخدم بنجاح.");
                    } else {
                        alert("فشل في الحذف.");
                    }
                })
                .catch(error => {
                    console.error('حدث خطأ:', error);
                    alert("حدث خطأ أثناء الحذف.");
                });
            }
        });
    });
</script>

</body>
</html>
