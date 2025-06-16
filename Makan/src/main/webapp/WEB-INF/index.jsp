<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8">
    <title>قاعتي - أفضل القاعات في فلسطين</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.css" />
    <style>
        body {
            font-family: 'Cairo', sans-serif;
            background-color: #fdfcf9;
        }
    </style>
</head>
<body class="text-[#333]">

    <!-- النافبار -->
    <header class="bg-white shadow-md sticky top-0 z-50">
        <div class="max-w-7xl mx-auto px-4 py-3 flex justify-between items-center">
            <h1 class="text-xl font-bold text-[#3b3b3b]" id="site-title">قاعتي</h1>
            <nav class="space-x-4 space-x-reverse flex items-center gap-4">
                <a href="#" class="text-gray-700 hover:text-blue-600" data-i18n="home">الرئيسية</a>
                <a href="#" class="text-gray-700 hover:text-blue-600" data-i18n="about">نبذة عنا</a>
                <a href="#" class="text-gray-700 hover:text-blue-600" data-i18n="terms">الأحكام والشروط</a>
                <a href="#" class="text-gray-700 hover:text-blue-600" data-i18n="payment">طريقة الدفع</a>
                <a href="#" class="bg-blue-600 text-white px-4 py-1 rounded hover:bg-blue-700" data-i18n="register">سجّل الآن</a>
                <button onclick="toggleLanguage()" class="text-gray-700 hover:text-blue-600" id="langToggle">EN</button>
            </nav>
        </div>
    </header>

    <!-- الصورة الرئيسية -->
    <div class="relative w-full h-[600px] bg-center bg-no-repeat bg-cover"
        style="background-image: url('https://ec-news.org/wp-content/uploads/2021/08/%D8%AC%D9%84%D8%B3%D8%A9-%D8%AA%D8%B5%D9%88%D9%8A%D8%B1-%D8%B9%D8%B1%D9%88%D8%B3%D9%8A%D9%86-%D8%AA%D8%AA%D8%AD%D9%88%D9%84-%D8%A5%D9%84%D9%89-%D9%83%D8%A7%D8%B1%D8%AB%D8%A9-%D9%81%D9%8A-%D8%B4%D9%85%D8%A7%D9%84%D9%8A-%D8%A7%D9%84%D8%B9%D8%B1%D8%A7%D9%82.jpg');">
        <div class="absolute inset-0 bg-black bg-opacity-50 flex flex-col justify-center items-center text-center text-white px-6">
            <h1 class="text-2xl md:text-4xl font-semibold mb-2" data-i18n="hero_title">استكشف أفضل القاعات في فلسطين</h1>
            <p class="text-sm md:text-lg" data-i18n="hero_desc">احجز قاعتك بكل سهولة في غزة، رام الله، بيت لحم، نابلس والمزيد</p>
        </div>
    </div>

    <!-- سلايدر -->
    <section class="py-16 px-6 max-w-7xl mx-auto">
        <h2 class="text-3xl font-semibold text-center mb-10" data-i18n="featured_halls">قاعات مميزة</h2>
        <div class="swiper mySwiper">
            <div class="swiper-wrapper">
                <div class="swiper-slide w-full bg-white rounded-xl overflow-hidden shadow">
                    <img src="https://imagesawe.s3.amazonaws.com/styles/max980/s3/albums/2021/09/23/henna_night_in_dubai_3.jpg?itok=v2ut58CD" class="w-full h-72 object-cover">
                    <div class="p-6 text-center">
                        <h3 class="text-2xl font-bold mb-2" data-i18n="hall1_name">قاعة الحمراء</h3>
                        <p class="text-gray-600 mb-4" data-i18n="hall1_info">بيت لحم - السعة: 400 شخص - السعر: 400₪</p>
                        <a href="#" class="inline-block bg-blue-600 text-white px-6 py-2 rounded hover:bg-blue-700" data-i18n="book_now">احجز الآن</a>
                    </div>
                </div>
                <div class="swiper-slide w-full bg-white rounded-xl overflow-hidden shadow">
                    <img src="https://imagesawe.s3.amazonaws.com/styles/max980/s3/listing/2018/12/19/palestine_plaza_hotel_rajallah.jpg?itok=jbM9w5yb" class="w-full h-72 object-cover">
                    <div class="p-6 text-center">
                        <h3 class="text-2xl font-bold mb-2" data-i18n="hall2_name">قاعة أميرة</h3>
                        <p class="text-gray-600 mb-4" data-i18n="hall2_info">رام الله - السعة: 250 شخص - السعر: 260₪</p>
                        <a href="#" class="inline-block bg-blue-600 text-white px-6 py-2 rounded hover:bg-blue-700" data-i18n="book_now">احجز الآن</a>
                    </div>
                </div>
                <div class="swiper-slide w-full bg-white rounded-xl overflow-hidden shadow">
                    <img src="https://www.arabiaweddings.com/sites/default/files/styles/max980/public/companies/images/2017/09/palestine_tower_hall.png?itok=PlD2IYgS" class="w-full h-72 object-cover">
                    <div class="p-6 text-center">
                        <h3 class="text-2xl font-bold mb-2" data-i18n="hall3_name">قاعة الراست</h3>
                        <p class="text-gray-600 mb-4" data-i18n="hall3_info">نابلس - السعة: 4060 شخص - السعر: 250₪</p>
                        <a href="#" class="inline-block bg-blue-600 text-white px-6 py-2 rounded hover:bg-blue-700" data-i18n="book_now">احجز الآن</a>
                    </div>
                </div>
            </div>
            <div class="swiper-pagination mt-6"></div>
        </div>
    </section>

    <!-- الفوتر -->
    <footer class="bg-[#3b3b3b] text-gray-300 py-10 mt-20">
        <div class="max-w-7xl mx-auto px-6 grid grid-cols-1 md:grid-cols-3 gap-8 text-center md:text-right">
            <div>
                <h4 class="text-xl font-semibold mb-4 text-white" data-i18n="site_title">قاعتي</h4>
                <p class="text-sm leading-relaxed" data-i18n="footer_about">منصة رائدة لحجز القاعات في فلسطين...</p>
            </div>
            <div>
                <h4 class="text-xl font-semibold mb-4 text-white" data-i18n="quick_links">روابط سريعة</h4>
                <ul class="space-y-2">
                    <li><a href="#" class="hover:text-blue-400 transition" data-i18n="home">الرئيسية</a></li>
                    <li><a href="#" class="hover:text-blue-400 transition" data-i18n="about">نبذة عنا</a></li>
                    <li><a href="#" class="hover:text-blue-400 transition" data-i18n="terms">الأحكام والشروط</a></li>
                    <li><a href="#" class="hover:text-blue-400 transition" data-i18n="payment">طريقة الدفع</a></li>
                    <li><a href="#" class="hover:text-blue-400 transition" data-i18n="register">سجّل الآن</a></li>
                </ul>
            </div>
            <div>
                <h4 class="text-xl font-semibold mb-4 text-white" data-i18n="contact_us">تواصل معنا</h4>
                <ul class="space-y-2 text-sm">
                    <li>📞 <span data-i18n="phone">هاتف: 00970 525 789</span></li>
                    <li>📧 <span data-i18n="email">البريد الإلكتروني: info@qa3ti.ps</span></li>
                    <li>🏢 <span data-i18n="address">العنوان: فلسطين</span></li>
                </ul>
            </div>
        </div>
        <div class="border-t border-gray-700 mt-10 pt-6 text-center text-xs text-gray-500">
            &copy; 2025 <span data-i18n="site_title">قاعتي</span>. <span data-i18n="rights">جميع الحقوق محفوظة.</span>
        </div>
    </footer>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.js"></script>
    <script>
        let swiper = new Swiper(".mySwiper", {
            slidesPerView: 1,
            spaceBetween: 0,
            loop: true,
            autoplay: {
                delay: 3000,
                disableOnInteraction: false,
                pauseOnMouseEnter: true
            },
            pagination: {
                el: ".swiper-pagination",
                clickable: true,
            },
            rtl: document.documentElement.dir === 'rtl'
        });

        const translations = {
            ar: {
                site_title: "قاعتي", home: "الرئيسية", about: "نبذة عنا", terms: "الأحكام والشروط", payment: "طريقة الدفع", register: "سجّل الآن",
                hero_title: "استكشف أفضل القاعات في فلسطين", hero_desc: "احجز قاعتك بكل سهولة في غزة، رام الله، بيت لحم، نابلس والمزيد",
                featured_halls: "قاعات مميزة", hall1_name: "قاعة الحمراء", hall1_info: "بيت لحم - السعة: 400 شخص - السعر: 400₪",
                hall2_name: "قاعة أميرة", hall2_info: "رام الله - السعة: 250 شخص - السعر: 260₪",
                hall3_name: "قاعة الراست", hall3_info: "نابلس - السعة: 4060 شخص - السعر: 250₪",
                book_now: "احجز الآن", footer_about: "منصة رائدة لحجز القاعات في فلسطين. نقدم لك أفضل الخيارات بسهولة وسرعة.",
                quick_links: "روابط سريعة", contact_us: "تواصل معنا", phone: "هاتف: 00970 525 789", email: "البريد الإلكتروني: info@qa3ti.ps",
                address: "العنوان: فلسطين", rights: "جميع الحقوق محفوظة."
            },
            en: {
                site_title: "Qa3ti", home: "Home", about: "About Us", terms: "Terms & Conditions", payment: "Payment Method", register: "Register",
                hero_title: "Discover the best halls in Palestine", hero_desc: "Book your venue easily in Gaza, Ramallah, Bethlehem, Nablus, and more",
                featured_halls: "Featured Halls", hall1_name: "Al Hamra Hall", hall1_info: "Bethlehem - Capacity: 400 - Price: 400₪",
                hall2_name: "Amira Hall", hall2_info: "Ramallah - Capacity: 250 - Price: 260₪",
                hall3_name: "Al Rast Hall", hall3_info: "Nablus - Capacity: 4060 - Price: 250₪",
                book_now: "Book Now", footer_about: "A leading platform for booking halls in Palestine. We offer top choices with ease.",
                quick_links: "Quick Links", contact_us: "Contact Us", phone: "Phone: 00970 525 789", email: "Email: info@qa3ti.ps",
                address: "Address: Palestine", rights: "All rights reserved."
            }
        };

        let currentLang = 'ar';

        function toggleLanguage() {
            currentLang = currentLang === 'ar' ? 'en' : 'ar';
            document.documentElement.lang = currentLang;
            document.documentElement.dir = currentLang === 'ar' ? 'rtl' : 'ltr';
            document.getElementById("langToggle").textContent = currentLang === 'ar' ? 'EN' : 'AR';

            document.querySelectorAll("[data-i18n]").forEach(el => {
                const key = el.getAttribute("data-i18n");
                el.textContent = translations[currentLang][key] || key;
            });

            // تحديث اتجاه السوايبر
            swiper.changeLanguageDirection(document.documentElement.dir === 'rtl');
        }
    </script>
</body>
</html>
