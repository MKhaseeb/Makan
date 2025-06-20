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
        input:focus, textarea:focus {
            outline: none;
            box-shadow: 0 0 8px rgba(37, 99, 235, 0.6);
            border-color: #2563eb;
            transition: all 0.3s ease;
        }
        button {
            transition: background-color 0.3s ease;
        }
        button:hover {
            background-color: #1e40af;
        }
        .input-icon {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            right: 12px;
            color: #2563eb;
            pointer-events: none;
        }
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

        <form id="contactForm" action="/message/send" method="post" class="space-y-6">
            
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
            
            <div class="input-wrapper">
    <input type="date" id="date" name="date"
           class="w-full border border-gray-300 rounded-md py-3 pr-12 pl-4 text-lg text-gray-500 bg-gray-100 cursor-not-allowed"
           readonly />
    <svg xmlns="http://www.w3.org/2000/svg" class="input-icon h-6 w-6" fill="none"
         viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
        <path stroke-linecap="round" stroke-linejoin="round"
              d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z" />
    </svg>
</div>
            

<button type="submit"
    class="w-full text-white text-xl font-semibold py-3 shadow-md hover:brightness-110 transition rounded-full" 
    style="background: linear-gradient(to right, #6366f1, #0ea5e9);">
    إرسال
</button>

        </form>
    </main>

    <!-- Popup Modal -->
    <div id="successPopup" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 hidden">
        <div class="bg-white rounded-lg shadow-lg p-8 text-center max-w-sm">
            <h2 class="text-2xl font-bold text-blue-700 mb-4">تم إرسال الرسالة بنجاح!</h2>
            <p class="text-gray-600 mb-6">شكرًا لتواصلك معنا، سنرد عليك في أقرب وقت.</p>
            <button onclick="redirectHome()"
                    class="bg-blue-600 text-white px-6 py-2 rounded-md text-lg hover:bg-blue-700">
                الرجوع للرئيسية
            </button>
        </div>
    </div>

    <jsp:include page="footer.jsp" />

    <script>
    document.addEventListener("DOMContentLoaded", () => {
        const today = new Date().toISOString().split("T")[0];
        document.getElementById("date").value = today;
    });
        document.getElementById("contactForm").addEventListener("submit", function(event) {
            event.preventDefault();

            const form = event.target;

            if (!form.checkValidity()) {
                form.reportValidity();
                return;
            }

            // إرسال البيانات عبر AJAX بدلاً من الفورم العادي (اختياري)
            const formData = new FormData(form);
            fetch("/message/send", {
                method: "POST",
                body: formData
            }).then(response => {
                if (response.ok) {
                    document.getElementById("successPopup").classList.remove("hidden");
                    form.reset();
                    document.getElementById("date").value = new Date().toISOString().split("T")[0];

                } else {
                    alert("حدث خطأ أثناء الإرسال.");
                }
            });
        });

        function redirectHome() {
            window.location.href = "/";
        }
    </script>

</body>
</html>
