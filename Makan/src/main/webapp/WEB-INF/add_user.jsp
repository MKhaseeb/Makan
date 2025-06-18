<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8">
    <title>إضافة مستخدم جديد</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen flex items-center justify-center">

    <div class="bg-white shadow-lg rounded-lg p-8 w-full max-w-md">
        <h2 class="text-2xl font-bold text-center text-gray-800 mb-6">إضافة مستخدم جديد</h2>

        <form:form action="/admin/add" method="POST" modelAttribute="newUser" class="space-y-4">

            <div>
                <form:label path="firstname" cssClass="block mb-1 font-medium">الاسم الأول</form:label>
                <form:input path="firstname" cssClass="w-full border rounded px-3 py-2" />
                <form:errors path="firstname" cssClass="text-red-500 text-sm mt-1" />
            </div>

            <div>
                <form:label path="lastname" cssClass="block mb-1 font-medium">الاسم الأخير</form:label>
                <form:input path="lastname" cssClass="w-full border rounded px-3 py-2" />
                <form:errors path="lastname" cssClass="text-red-500 text-sm mt-1" />
            </div>

            <div>
                <form:label path="email" cssClass="block mb-1 font-medium">البريد الإلكتروني</form:label>
                <form:input path="email" cssClass="w-full border rounded px-3 py-2" />
                <form:errors path="email" cssClass="text-red-500 text-sm mt-1" />
            </div>

            <div>
                <form:label path="password" cssClass="block mb-1 font-medium">كلمة المرور</form:label>
                <form:password path="password" cssClass="w-full border rounded px-3 py-2" />
                <form:errors path="password" cssClass="text-red-500 text-sm mt-1" />
            </div>

            <div>
                <form:label path="confirm" cssClass="block mb-1 font-medium">تأكيد كلمة المرور</form:label>
                <form:password path="confirm" cssClass="w-full border rounded px-3 py-2" />
                <form:errors path="confirm" cssClass="text-red-500 text-sm mt-1" />
            </div>

            <div>
                <form:label path="role" cssClass="block mb-1 font-medium">نوع المستخدم</form:label>
                <form:select path="role" cssClass="w-full border rounded px-3 py-2">
                    <form:option value="" label="-- اختر الدور --" />
                    <form:option value="owner" label="مالك قاعة" />
                    <form:option value="admin" label="أدمن" />
                </form:select>
                <form:errors path="role" cssClass="text-red-500 text-sm mt-1" />
            </div>

            <div class="flex justify-between mt-6">
                <a href="/admin/dashboard" class="text-blue-500 hover:underline">العودة إلى لوحة التحكم</a>
                <button type="submit" class="bg-blue-600 hover:bg-blue-700 text-white font-semibold px-4 py-2 rounded">
                    إضافة المستخدم
                </button>
            </div>
        </form:form>
    </div>

</body>
</html>
