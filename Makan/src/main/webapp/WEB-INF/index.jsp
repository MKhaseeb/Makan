<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8" />
    <title>قاعتي - وجهتك لحفلات لا تُنسى</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
    <link href="https://fonts.googleapis.com/css2?family=Tajawal:wght@400;500;700&display=swap" rel="stylesheet">
    <style>
    .video-bg {
    position: absolute;
    top: 50%;
    left: 50%;
    width: 400vh; /* 16:9 aspect ratio height-based */
    height: 100vh;
    transform: translate(-50%, -50%);
    pointer-events: none;
    z-index: 0;
    filter: brightness(0.8);
  }
        :root {
            --primary: #7c3aed;
            --secondary: #10b981;
        }
        
        body {
            font-family: 'Tajawal', sans-serif;
            background-color: #fafafa;
        }
        
        .hero-gradient {
            background: linear-gradient(130deg, rgba(124, 58, 237, 0.9) 0%, rgba(16, 185, 129, 0.85) 100%);
        }
        
        .card-hover {
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.075);
        }
        
        .card-hover:hover {
            transform: translateY(-8px);
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
        }
        
        .shadow-soft {
            box-shadow: 0 4px 20px 0 rgba(0, 0, 0, 0.06);
        }
        
        .badge {
            top: 1rem;
            left: 1rem;
        }
        
        .swiper-pagination-bullet-active {
            background-color: var(--primary) !important;
            transform: scale(1.2);
        }
        
        .btn-primary {
            background-color: var(--primary);
            transition: all 0.3s ease;
        }
        
        .btn-primary:hover {
            background-color: #6d28d9;
            transform: translateY(-2px);
        }
        
        .text-gradient {
            background: linear-gradient(90deg, var(--primary), var(--secondary));
            -webkit-background-clip: text;
            background-clip: text;
            -webkit-text-fill-color: transparent;
        }
    </style>
</head>
<body class="text-gray-800">

    <jsp:include page="header.jsp" />

    <main>
        <!-- Hero Section -->
      
<section class="relative h-[85vh] flex items-center justify-center overflow-hidden">
  <div class="absolute inset-0 bg-black/30 z-10"></div>

<iframe class="video-bg"
    src="https://www.youtube.com/embed/RDbhpvdU_88?autoplay=1&mute=1&loop=1&playlist=RDbhpvdU_88&controls=0&showinfo=0&modestbranding=1"
    frameborder="0" allow="autoplay; fullscreen" allowfullscreen>
</iframe>


  <div class="relative z-20 text-center px-6 max-w-6xl mx-auto">
    <h1 class="text-5xl md:text-7xl font-bold text-white mb-6 animate-fadeIn">
      احتفالات <span class="text-gradient">لا تُنسى</span> تبدأ من هنا
    </h1>
    <p class="text-xl md:text-2xl text-white/90 mb-10 max-w-2xl mx-auto leading-relaxed">
      اكتشف أجمل القاعات لجميع المناسبات في جميع أنحاء فلسطين
    </p>
    <div class="flex gap-4 justify-center">
      <a href="/login"  class="px-8 py-4 text-lg font-medium rounded-full text-white shadow-lg inline-block"
   style="background: linear-gradient(to right, #6366f1, #0ea5e9);">
        ابدأ البحث الآن
      </a>
    
    </div>
  </div>
