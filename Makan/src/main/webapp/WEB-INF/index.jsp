<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8" />
    <title>قاعتي - أفضل القاعات في فلسطين</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.css" />
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Cairo&family=Poppins:wght@600&display=swap');
        body {
            font-family: 'Cairo', sans-serif;
            background: linear-gradient(135deg, #f0f4f8, #d9e2ec);
            min-height: 100vh;
        }
        .glass-card {
            background: rgba(255 255 255 / 0.4);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            border-radius: 1rem;
            box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.1);
            transition: transform 0.3s ease;
        }
        .glass-card:hover {
            transform: translateY(-10px) scale(1.05);
            box-shadow: 0 15px 40px rgba(31, 38, 135, 0.3);
        }
        /* نص متدرج */
        .gradient-text {
            background: linear-gradient(90deg, #4f46e5, #06b6d4);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        /* أزرار التنقل */
        .swiper-button-next, .swiper-button-prev {
            color: #2563eb;
            filter: drop-shadow(0 0 2px rgba(37, 99, 235, 0.7));
            transition: color 0.3s ease;
        }
        .swiper-button-next:hover, .swiper-button-prev:hover {
            color: #0ea5e9;
        }
    </style>
</head>
<body class="text-gray-800">

    <jsp:include page="header.jsp" />

    <section class="relative w-full h-[600px] bg-center bg-no-repeat bg-cover"
             style="background-image: url('https://ec-news.org/wp-content/uploads/2021/08/%D8%AC%D9%84%D8%B3%D8%A9-%D8%AA%D8%B5%D9%88%D9%8A%D8%B1-%D8%B9%D8%B1%D9%88%D8%B3%D9%8A%D9%86-%D8%AA%D8%AA%D8%AD%D9%88%D9%84-%D8%A5%D9%84%D9%89-%D9%83%D8%A7%D8%B1%D8%AB%D8%A9-%D9%81%D9%8A-%D8%B4%D9%85%D8%A7%D9%84%D9%8A-%D8%A7%D9%84%D8%B9%D8%B1%D8%A7%D9%82.jpg');">
        <div class="absolute inset-0 bg-gradient-to-br from-black/70 to-black/40 flex flex-col justify-center items-center text-center px-6">
            <h1 class="text-4xl md:text-6xl font-extrabold mb-4 gradient-text drop-shadow-lg">استكشف أفضل القاعات في فلسطين</h1>
            <p class="text-lg md:text-2xl text-white max-w-3xl drop-shadow-md">
                احجز قاعتك بكل سهولة في غزة، رام الله، بيت لحم، نابلس والمزيد
            </p>
        </div>
    </section>

    <section class="py-20 px-6 max-w-7xl mx-auto">
        <h2 class="text-4xl font-bold text-center mb-14 gradient-text drop-shadow-md">قاعات مميزة</h2>
        <div class="swiper mySwiper">
            <div class="swiper-wrapper">

                <div class="swiper-slide glass-card overflow-hidden">
                    <img src="https://i0.wp.com/acaciaevent.com/wp-content/uploads/2019/10/449778512_528370682850911_4863657114664468582_n.jpg?fit=1200%2C800&ssl=1"
                         alt="قاعة الحمراء"
                         class="w-full h-[400px] object-cover rounded-t-xl transition-transform duration-500 hover:scale-105" />
                    <div class="p-8 text-center">
                        <h3 class="text-3xl font-semibold mb-3 flex justify-center items-center gap-2">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-7 w-7 text-blue-600" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M5 13l4 4L19 7" />
                            </svg>
                            قاعة الحمراء
                        </h3>
                        <p class="text-gray-700 mb-6 text-lg">بيت لحم - السعة: 400 شخص - السعر: 400₪</p>
                        <a href="#" class="inline-block bg-blue-600 text-white px-8 py-3 rounded-full text-lg font-semibold shadow-lg transition-transform duration-300 hover:scale-105 hover:bg-blue-700">
                            احجز الآن
                        </a>
                    </div>
                </div>

                <div class="swiper-slide glass-card overflow-hidden">
                    <img src="https://elsenusypalace.com/uploads/hall/_4169178_2022-01-12-22-40-08.jpg"
                         alt="قاعة أميرة"
                         class="w-full h-[400px] object-cover rounded-t-xl transition-transform duration-500 hover:scale-105" />
                    <div class="p-8 text-center">
                        <h3 class="text-3xl font-semibold mb-3 flex justify-center items-center gap-2">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-7 w-7 text-blue-600" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M5 13l4 4L19 7" />
                            </svg>
                            قاعة أميرة
                        </h3>
                        <p class="text-gray-700 mb-6 text-lg">رام الله - السعة: 250 شخص - السعر: 260₪</p>
                        <a href="#" class="inline-block bg-blue-600 text-white px-8 py-3 rounded-full text-lg font-semibold shadow-lg transition-transform duration-300 hover:scale-105 hover:bg-blue-700">
                            احجز الآن
                        </a>
                    </div>
                </div>

                <div class="swiper-slide glass-card overflow-hidden">
                    <img src="https://media.gemini.media/img/Original/2023/7/31/2023_7_31_15_10_7_972.jpg"
                         alt="قاعة الراست"
                         class="w-full h-[400px] object-cover rounded-t-xl transition-transform duration-500 hover:scale-105" />
                    <div class="p-8 text-center">
                        <h3 class="text-3xl font-semibold mb-3 flex justify-center items-center gap-2">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-7 w-7 text-blue-600" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M5 13l4 4L19 7" />
                            </svg>
                            قاعة الراست
                        </h3>
                        <p class="text-gray-700 mb-6 text-lg">نابلس - السعة: 4060 شخص - السعر: 250₪</p>
                        <a href="#" class="inline-block bg-blue-600 text-white px-8 py-3 rounded-full text-lg font-semibold shadow-lg transition-transform duration-300 hover:scale-105 hover:bg-blue-700">
                            احجز الآن
                        </a>
                    </div>
                </div>

            </div>

            <!-- أزرار التنقل -->
            <div class="swiper-button-next"></div>
            <div class="swiper-button-prev"></div>

            <!-- نقاط التصفح -->
            <div class="swiper-pagination mt-8"></div>
        </div>
    </section>

    <jsp:include page="footer.jsp" />

    <script src="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.js"></script>
    <script>
        let swiper = new Swiper(".mySwiper", {
            slidesPerView: 1,
            spaceBetween: 30,
            loop: true,
            autoplay: {
                delay: 3500,
                disableOnInteraction: false,
                pauseOnMouseEnter: true,
            },
            pagination: {
                el: ".swiper-pagination",
                clickable: true,
            },
            navigation: {
                nextEl: ".swiper-button-next",
                prevEl: ".swiper-button-prev",
            },
            rtl: document.documentElement.dir === 'rtl',
            effect: 'slide',
        });
    </script>

</body>
</html>
