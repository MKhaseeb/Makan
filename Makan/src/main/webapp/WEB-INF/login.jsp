<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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

        <!-- النماذج -->
        <div class="p-8 md:p-12 bg-white">
            <div class="flex justify-center gap-4 mb-8">
                <button onclick="showForm('login')" id="btn-login" class="golden-btn px-6 py-2 rounded-full shadow-md">تسجيل الدخول</button>
                <button onclick="showForm('register')" id="btn-register" class="px-6 py-2 rounded-full border border-yellow-500 text-yellow-700 hover:bg-yellow-50 transition">إنشاء حساب</button>
            </div>

            <!-- نموذج الدخول -->
            <form id="form-login" action="/login" method="post" class="space-y-4">
                <div>
                    <label class="block text-sm font-semibold mb-1">البريد الإلكتروني</label>
                    <input type="email" name="email" class="w-full px-4 py-2 border rounded-lg focus:ring-2 focus:ring-yellow-400" required>
                </div>
                <div>
                    <label class="block text-sm font-semibold mb-1">كلمة المرور</label>
                    <input type="password" name="password" class="w-full px-4 py-2 border rounded-lg focus:ring-2 focus:ring-yellow-400" required>
                </div>
                <button type="submit" class="golden-btn w-full py-2 rounded-lg">دخول</button>
            </form>

            <!-- نموذج التسجيل -->
            <form id="form-register" action="/register" method="post" class="space-y-4 hidden">
                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div>
                        <label class="block text-sm font-semibold mb-1">الاسم الأول</label>
                        <input type="text" name="firstname" class="w-full px-4 py-2 border rounded-lg focus:ring-2 focus:ring-yellow-400" required>
                    </div>
                    <div>
                        <label class="block text-sm font-semibold mb-1">اسم العائلة</label>
                        <input type="text" name="lastname" class="w-full px-4 py-2 border rounded-lg focus:ring-2 focus:ring-yellow-400" required>
                    </div>
                </div>
                <div>
                    <label class="block text-sm font-semibold mb-1">البريد الإلكتروني</label>
                    <input type="email" name="email" class="w-full px-4 py-2 border rounded-lg focus:ring-2 focus:ring-yellow-400" required>
                </div>
                <div>
                    <label class="block text-sm font-semibold mb-1">كلمة المرور</label>
                    <input type="password" name="password" class="w-full px-4 py-2 border rounded-lg focus:ring-2 focus:ring-yellow-400" required>
                </div>
                <div>
                    <label class="block text-sm font-semibold mb-1">تأكيد كلمة المرور</label>
                    <input type="password" name="confirm" class="w-full px-4 py-2 border rounded-lg focus:ring-2 focus:ring-yellow-400" required>
                </div>
                <button type="submit" class="golden-btn w-full py-2 rounded-lg">تسجيل حساب جديد</button>
            </form>
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
</body>
</html>