</section>

        <!-- Features Section -->
        <section class="py-20 bg-gray-50">
            <div class="max-w-6xl mx-auto px-6">
                <div class="text-center mb-16">
                    <h2 class="text-4xl font-bold mb-4 text-gradient inline-block">لماذا تختار منصتنا؟</h2>
                    <p class="text-gray-600 max-w-2xl mx-auto text-lg">
                        نحن نوفر لك تجربة حجز فريدة وسهلة لأجمل القاعات
                    </p>
                </div>
                
                <div class="grid md:grid-cols-3 gap-10">
                    <div class="bg-white p-8 rounded-xl shadow-soft flex flex-col items-center text-center card-hover">
                        <div class="w-20 h-20 rounded-full bg-purple-50 flex items-center justify-center mb-6">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-10 w-10 text-purple-600" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 10l18-8-8 18-4-4-6-6z" />
                            </svg>
                        </div>
                        <h3 class="text-xl font-bold mb-3 text-gray-800">قاعات متميزة</h3>
                        <p class="text-gray-600">
                            مجموعتنا من القاعات مختارة بعناية لتلبية توقعاتكم وتلبية جميع متطلباتكم
                        </p>
                    </div>
                    
                    <div class="bg-white p-8 rounded-xl shadow-soft flex flex-col items-center text-center card-hover">
                        <div class="w-20 h-20 rounded-full bg-emerald-50 flex items-center justify-center mb-6">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-10 w-10 text-emerald-600" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                            </svg>
                        </div>
                        <h3 class="text-xl font-bold mb-3 text-gray-800">حجز آمن</h3>
                        <p class="text-gray-600">
                            نظام حجز آمن وسهل مع تأكيد فوري
                        </p>
                    </div>
                    
                    <div class="bg-white p-8 rounded-xl shadow-soft flex flex-col items-center text-center card-hover">
                        <div class="w-20 h-20 rounded-full bg-amber-50 flex items-center justify-center mb-6">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-10 w-10 text-amber-600" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z" />
                            </svg>
                        </div>
                        <h3 class="text-xl font-bold mb-3 text-gray-800">دعم متوفر </h3>
                        <p class="text-gray-600">
                            فريق الدعم متاح على مدار الساعة لمساعدتكم في أي استفسار أو مشكلة
                        </p>
                    </div>
                </div>
            </div>
        </section>

        <!-- Featured Halls -->
        <section class="py-20">
            <div class="max-w-6xl mx-auto px-6">
                <div class="flex justify-between items-center mb-12">
                    <div>
                        <h2 class="text-4xl font-bold text-gradient">القاعات المميزة</h2>
                        <p class="text-gray-600 mt-2">أحدث القاعات المضافة إلى المنصة</p>
                    </div>
                    <a href="#" class="text-purple-600 hover:text-purple-800 font-medium flex items-center gap-2">
                        عرض الكل
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M14 5l7 7m0 0l-7 7m7-7H3" />
                        </svg>
                    </a>
                </div>
                
                <div class="swiper featuredSwiper">
                    <div class="swiper-wrapper pb-12">
                        <!-- Hall 1 -->
                        <div class="swiper-slide">
                            <div class="bg-white rounded-2xl overflow-hidden shadow-soft card-hover">
                                <div class="relative">
                                    <img src="https://images.unsplash.com/photo-1519671482749-fd09be7ccebf?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80" 
                                         alt="قاعة النجوم" 
                                         class="w-full h-64 object-cover">
                                    <div class="absolute badge bg-purple-600 text-white px-3 py-1 rounded-full text-sm font-bold">
                                        الأكثر حجزاً
                                    </div>
                                </div>
                                <div class="p-6">
                                    <div class="flex justify-between items-start mb-3">
                                        <h3 class="text-xl font-bold">قاعة النجوم</h3>
                                        <div class="flex items-center text-amber-400">
                                            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
                                                <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z" />
                                            </svg>
                                            <span class="ml-1 text-gray-800 font-bold">4.8</span>
                                        </div>
                                    </div>
                                    <div class="flex items-center text-gray-500 mb-4">
                                        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-1" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z" />
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 11a3 3 0 11-6 0 3 3 0 016 0z" />
                                        </svg>
                                        غزة, فلسطين
                                    </div>
                                    <div class="flex justify-between items-center">
                                        <span class="text-gray-700 font-bold">السعة: 500 شخص</span>
                                        <span class="text-xl font-bold text-purple-600">20000 ₪</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Hall 2 -->
                        <div class="swiper-slide">
                            <div class="bg-white rounded-2xl overflow-hidden shadow-soft card-hover">
                                <div class="relative">
                                    <img src="https://images.unsplash.com/photo-1584132967334-10e028bd69f7?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80" 
                                         alt="قاعة الزهراء" 
                                         class="w-full h-64 object-cover">
                                    <div class="absolute badge bg-emerald-600 text-white px-3 py-1 rounded-full text-sm font-bold">
                                        جديد
                                    </div>
                                </div>
                                <div class="p-6">
                                    <div class="flex justify-between items-start mb-3">
                                        <h3 class="text-xl font-bold">قاعة الزهراء</h3>
                                        <div class="flex items-center text-amber-400">
                                            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
                                                <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z" />
                                            </svg>
                                            <span class="ml-1 text-gray-800 font-bold">4.7</span>
                                        </div>
                                    </div>
                                    <div class="flex items-center text-gray-500 mb-4">
                                        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-1" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z" />
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 11a3 3 0 11-6 0 3 3 0 016 0z" />
                                        </svg>
                                        رام الله, فلسطين
                                    </div>
                                    <div class="flex justify-between items-center">
                                        <span class="text-gray-700 font-bold">السعة: 350 شخص</span>
                                        <span class="text-xl font-bold text-purple-600">25000 ₪</span>
                                    </div>
                                </div>

                            </div>
                        </div>
                        
                        <!-- Hall 3 -->
                        <div class="swiper-slide">
                            <div class="bg-white rounded-2xl overflow-hidden shadow-soft card-hover">
                                <div class="relative">
                                    <img src="https://images.unsplash.com/photo-1556740720-776b84291f8e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1171&q=80" 
                                         alt="قاعة الياسمين" 
                                         class="w-full h-64 object-cover">
                                    <div class="absolute badge bg-purple-600 text-white px-3 py-1 rounded-full text-sm font-bold">
                                        متميزة
                                    </div>
                                </div>
                                <div class="p-6">
                                    <div class="flex justify-between items-start mb-3">
                                        <h3 class="text-xl font-bold">قاعة الياسمين</h3>
                                        <div class="flex items-center text-amber-400">
                                            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
                                                <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z" />
                                            </svg>
                                            <span class="ml-1 text-gray-800 font-bold">4.9</span>
                                        </div>
                                    </div>
                                    <div class="flex items-center text-gray-500 mb-4">
                                        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-1" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z" />
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 11a3 3 0 11-6 0 3 3 0 016 0z" />
                                        </svg>
                                        بيت لحم, فلسطين
                                    </div>
                                    <div class="flex justify-between items-center">
                                        <span class="text-gray-700 font-bold">السعة: 600 شخص</span>
                                        <span class="text-xl font-bold text-purple-600">19000 ₪</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Hall 4 -->
                        <div class="swiper-slide">
                            <div class="bg-white rounded-2xl overflow-hidden shadow-soft card-hover">
                                <div class="relative">
                                    <img src="https://images.unsplash.com/photo-1519671482749-fd09be7ccebf?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80" 
                                         alt="قاعة الامتياز" 
                                         class="w-full h-64 object-cover">
                                </div>
                                <div class="p-6">
                                    <div class="flex justify-between items-start mb-3">
                                        <h3 class="text-xl font-bold">قاعة الامتياز</h3>
                                        <div class="flex items-center text-amber-400">
                                            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
                                                <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c].3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z" />
                                            </svg>
                                            <span class="ml-1 text-gray-800 font-bold">4.6</span>
                                        </div>
                                    </div>
                                    <div class="flex items-center text-gray-500 mb-4">
                                        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-1" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z" />
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 11a3 3 0 11-6 0 3 3 0 016 0z" />
                                        </svg>
                                        نابلس, فلسطين
                                    </div>
                                    <div class="flex justify-between items-center">
                                        <span class="text-gray-700 font-bold">السعة: 400 شخص</span>
                                        <span class="text-xl font-bold text-purple-600">15000 ₪</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="swiper-pagination mt-6"></div>
                </div>
