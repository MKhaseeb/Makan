<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8" />
    <title>تواصل معنا - قاعتي</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Cairo:wght@400;700&display=swap');
        body {
            font-family: 'Cairo', sans-serif;
            background: #f7f9fc;
            min-height: 100vh;
        }
        /* إضافة تأثير ناعم عند التركيز */
        input:focus, textarea:focus {
            outline: none;
            box-shadow: 0 0 8px rgba(37, 99, 235, 0.6);
            border-color: #2563eb;
            transition: all 0.3s ease;
        }
        /* زر الإرسال */
        button {
            transition: background-color 0.3s ease;
        }
        button:hover {
            background-color: #1e40af;
        }
        /* الأيقونات داخل الحقول */
        .input-icon {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            right: 12px;
            color: #2563eb;
            pointer-events: none;
        }
        /* الحقول مع أيقونات */
        .input-wrapper {
            position: relative;
        }
    </style>
</head>
<body class="text-gray-800">

    <jsp:include page="header.jsp" />

    <main class="max-w-3xl mx-auto p-8 bg-white rounded-lg shadow-lg mt-16 mb-20">
        <h1 class="text-4xl font-extrabold mb-8 text-center text-blue-700">تواصل معنا</h1>
        <p class="text-center mb-10 text-gray-600">
            نحن هنا لمساعدتك! لا تتردد في إرسال استفسارك أو ملاحظاتك عبر النموذج أدناه.
        </p>

        <form id="contactForm" onsubmit="return handleSubmit(event)" novalidate class="space-y-6">
            
            <div class="input-wrapper">
                <input type="text" id="name" name="name" placeholder="الاسم الكامل" required
                       class="w-full border border-gray-300 rounded-md py-3 pr-12 pl-4 text-lg placeholder-gray-400" />
                <svg xmlns="http://www.w3.org/2000/svg" class="input-icon h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                    <path stroke-linecap="round" stroke-linejoin="round"
                          d="M5.121 17.804A11.955 11.955 0 0112 15c2.486 0 4.78.765 6.879 2.067M15 11a3 3 0 11-6 0 3 3 0 016 0z"/>
                </svg>
            </div>

            <div class="input-wrapper">
                <input type="email" id="email" name="email" placeholder="البريد الإلكتروني" required
                       class="w-full border border-gray-300 rounded-md py-3 pr-12 pl-4 text-lg placeholder-gray-400" />
                <svg xmlns="http://www.w3.org/2000/svg" class="input-icon h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                    <path stroke-linecap="round" stroke-linejoin="round"
                          d="M16 12H8m8 0a4 4 0 11-8 0 4 4 0 018 0zM12 14v.01"/>
                </svg>
            </div>

            <div class="input-wrapper">
              <input type="tel" id="phone" name="phone" placeholder="رقم الهاتف" pattern="^(\+972|0)[0-9]{8,9}$" dir="rtl"
       class="w-full border border-gray-300 rounded-md py-3 pr-12 pl-4 text-lg placeholder-gray-400" />

                <svg xmlns="http://www.w3.org/2000/svg" class="input-icon h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                    <path stroke-linecap="round" stroke-linejoin="round"
                          d="M3 5h2l3.5 7-1.5 3h11v-3l-3-5H3z"/>
                </svg>
            </div>

            <div>
                <textarea id="message" name="message" placeholder="رسالتك" rows="6" required
                          class="w-full border border-gray-300 rounded-md p-4 text-lg placeholder-gray-400 resize-none"></textarea>
            </div>

            <button type="submit" class="w-full bg-blue-600 text-white text-xl font-semibold py-3 rounded-md shadow-md hover:bg-blue-700">
                إرسال
            </button>
        </form>
    </main>

    <jsp:include page="footer.jsp" />

    <script>
        function handleSubmit(event) {
            event.preventDefault();

            const form = event.target;

            if (!form.checkValidity()) {
                form.reportValidity();
                return false;
            }

            // هنا يمكنك إضافة إرسال البيانات عبر AJAX أو التعامل مع السيرفر

            alert("تم إرسال الرسالة بنجاح! شكرًا لتواصلك معنا.");
            form.reset();
            return false;
        }
    </script>

</body>
</html>
