<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8">
    <title>قاعتي | تسجيل الدخول / حساب جديد</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Cairo:wght@400;700&display=swap');
        body {
            font-family: 'Cairo', sans-serif;
            background: linear-gradient(135deg, #f0f4f8, #d9e2ec, #bcccdc);
            color: #333;
        }
        header {
            backdrop-filter: blur(12px);
            background: rgba(255, 255, 255, 0.85);
            border-bottom: 1px solid rgba(0, 0, 0, 0.05);
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
        }
        #site-title {
            color: #0c6efd;
            font-size: 2rem;
            font-weight: 900;
        }
        nav a {
            padding: 8px 14px;
            transition: color 0.3s ease;
            border-radius: 8px;
            color: #444;
            font-weight: 600;
        }
        nav a:hover {
            color: #0c6efd;
            background: rgba(12, 110, 253, 0.1);
        }
        .blue-btn {
            background: #0c6efd;
            color: white;
            font-weight: bold;
            transition: all 0.3s ease-in-out;
        }
        .blue-btn:hover {
            background: #084ecf;
            transform: scale(1.03);
        }
        .form-input {
            width: 100%;
            padding: 0.6rem 1rem;
            border: 1px solid #ccc;
            border-radius: 0.5rem;
            outline: none;
            transition: 0.3s;
        }
        .form-input:focus {
            border-color: #0c6efd;
            box-shadow: 0 0 0 2px rgba(12, 110, 253, 0.2);
        }
        #scrollTopBtn {
            position: fixed;
            bottom: 30px;
            right: 30px;
            background-color: #0c6efd;
            border: none;
            padding: 12px;
            border-radius: 50%;
            cursor: pointer;
            box-shadow: 0 4px 15px rgba(12, 110, 253, 0.5);
            transition: background-color 0.3s ease, transform 0.2s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 1000;
        }
        #scrollTopBtn:hover {
            background-color: #084ecf;
            transform: scale(1.1);
        }
        #scrollTopBtn svg {
            stroke: white;
        }
    </style>
</head>

<body class="min-h-screen flex flex-col justify-between">

<header class="sticky top-0 z-50">
    <div class="max-w-7xl mx-auto px-6 py-4 flex justify-between items-center">
        <h1 id="site-title">قاعتي</h1>
        <nav class="flex items-center gap-6">
            <a href="/">الرئيسية</a>
            <a href="/about">عن الموقع</a>
        </nav>
    </div>
</header>

<main class="flex-grow flex items-center justify-center p-6">
    <div class="bg-white shadow-2xl rounded-2xl overflow-hidden w-full max-w-6xl grid grid-cols-1 lg:grid-cols-2">
        <div class="hidden lg:block bg-cover bg-center relative"
             style="background-image: url('https://cdn.foochia.com/media/4e107a74-6d43-465b-bf5b-7112e327880e.webp'); min-height: 640px;">
            <div class="absolute inset-0 bg-black bg-opacity-40"></div>
            <div class="relative z-10 flex items-center justify-center h-full px-6 text-center">
                <h2 class="text-white text-5xl font-bold leading-relaxed drop-shadow-lg">
                    مرحبًا بك في <span class="text-blue-400">قاعتي</span>
                    <span class="text-xl font-medium text-gray-100 mt-6 block">احجز قاعتك بسهولة</span>
                </h2>
            </div>
        </div>

        <div class="p-8 space-y-6 w-full max-w-lg mx-auto">
            <div class="flex justify-center space-x-4 mb-6">
                <button id="btn-login" type="button" onclick="showForm('login')" class="blue-btn py-2 px-4 rounded-lg">تسجيل الدخول</button>
                <button id="btn-register" type="button" onclick="showForm('register')" class="py-2 px-4 rounded-lg border border-blue-500 text-blue-600">إنشاء حساب</button>
            </div>

            <form:form id="form-register" action="/register" method="post" modelAttribute="newUser" class="space-y-4 hidden">
                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div><form:label path="firstname">الاسم الأول</form:label>
                         <form:input path="firstname" cssClass="form-input"/>
                         <form:errors path="firstname" cssClass="text-red-500 text-sm mt-1"/></div>
                    <div><form:label path="lastname">اسم العائلة</form:label>
                         <form:input path="lastname" cssClass="form-input"/>
                         <form:errors path="lastname" cssClass="text-red-500 text-sm mt-1"/></div>
                </div>
                <div><form:label path="email">البريد الإلكتروني</form:label>
                     <form:input path="email" cssClass="form-input"/>
                     <form:errors path="email" cssClass="text-red-500 text-sm mt-1"/></div>
                <div><form:label path="password">كلمة المرور</form:label>
                     <form:input path="password" type="password" cssClass="form-input"/>
                     <form:errors path="password" cssClass="text-red-500 text-sm mt-1"/></div>
                <div><form:label path="confirm">تأكيد كلمة المرور</form:label>
                     <form:input path="confirm" type="password" cssClass="form-input"/>
                     <form:errors path="confirm" cssClass="text-red-500 text-sm mt-1"/></div>
                <div><form:label path="role">نوع المستخدم</form:label>
                    <form:select path="role" cssClass="form-input">
                        <form:option value="" label="-- اختر --"/>
                        <form:option value="user" label="مستخدم"/>
                        <form:option value="owner" label="مالك قاعة"/>
                        <form:option value="admin" label="مشرف"/>
                    </form:select>
                    <form:errors path="role" cssClass="text-red-500 text-sm mt-1"/></div>
                <button type="submit" class="blue-btn w-full py-2 rounded-lg">تسجيل حساب جديد</button>
            </form:form>

            <form:form id="form-login" action="/loginUser" method="post" modelAttribute="newLogin" class="space-y-4">
                <c:if test="${_csrf != null}">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                </c:if>
                <div><form:label path="email">البريد الإلكتروني</form:label>
                     <form:input path="email" cssClass="form-input"/>
                     <form:errors path="email" cssClass="text-red-500 text-sm mt-1"/></div>
                <div><form:label path="password">كلمة المرور</form:label>
                     <form:input path="password" type="password" cssClass="form-input"/>
                     <form:errors path="password" cssClass="text-red-500 text-sm mt-1"/></div>
                <button type="submit" class="blue-btn w-full py-2 rounded-lg">دخول</button>
            </form:form>
        </div>
    </div>
</main>

<button id="scrollTopBtn" aria-label="العودة لأعلى" title="العودة لأعلى" onclick="window.scrollTo({ top: 0, behavior: 'smooth' });">
    <svg xmlns="http://www.w3.org/2000/svg" fill="none" stroke="white" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round" width="24" height="24" viewBox="0 0 24 24">
        <polyline points="6 15 12 9 18 15"></polyline>
    </svg>
</button>

<script>
    function showForm(form) {
        const loginForm = document.getElementById("form-login");
        const registerForm = document.getElementById("form-register");
        const btnLogin = document.getElementById("btn-login");
        const btnRegister = document.getElementById("btn-register");

        if (form === "login") {
            loginForm.classList.remove("hidden");
            registerForm.classList.add("hidden");
            btnLogin.classList.add("blue-btn");
            btnRegister.classList.remove("blue-btn");
        } else {
            loginForm.classList.add("hidden");
            registerForm.classList.remove("hidden");
            btnLogin.classList.remove("blue-btn");
            btnRegister.classList.add("blue-btn");
        }
    }
</script>

</body>
</html>
