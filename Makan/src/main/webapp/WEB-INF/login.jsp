<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8" />
    <title>قاعتي | تسجيل الدخول / حساب جديد</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Cairo:wght@400;700&display=swap');
        body {
            font-family: 'Cairo', sans-serif;
        }
    </style>
</head>
<body class="min-h-screen bg-gradient-to-tr from-blue-50 via-blue-100 to-blue-200 flex flex-col">

<jsp:include page="header.jsp" />
<div class="relative z-10 flex flex-col items-center justify-center h-full px-8 text-center text-black">
    <h2 class="text-5xl font-extrabold drop-shadow-lg mb-4">
        مرحبًا بك في 
        <span class="bg-gradient-to-r from-indigo-600 to-sky-400 bg-clip-text text-transparent">قاعتي</span>
    </h2>
    <p class="text-xl font-medium text-black px-5">احجز قاعتك بسهولة</p>
</div>


<main class="flex-grow flex items-center justify-center px-6 md:px-12 py-12">
    <div class="bg-white shadow-2xl rounded-2xl w-[90%] max-w-7xl grid lg:grid-cols-2 overflow-hidden transition-all duration-500">

        <!-- الصورة الجانبية -->
        <div id="side-image" class="hidden lg:block bg-cover bg-center relative order-1 lg:order-1 transition-all duration-500"
             style="background-image: url('https://cdn.foochia.com/media/4e107a74-6d43-465b-bf5b-7112e327880e.webp'); min-height: 700px;">
            <div class="absolute inset-0 bg-black bg-opacity-40"></div>
        </div>

        <!-- جانب النماذج -->
        <div id="side-form" class="p-10 flex flex-col justify-center order-2 lg:order-2 transition-all duration-500">

            <!-- أزرار التبديل -->
            <div class="flex justify-center mb-8 space-x-4 rtl:space-x-reverse">
                <button id="btn-login" type="button" onclick="showForm('login')" 
                    class="px-8 py-3 rounded-full font-semibold border-2 border-blue-600 text-blue-600 bg-blue-100 shadow-md transition hover:bg-blue-600 hover:text-white focus:outline-none focus:ring-4 focus:ring-blue-300">
                    تسجيل الدخول
                </button>
                <button id="btn-register" type="button" onclick="showForm('register')" 
                    class="px-8 py-3 rounded-full font-semibold border-2 border-blue-600 text-blue-600 bg-white shadow-md transition hover:bg-blue-600 hover:text-white focus:outline-none focus:ring-4 focus:ring-blue-300">
                    إنشاء حساب
                </button>
            </div>

            <!-- نموذج التسجيل -->
            <form:form id="form-register" action="/register" method="post" modelAttribute="newUser" class="space-y-6 hidden" autocomplete="off">
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div>
                        <form:label path="firstname" class="block mb-1 font-medium text-gray-700">الاسم الأول</form:label>
                        <form:input path="firstname" cssClass="w-full border border-gray-300 rounded-md px-4 py-2 focus:outline-none focus:ring-2 focus:ring-blue-400" />
                        <form:errors path="firstname" cssClass="text-red-600 mt-1 text-sm" />
                    </div>
                    <div>
                        <form:label path="lastname" class="block mb-1 font-medium text-gray-700">اسم العائلة</form:label>
                        <form:input path="lastname" cssClass="w-full border border-gray-300 rounded-md px-4 py-2 focus:outline-none focus:ring-2 focus:ring-blue-400" />
                        <form:errors path="lastname" cssClass="text-red-600 mt-1 text-sm" />
                    </div>
                </div>

                <div>
                    <form:label path="email" class="block mb-1 font-medium text-gray-700">البريد الإلكتروني</form:label>
                    <form:input path="email" cssClass="w-full border border-gray-300 rounded-md px-4 py-2 focus:outline-none focus:ring-2 focus:ring-blue-400" />
                    <form:errors path="email" cssClass="text-red-600 mt-1 text-sm" />
                </div>

                <div>
                    <form:label path="password" class="block mb-1 font-medium text-gray-700">كلمة المرور</form:label>
                    <form:input type="password" path="password" cssClass="w-full border border-gray-300 rounded-md px-4 py-2 focus:outline-none focus:ring-2 focus:ring-blue-400" />
                    <form:errors path="password" cssClass="text-red-600 mt-1 text-sm" />
                </div>

                <div>
                    <form:label path="confirm" class="block mb-1 font-medium text-gray-700">تأكيد كلمة المرور</form:label>
                    <form:input type="password" path="confirm" cssClass="w-full border border-gray-300 rounded-md px-4 py-2 focus:outline-none focus:ring-2 focus:ring-blue-400" />
                    <form:errors path="confirm" cssClass="text-red-600 mt-1 text-sm" />
                </div>

                <div>
                    <form:label path="role" class="block mb-1 font-medium text-gray-700">نوع المستخدم</form:label>
                    <form:select path="role" cssClass="w-full border border-gray-300 rounded-md px-4 py-2 focus:outline-none focus:ring-2 focus:ring-blue-400">
                        <form:option value="" label="-- اختر --" />
                        <form:option value="user" label="مستخدم" />
                        <form:option value="owner" label="مالك قاعة" />
                        <form:option value="admin" label="مشرف" />
                    </form:select>
                    <form:errors path="role" cssClass="text-red-600 mt-1 text-sm" />
                </div>

                <button type="submit" class="w-full py-3 bg-blue-600 text-white font-bold rounded-full shadow-lg hover:bg-blue-700 transition transform hover:scale-105">
                    تسجيل حساب جديد
                </button>
            </form:form>

            <!-- نموذج الدخول -->
            <form:form id="form-login" action="/loginUser" method="post" modelAttribute="newLogin" class="space-y-6" autocomplete="off">
                <c:if test="${_csrf != null}">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                </c:if>
                <div>
                    <form:label path="email" class="block mb-1 font-medium text-gray-700">البريد الإلكتروني</form:label>
                    <form:input path="email" cssClass="w-full border border-gray-300 rounded-md px-4 py-2 focus:outline-none focus:ring-2 focus:ring-blue-400" />
                    <form:errors path="email" cssClass="text-red-600 mt-1 text-sm" />
                </div>
                <div>
                    <form:label path="password" class="block mb-1 font-medium text-gray-700">كلمة المرور</form:label>
                    <form:input type="password" path="password" cssClass="w-full border border-gray-300 rounded-md px-4 py-2 focus:outline-none focus:ring-2 focus:ring-blue-400" />
                    <form:errors path="password" cssClass="text-red-600 mt-1 text-sm" />
                </div>
     <button type="submit" 
        class="w-full py-3 text-white font-bold rounded-full shadow-lg transition transform hover:scale-105"
        style="background: linear-gradient(to right, #6366f1, #0ea5e9); hover:bg-blue-700;">
    دخول
</button>

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
        const sideImage = document.getElementById("side-image");
        const sideForm = document.getElementById("side-form");

        if (form === "login") {
            loginForm.classList.remove("hidden");
            registerForm.classList.add("hidden");
            sideForm.classList.replace("order-2", "order-1");
            sideImage.classList.replace("order-1", "order-2");

            btnLogin.classList.add("bg-blue-600", "text-white");
            btnLogin.classList.remove("bg-white", "text-blue-600");
            btnRegister.classList.remove("bg-blue-600", "text-white");
            btnRegister.classList.add("bg-white", "text-blue-600");
        } else {
            loginForm.classList.add("hidden");
            registerForm.classList.remove("hidden");
            sideForm.classList.replace("order-1", "order-2");
            sideImage.classList.replace("order-2", "order-1");

            btnRegister.classList.add("bg-blue-600", "text-white");
            btnRegister.classList.remove("bg-white", "text-blue-600");
            btnLogin.classList.remove("bg-blue-600", "text-white");
            btnLogin.classList.add("bg-white", "text-blue-600");
        }
    }
</script>

</body>
</html>
