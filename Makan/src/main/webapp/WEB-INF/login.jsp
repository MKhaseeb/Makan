<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page isErrorPage="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8">
    <title>قاعتي | تسجيل الدخول / حساب جديد</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        body {
            font-family: 'Cairo', sans-serif;
            background: linear-gradient(135deg, #fffaf0, #fdebd0);
        }
        .golden-btn {
            background: linear-gradient(to right, #e0b973, #ffcb74);
            color: white;
            font-weight: bold;
            transition: all 0.3s ease-in-out;
        }
        .golden-btn:hover {
            background: linear-gradient(to right, #d1a653, #f9b645);
            transform: scale(1.03);
        }
    </style>
</head>
<body class="min-h-screen flex flex-col justify-between">
<jsp:include page="header.jsp" />

<main class="flex-grow flex items-center justify-center p-6">
    <div class="bg-white shadow-2xl rounded-2xl overflow-hidden w-full max-w-6xl grid grid-cols-1 lg:grid-cols-2">
        <div class="hidden lg:block bg-cover bg-center relative" 
             style="background-image: url('https://erem-media-service.azurewebsites.net/api/ResizeImage?image=https%3A%2F%2Fcdn.foochia.com%2Fmedia%2F4e107a74-6d43-465b-bf5b-7112e327880e.webp&height=780&width=780&fit=cover'); min-height: 600px;">
            <div class="absolute inset-0 bg-black bg-opacity-50"></div>
            <div class="relative z-10 flex items-center justify-center h-full px-6 text-center">
                <h2 class="text-white text-4xl font-bold leading-relaxed md:text-5xl lg:text-6xl drop-shadow-lg">
                    مرحبًا بك في <span class="text-yellow-400">قاعتي</span><br/>
                    <span class="text-xl md:text-2xl font-medium text-gray-100 mt-4 block">
                        احجز قاعة أحلامك بسهولة
                    </span>
                </h2>
            </div>
        </div>

        <div class="p-8 space-y-6 w-full max-w-lg mx-auto">
            <div class="flex justify-center space-x-4 mb-6">
                <button id="btn-login" type="button" onclick="showForm('login')" class="golden-btn py-2 px-4 rounded-lg">تسجيل الدخول</button>
                <button id="btn-register" type="button" onclick="showForm('register')" class="py-2 px-4 rounded-lg border border-yellow-400 text-yellow-500">إنشاء حساب</button>
            </div>

            <!-- نموذج التسجيل -->
            <form:form id="form-register" action="/register" method="post" modelAttribute="newUser" class="space-y-4 hidden">
                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div>
                        <form:label path="firstname">الاسم الأول</form:label>
                        <form:input path="firstname" cssClass="form-input"/>
                        <form:errors path="firstname" cssClass="text-red-500 text-sm mt-1"/>
                    </div>
                    <div>
                        <form:label path="lastname">اسم العائلة</form:label>
                        <form:input path="lastname" cssClass="form-input"/>
                        <form:errors path="lastname" cssClass="text-red-500 text-sm mt-1"/>
                    </div>
                </div>
                <div>
                    <form:label path="email">البريد الإلكتروني</form:label>
                    <form:input path="email" cssClass="form-input"/>
                    <form:errors path="email" cssClass="text-red-500 text-sm mt-1"/>
                </div>
                <div>
                    <form:label path="password">كلمة المرور</form:label>
                    <form:input path="password" type="password" cssClass="form-input"/>
                    <form:errors path="password" cssClass="text-red-500 text-sm mt-1"/>
                </div>
                <div>
                    <form:label path="confirm">تأكيد كلمة المرور</form:label>
                    <form:input path="confirm" type="password" cssClass="form-input"/>
                    <form:errors path="confirm" cssClass="text-red-500 text-sm mt-1"/>
                </div>
<div>
    <form:label path="role">نوع المستخدم</form:label>
    <form:select path="role" cssClass="form-input">
        <form:option value="" label="-- اختر نوع المستخدم --" />
        <form:option value="user" label="مستخدم عادي" />
        <form:option value="owner" label="مالك قاعة" />
        <form:option value="admin" label="مشرف" />
    </form:select>
    <form:errors path="role" cssClass="text-red-500 text-sm mt-1"/>
</div>
                
                <button type="submit" class="golden-btn w-full py-2 rounded-lg">تسجيل حساب جديد</button>
            </form:form>

            <!-- نموذج تسجيل الدخول -->
            <form:form id="form-login" action="/loginUser" method="post" modelAttribute="newLogin" class="space-y-4">
                <%-- CSRF token (في حال كنت تستخدم Spring Security) --%>
                <c:if test="${_csrf != null}">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                </c:if>
                <div>
                    <form:label path="email">البريد الإلكتروني</form:label>
                    <form:input path="email" cssClass="form-input"/>
                    <form:errors path="email" cssClass="text-red-500 text-sm mt-1"/>
                </div>
                <div>
                    <form:label path="password">كلمة المرور</form:label>
                    <form:input path="password" type="password" cssClass="form-input"/>
                    <form:errors path="password" cssClass="text-red-500 text-sm mt-1"/>
                </div>
                <button type="submit" class="golden-btn w-full py-2 rounded-lg">دخول</button>
            </form:form>
        </div>
    </div>
</main>

<jsp:include page="footer.jsp" />

<script>
    function showForm(form) {
        const loginForm = document.getElementById("form-login");
        const registerForm = document.getElementById("form-register");
        const btnLogin = document.getElementById("btn-login");
        const btnRegister = document.getElementById("btn-register");

        if (form === "login") {
            loginForm.classList.remove("hidden");
            registerForm.classList.add("hidden");
            btnLogin.classList.add("golden-btn");
            btnRegister.classList.remove("golden-btn");
        } else {
            loginForm.classList.add("hidden");
            registerForm.classList.remove("hidden");
            btnLogin.classList.remove("golden-btn");
            btnRegister.classList.add("golden-btn");
        }
    }
</script>

<style>
    .form-input {
        width: 100%;
        padding: 0.5rem 1rem;
        border: 1px solid #ccc;
        border-radius: 0.5rem;
        outline: none;
        transition: 0.3s;
    }

    .form-input:focus {
        border-color: #e0b973;
        box-shadow: 0 0 0 2px rgba(255, 200, 100, 0.3);
    }
</style>

</body>
</html>