<div class="px-6 pb-6">
  <a href="#" 
     class="w-full block text-center py-3 rounded-lg font-medium text-white shadow-md bg-gradient-to-r from-indigo-500 via-blue-500 to-cyan-500 hover:brightness-110 transition">
    المزيد ....
  </a>
</div>


            </div>
        </section>

        <!-- Testimonials -->
        <section class="py-20 bg-gradient-to-r from-purple-50 to-indigo-50">
            <div class="max-w-6xl mx-auto px-6">
                <div class="text-center mb-16">
                    <h2 class="text-4xl font-bold mb-4 text-gradient inline-block">آراء عملائنا</h2>
                    <p class="text-gray-600 max-w-2xl mx-auto text-lg">
                        ما يقوله عملاؤنا السعداء عن تجربتهم مع منصة قاعتي
                    </p>
                </div>
                
                <div class="swiper testimonialsSwiper">
                    <div class="swiper-wrapper pb-14">
                        <div class="swiper-slide">
                            <div class="bg-white p-8 rounded-xl shadow-soft flex flex-col h-full">
                                <div class="flex items-center mb-6">
                                    <div class="w-16 h-16 rounded-full overflow-hidden mr-4">
                                        <img src="https://randomuser.me/api/portraits/women/32.jpg" alt="آمنة محمد" class="w-full h-full object-cover">
                                    </div>
                                    <div>
                                        <h4 class="font-bold text-lg">آمنة محمد</h4>
                                        <p class="text-purple-600">حفل زفاف</p>
                                    </div>
                                </div>
                                <p class="text-gray-600 mb-6 flex-grow">
                                    ".تجربة رائعة! ساعدني فريق قاعتي في العثور على القاعة المثالية لحفل زفافي. كل التفاصيل كانت كما وعدوا تماماً، وحفلتي كانت أسعد يوم في حياتي"
                                </p>
                                <div class="flex justify-end">
                                    <div class="flex items-center text-amber-400">
                                        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
                                            <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c].3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z" />
                                        </svg>
                                        <span class="ml-1 text-gray-800 font-bold">5.0</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="swiper-slide">
                            <div class="bg-white p-8 rounded-xl shadow-soft flex flex-col h-full">
                                <div class="flex items-center mb-6">
                                    <div class="w-16 h-16 rounded-full overflow-hidden mr-4">
                                        <img src="https://randomuser.me/api/portraits/men/65.jpg" alt="أحمد سالم" class="w-full h-full object-cover">
                                    </div>
                                    <div>
                                        <h4 class="font-bold text-lg">أحمد سالم</h4>
                                        <p class="text-purple-600">حفل تخرج</p>
                                    </div>
                                </div>
                                <p class="text-gray-600 mb-6 flex-grow">
                                    "استخدمت المنصة لحجز قاعة لحفل تخرجي، كانت الخدمة سريعة وفعالة. القاعة كانت أجمل مما توقعت والتنظيم كان ممتازاً. شكراً لفريق قاعتي!"
                                </p>
                                <div class="flex justify-end">
                                    <div class="flex items-center text-amber-400">
                                        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
                                            <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c].3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z" />
                                        </svg>
                                        <span class="ml-1 text-gray-800 font-bold">4.5</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Testimonial 3 -->
                        <div class="swiper-slide">
                            <div class="bg-white p-8 rounded-xl shadow-soft flex flex-col h-full">
                                <div class="flex items-center mb-6">
                                    <div class="w-16 h-16 rounded-full overflow-hidden mr-4">
                                        <img src="https://randomuser.me/api/portraits/women/75.jpg" alt="سارة خالد" class="w-full h-full object-cover">
                                    </div>
                                    <div>
                                        <h4 class="font-bold text-lg">سارة خالد</h4>
                                        <p class="text-purple-600">حفلة ميلاد</p>
                                    </div>
                                </div>
                                <p class="text-gray-600 mb-6 flex-grow">
                                    "لم أكن أتوقع أن حجز قاعة لابنتي سيصبح بهذه السهولة! كل شيء من البحث إلى الدفع كان سلساً، والقاعة كانت مثالية لاحتفال ميلادها. نوصي بهذه المنصة للجميع."
                                </p>
                                <div class="flex justify-end">
                                    <div class="flex items-center text-amber-400">
                                        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
                                            <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c].3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z" />
                                        </svg>
                                        <span class="ml-1 text-gray-800 font-bold">4.8</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="swiper-pagination mt-2"></div>
                </div>
            </div>
        </section>
    </main>

    <jsp:include page="footer.jsp" />

    <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
    <script>
        // Featured Halls Swiper
        const featuredSwiper = new Swiper(".featuredSwiper", {
            slidesPerView: 1,
            spaceBetween: 20,
            loop: true,
            autoplay: {
                delay: 5000,
                disableOnInteraction: false,
                pauseOnMouseEnter: true,
            },
            pagination: {
                el: ".swiper-pagination",
                clickable: true,
            },
            breakpoints: {
                640: {
                    slidesPerView: 2,
                },
                1024: {
                    slidesPerView: 3,
                },
            },
            rtl: document.documentElement.dir === 'rtl',
        });

        // Testimonials Swiper
        const testimonialsSwiper = new Swiper(".testimonialsSwiper", {
            slidesPerView: 1,
            spaceBetween: 30,
            loop: true,
            autoplay: {
                delay: 6000,
                disableOnInteraction: false,
                pauseOnMouseEnter: true,
            },
            pagination: {
                el: ".swiper-pagination",
                clickable: true,
            },
            breakpoints: {
                768: {
                    slidesPerView: 2,
                },
                1024: {
                    slidesPerView: 3,
                },
            },
            rtl: document.documentElement.dir === 'rtl',
        });
    </script>
</body>
</html>
