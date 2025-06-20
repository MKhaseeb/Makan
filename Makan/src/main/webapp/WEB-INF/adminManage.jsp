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
<!-- صندوق الإشعار (Toast) -->
<div id="toast"
     class="fixed bottom-6 left-1/2 -translate-x-1/2 bg-indigo-600 text-white px-6 py-3 rounded-full shadow-lg opacity-0 pointer-events-none transition-opacity duration-300 z-50 text-sm font-medium">
</div>

<body class="bg-gray-50 min-h-screen flex flex-col">
<jsp:include page="navbarlogin.jsp" />


<main class="flex-grow container mx-auto px-4 py-8">
    <h2 class="text-3xl font-bold text-center text-gray-800 mb-10">👥 إضافة مالك أو مشرف جديد</h2>

    <!-- نموذج الإضافة -->
    <div class="max-w-3xl mx-auto bg-white shadow-lg rounded-xl p-8 mb-12 border border-gray-100">
        <form:form action="/admin/owners" method="post" modelAttribute="newUser" class="space-y-6">

            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <div>
                    <form:label path="firstname" cssClass="block mb-1 text-sm font-medium text-gray-700">الاسم الأول</form:label>
                    <form:input path="firstname" cssClass="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-yellow-400"/>
                    <form:errors path="firstname" cssClass="text-red-500 text-sm mt-1"/>
                </div>
                <div>
                    <form:label path="lastname" cssClass="block mb-1 text-sm font-medium text-gray-700">اسم العائلة</form:label>
                    <form:input path="lastname" cssClass="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-yellow-400"/>
                    <form:errors path="lastname" cssClass="text-red-500 text-sm mt-1"/>
                </div>
            </div>

            <div>
                <form:label path="email" cssClass="block mb-1 text-sm font-medium text-gray-700">البريد الإلكتروني</form:label>
                <form:input path="email" cssClass="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-yellow-400"/>
                <form:errors path="email" cssClass="text-red-500 text-sm mt-1"/>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <div>
                    <form:label path="password" cssClass="block mb-1 text-sm font-medium text-gray-700">كلمة المرور</form:label>
                    <form:input path="password" type="password" cssClass="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-yellow-400"/>
                    <form:errors path="password" cssClass="text-red-500 text-sm mt-1"/>
                </div>
                <div>
                    <form:label path="confirm" cssClass="block mb-1 text-sm font-medium text-gray-700">تأكيد كلمة المرور</form:label>
                    <form:input path="confirm" type="password" cssClass="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-yellow-400"/>
                    <form:errors path="confirm" cssClass="text-red-500 text-sm mt-1"/>
                </div>
            </div>

            <div>
                <form:label path="role" cssClass="block mb-1 text-sm font-medium text-gray-700">نوع المستخدم</form:label>
                <form:select path="role" cssClass="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-yellow-400">
                    <form:option value="">-- اختر الدور --</form:option>
                    <form:option value="owner">مالك قاعة</form:option>
                    <form:option value="admin">مشرف</form:option>
                </form:select>
                <form:errors path="role" cssClass="text-red-500 text-sm mt-1"/>
            </div>

          <button type="submit"
    class="w-full text-white font-bold py-3 px-6 rounded-full shadow-lg transition duration-300"
    style="background: linear-gradient(to right, #6366f1, #0ea5e9); box-shadow: 0 4px 15px rgba(14, 165, 233, 0.4);">
    ➕ إضافة المستخدم
</button>

        </form:form>
    </div>

   <!-- جدول المالكين -->
<div class="mb-12">
    <h3 class="text-xl font-semibold text-gray-800 mb-4">📋 جميع المالكين</h3>
    <div class="overflow-x-auto">
        <table class="min-w-full bg-white rounded-lg shadow overflow-hidden">
            <thead class="bg-yellow-100 text-gray-700 text-sm">
                <tr>
                    <th class="py-3 px-4 text-right">الاسم</th>
                    <th class="py-3 px-4 text-right">البريد الإلكتروني</th>
                    <th class="py-3 px-4 text-right">إجراء</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${owners}" var="owner">
                    <tr class="border-b hover:bg-gray-50" data-role="owner" data-id="${owner.id}">
                        <td class="py-3 px-4">${owner.firstname} ${owner.lastname}</td>
                        <td class="py-3 px-4">${owner.email}</td>
                        <td class="py-3 px-4">
                         <button class="delete-btn" data-id="${owner.id}">🗑️ حذف</button>

                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<!-- جدول المشرفين -->
<div>
    <h3 class="text-xl font-semibold text-gray-800 mb-4">👨‍💼 جميع المشرفين</h3>
    <div class="overflow-x-auto">
        <table class="min-w-full bg-white rounded-lg shadow overflow-hidden">
            <thead class="bg-yellow-100 text-gray-700 text-sm">
                <tr>
                    <th class="py-3 px-4 text-right">الاسم</th>
                    <th class="py-3 px-4 text-right">البريد الإلكتروني</th>
                    <th class="py-3 px-4 text-right">إجراء</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${admins}" var="admin">
                    <tr class="border-b hover:bg-gray-50" data-role="admin" data-id="${admin.id}">
                        <td class="py-3 px-4">${admin.firstname} ${admin.lastname}</td>
                        <td class="py-3 px-4">${admin.email}</td>
                        <td class="py-3 px-4">
                            <button class="delete-btn bg-red-100 text-red-600 hover:bg-red-200 px-3 py-1 rounded-full text-sm font-semibold" data-id="${admin.id}">
                                🗑️ حذف
                            </button>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

</main>
<script>
  const csrfToken = document.querySelector('meta[name="_csrf"]').getAttribute('content');
  const csrfHeader = document.querySelector('meta[name="_csrf_header"]').getAttribute('content');

  document.querySelectorAll('.delete-btn').forEach(button => {
    button.addEventListener('click', function(e) {
      e.preventDefault();

      const userId = this.dataset.id;
      // نبحث عن العنصر الأب (tr) لنأخذ الدور منه
      const tr = this.closest('tr');
      const role = tr.getAttribute('data-role');

      if(confirm(`هل أنت متأكد أنك تريد حذف هذا المستخدم من دور (${role})؟`)) {
        const headers = {
          'Content-Type': 'application/json',
          'X-Requested-With': 'XMLHttpRequest'
        };
        if(csrfHeader && csrfHeader.trim() !== '') {
          headers[csrfHeader] = csrfToken;
        }

        fetch(`/admin/delete/${userId}`, {
          method: 'POST',
          headers: headers,
          body: JSON.stringify({ role: role })  // نرسل الدور مع الطلب
        })
        .then(response => response.text())
        .then(text => {
          if(text === 'success') {
            // تحريك حذف الصف بشكل سلس
            tr.style.transition = 'transform 0.4s ease, opacity 0.4s ease';
            tr.style.transform = 'translateX(100%)';
            tr.style.opacity = '0';
            setTimeout(() => {
              tr.remove();
              alert("✅ تم حذف المستخدم بنجاح");
            }, 400);
          } else if(text === 'forbidden') {
            alert("🚫 لا يمكنك حذف هذا المستخدم. دور المستخدم لا يتطابق.");
          } else {
            alert("❌ حدث خطأ في الحذف.");
          }
        })
        .catch(error => {
          console.error('Error:', error);
          alert("حدث خطأ أثناء الحذف.");
        });
      }
    });
  });
</script>

</body>
</html>
