<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8">
    <title>إضافة مستخدم جديد</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50 min-h-screen flex flex-col">

<main class="flex-grow container mx-auto px-4 py-8">
    <h2 class="text-2xl font-bold text-center text-gray-800 mb-6">إضافة مالك أو مشرف جديد</h2>

    <div class="max-w-2xl mx-auto bg-white shadow-md rounded-lg p-6">
        <form:form action="/admin/add" method="post" modelAttribute="newUser" class="space-y-4">

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
</main>

</body>
</html>
