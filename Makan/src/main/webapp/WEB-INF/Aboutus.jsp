<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>قاعتي - من نحن</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Cairo:wght@400;700&display=swap');
        body {
            font-family: 'Cairo', sans-serif;
        }
    </style>
</head>
<body class="bg-gray-50">

    <!-- تضمين ملف الهيدر -->
    <jsp:include page="header.jsp" />

    <!-- المحتوى الرئيسي -->
    <main class="max-w-5xl mx-auto px-6 py-20 bg-white rounded-lg shadow-md mt-10">
        <h2 class="text-4xl font-extrabold text-center mb-12 text-gray-800" data-i18n="about_us_heading">من نحن</h2>
        <p class="text-lg leading-relaxed mb-14 max-w-3xl mx-auto text-center text-gray-700" data-i18n="about_us_desc">
            قاعتي هي منصة فلسطينية مبتكرة تهدف إلى تسهيل عملية حجز القاعات عبر الإنترنت، في مختلف المدن الفلسطينية مثل غزة، رام الله، نابلس وبيت لحم. نؤمن بأهمية تسهيل التخطيط للمناسبات بأسلوب عصري، ونمنحك القدرة على المقارنة والحجز بسهولة وسرعة دون الحاجة للتنقل.
        </p>

        <div class="grid grid-cols-1 md:grid-cols-3 gap-10 text-center">
            <div class="bg-gray-100 rounded-xl shadow-lg p-8 hover:shadow-xl transition-shadow duration-300">
                <div class="text-6xl mb-6" aria-label="رمز الكأس">🏆</div>
                <h3 class="text-2xl font-semibold mb-3 text-gray-800" data-i18n="feature_quality">أفضل القاعات</h3>
                <p class="text-gray-600 leading-relaxed" data-i18n="feature_quality_desc">
                    نقدم لك نخبة من القاعات ذات التقييمات العالية والمواقع المميزة.
                </p>
            </div>
            <div class="bg-gray-100 rounded-xl shadow-lg p-8 hover:shadow-xl transition-shadow duration-300">
                <div class="text-6xl mb-6" aria-label="رمز الصاعقة">⚡</div>
                <h3 class="text-2xl font-semibold mb-3 text-gray-800" data-i18n="feature_fast">حجز سريع</h3>
                <p class="text-gray-600 leading-relaxed" data-i18n="feature_fast_desc">
                    إجراءات الحجز تتم بسهولة وفي دقائق معدودة.
                </p>
            </div>
            <div class="bg-gray-100 rounded-xl shadow-lg p-8 hover:shadow-xl transition-shadow duration-300">
                <div class="text-6xl mb-6" aria-label="رمز الدعم">💬</div>
                <h3 class="text-2xl font-semibold mb-3 text-gray-800" data-i18n="feature_support">دعم متواصل</h3>
                <p class="text-gray-600 leading-relaxed" data-i18n="feature_support_desc">
                    فريقنا مستعد للإجابة على استفساراتك ومساعدتك في أي وقت.
                </p>
            </div>
        </div>
    </main>

    <!-- تضمين ملف الفوتر -->
    <jsp:include page="footer.jsp" />

</body>
</html>
