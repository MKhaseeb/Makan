<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8">
    <title>قاعتي | قائمة القاعات</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        body {
            font-family: 'Cairo', sans-serif;
            background-color: #fef9f0;
        }
        .back-to-top {
            position: fixed;
            bottom: 40px;
            right: 30px;
            background: #fbbf24;
            color: white;
            padding: 10px 15px;
            border-radius: 9999px;
            cursor: pointer;
            display: none;
            z-index: 1000;
        }
        /* لإظهار lazy loading للصور */
        img {
            display: block;
            max-width: 100%;
            height: auto;
            border-radius: 0.5rem;
        }
        /* تصميم مودال */
        .modal-bg {
            background: rgba(0,0,0,0.5);
        }
    </style>
</head>
<body class="min-h-screen flex flex-col">

<!-- الهيدر -->
<header class="bg-yellow-400 p-4 shadow-md flex justify-between items-center">
    <h1 class="text-white font-bold text-2xl">قاعتي</h1>
    <nav>
        <ul class="flex gap-4 text-white">
            <li><a href="#" class="hover:underline">الرئيسية</a></li>
            <li><a href="#" class="hover:underline">القاعات</a></li>
            <li><a href="#" class="hover:underline">اتصل بنا</a></li>
        </ul>
    </nav>
</header>

<!-- البحث والفلترة -->
<section class="p-6 bg-white shadow-md max-w-7xl mx-auto mt-6 rounded-lg">
    <form id="filterForm" class="grid grid-cols-1 md:grid-cols-4 gap-4 items-end">
        <div>
            <label for="search" class="block mb-1 font-semibold">ابحث عن قاعة</label>
            <input type="text" id="search" name="search" placeholder="اسم القاعة أو الكلمة" 
                   class="w-full border border-gray-300 rounded p-2 focus:ring-2 focus:ring-yellow-400" />
        </div>
        <div>
            <label for="city" class="block mb-1 font-semibold">المدينة</label>
            <select id="city" name="city" class="w-full border border-gray-300 rounded p-2 focus:ring-2 focus:ring-yellow-400">
                <option value="">كل المدن</option>
                <option value="غزة">غزة</option>
                <option value="رام الله">رام الله</option>
                <option value="نابلس">نابلس</option>
            </select>
        </div>
        <div>
            <label for="capacity" class="block mb-1 font-semibold">السعة</label>
            <select id="capacity" name="capacity" class="w-full border border-gray-300 rounded p-2 focus:ring-2 focus:ring-yellow-400">
                <option value="">كل السعات</option>
                <option value="50">حتى 50 شخص</option>
                <option value="100">حتى 100 شخص</option>
                <option value="200">حتى 200 شخص</option>
                <option value="500">أكثر من 200 شخص</option>
            </select>
        </div>
        <div>
            <label for="price" class="block mb-1 font-semibold">السعر</label>
            <select id="price" name="price" class="w-full border border-gray-300 rounded p-2 focus:ring-2 focus:ring-yellow-400">
                <option value="">كل الأسعار</option>
                <option value="low">&lt; 500 شيكل</option>
                <option value="medium">500 - 1500 شيكل</option>
                <option value="high">&gt; 1500 شيكل</option>
            </select>
        </div>
        <div class="md:col-span-4 text-center mt-4">
            <button type="button" onclick="filterHalls()" 
                    class="bg-yellow-400 text-white px-6 py-2 rounded font-bold hover:bg-yellow-500 transition">فلترة</button>
        </div>
    </form>
</section>

<!-- قائمة القاعات -->
<section class="max-w-7xl mx-auto mt-10 p-6 grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
    مثال ثابت، يمكن استبداله ببيانات ديناميكية من السيرفلت أو قاعدة بيانات
    <c:set var="halls" value="${pageContext.request.getAttribute("halls")}" />
    
    مثال ثابت للقاعات
    <div class="bg-white rounded-lg shadow-md overflow-hidden" data-city="غزة" data-capacity="100" data-price="medium" data-name="قاعة النخيل">
        <img src="https://cdn.pixabay.com/photo/2017/01/20/00/30/hall-1992690_1280.jpg" alt="قاعة النخيل" loading="lazy" />
        <div class="p-4">
            <h3 class="text-xl font-bold mb-1">قاعة النخيل</h3>
            <p class="text-gray-700 mb-2">المدينة: غزة</p>
            <p class="text-gray-700 mb-2">السعة: 100 شخص</p>
            <p class="text-yellow-600 font-semibold mb-4">السعر: 1200 شيكل</p>
            <button onclick="openModal('hall1')" class="bg-yellow-400 text-white px-4 py-2 rounded hover:bg-yellow-500 transition">احجز الآن</button>
        </div>
    </div>
    <div class="bg-white rounded-lg shadow-md overflow-hidden" data-city="رام الله" data-capacity="50" data-price="low" data-name="قاعة البستان">
        <img src="https://cdn.pixabay.com/photo/2017/01/20/23/01/hall-2001235_1280.jpg" alt="قاعة البستان" loading="lazy" />
        <div class="p-4">
            <h3 class="text-xl font-bold mb-1">قاعة البستان</h3>
            <p class="text-gray-700 mb-2">المدينة: رام الله</p>
            <p class="text-gray-700 mb-2">السعة: 50 شخص</p>
            <p class="text-yellow-600 font-semibold mb-4">السعر: 400 شيكل</p>
            <button onclick="openModal('hall2')" class="bg-yellow-400 text-white px-4 py-2 rounded hover:bg-yellow-500 transition">احجز الآن</button>
        </div>
    </div>
    <div class="bg-white rounded-lg shadow-md overflow-hidden" data-city="نابلس" data-capacity="200" data-price="high" data-name="قاعة السلام">
        <img src="https://cdn.pixabay.com/photo/2017/01/22/19/25/hall-2003510_1280.jpg" alt="قاعة السلام" loading="lazy" />
        <div class="p-4">
            <h3 class="text-xl font-bold mb-1">قاعة السلام</h3>
            <p class="text-gray-700 mb-2">المدينة: نابلس</p>
            <p class="text-gray-700 mb-2">السعة: 200 شخص</p>
            <p class="text-yellow-600 font-semibold mb-4">السعر: 2200 شيكل</p>
            <button onclick="openModal('hall3')" class="bg-yellow-400 text-white px-4 py-2 rounded hover:bg-yellow-500 transition">احجز الآن</button>
        </div>
    </div>
</section>

<!-- المودال الخاص بتفاصيل الحجز -->
<div id="modal" class="fixed inset-0 hidden items-center justify-center modal-bg z-50">
    <div class="bg-white rounded-lg shadow-lg max-w-3xl w-full mx-4 p-6 relative">
        <button onclick="closeModal()" class="absolute top-3 left-3 text-gray-500 hover:text-gray-900 text-2xl font-bold">&times;</button>
        <div id="modal-content" class="space-y-4">
            <!-- المحتوى يتم ملؤه ديناميكياً -->
        </div>
    </div>
</div>

<!-- خريطة Google Maps -->
<section class="max-w-7xl mx-auto mt-10 p-6 bg-white rounded shadow-md">
    <h2 class="text-xl font-bold mb-4">موقع القاعات على الخريطة</h2>
    <div id="map" style="height: 400px; width: 100%; border-radius: 12px;"></div>
</section>

<!-- تقييمات العملاء -->
<section class="max-w-7xl mx-auto mt-10 p-6 bg-white rounded shadow-md">
    <h2 class="text-xl font-bold mb-6">آراء العملاء</h2>
    <div class="space-y-6">
        <div class="p-4 bg-yellow-50 rounded shadow">
            <p class="text-gray-800">"كانت تجربة رائعة، القاعة نظيفة والخدمة ممتازة."</p>
            <p class="font-bold mt-2">- أحمد من غزة</p>
        </div>
        <div class="p-4 bg-yellow-50 rounded shadow">
            <p class="text-gray-800">"الخدمة سريعة والأسعار مناسبة جدًا."</p>
            <p class="font-bold mt-2">- ليلى من رام الله</p>
        </div>
        <div class="p-4 bg-yellow-50 rounded shadow">
            <p class="text-gray-800">"أنصح بحجز قاعة السلام للنشاطات الكبيرة."</p>
            <p class="font-bold mt-2">- سامي من نابلس</p>
        </div>
    </div>
</section>

<!-- زر العودة للأعلى -->
<div id="backToTop" class="back-to-top" onclick="scrollToTop()">⬆</div>

<!-- الفوتر -->
<footer class="bg-yellow-400 text-white p-6 mt-10">
    <div class="max-w-7xl mx-auto flex flex-col md:flex-row justify-between items-center gap-6">
        <div>
            <h3 class="font-bold text-lg mb-2">تابعنا على</h3>
            <div class="flex gap-4 text-white text-2xl">
                <a href="https://facebook.com" target="_blank" aria-label="فيسبوك" class="hover:text-gray-200"><i class="fa-brands fa-facebook"></i>📘</a>
                <a href="https://instagram.com" target="_blank" aria-label="إنستغرام" class="hover:text-gray-200"><i class="fa-brands fa-instagram"></i>📸</a>
                <a href="https://wa.me/1234567890" target="_blank" aria-label="واتساب" class="hover:text-gray-200"><i class="fa-brands fa-whatsapp"></i>📱</a>
            </div>
        </div>
        <div>&copy; 2025 قاعتي. جميع الحقوق محفوظة.</div>
    </div>
</footer>

<!-- Scripts -->
<script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
<script>
    // بيانات القاعات (مؤقتًا، عادة تجلب من السيرفلت)
    const halls = [
        {
            id: 'hall1',
            name: 'قاعة النخيل',
            city: 'غزة',
            capacity: 100,
            price: 1200,
            description: 'قاعة واسعة مجهزة بالكامل تناسب حفلات الأعراس والمؤتمرات.',
            images: [
                'https://cdn.pixabay.com/photo/2017/01/20/00/30/hall-1992690_1280.jpg',
                'https://cdn.pixabay.com/photo/2016/11/18/19/02/hall-1835554_1280.jpg'
            ],
            location: {lat:31.5, lng:34.47},
            reviews: [
                {user: 'محمد', comment: 'خدمة ممتازة والقاعات نظيفة.'},
                {user: 'عائشة', comment: 'أنصح الجميع بحجز هذه القاعة.'}
            ]
        },
        {
            id: 'hall2',
            name: 'قاعة البستان',
            city: 'رام الله',
            capacity: 50,
            price: 400,
            description: 'قاعة صغيرة مناسبة للفعاليات العائلية والاجتماعات.',
            images: [
                'https://cdn.pixabay.com/photo/2017/01/20/23/01/hall-2001235_1280.jpg',
                'https://cdn.pixabay.com/photo/2018/05/21/21/21/hall-3410489_1280.jpg'
            ],
            location: {lat:31.9, lng:35.2},
            reviews: [
                {user: 'سلمان', comment: 'موقع رائع وخدمة سريعة.'}
            ]
        },
        {
            id: 'hall3',
            name: 'قاعة السلام',
            city: 'نابلس',
            capacity: 200,
            price: 2200,
            description: 'قاعة ضخمة تناسب المؤتمرات والفعاليات الكبيرة.',
            images: [
                'https://cdn.pixabay.com/photo/2017/01/22/19/25/hall-2003510_1280.jpg',
                'https://cdn.pixabay.com/photo/2016/11/18/19/02/hall-1835554_1280.jpg'
            ],
            location: {lat:32.22, lng:35.27},
            reviews: [
                {user: 'سامي', comment: 'أنصح بحجزها للمناسبات الكبيرة.'},
                {user: 'نور', comment: 'مكان مثالي وطاقم عمل محترف.'}
            ]
        }
    ];

    // فتح المودال مع عرض تفاصيل القاعة
    function openModal(hallId) {
        const modal = document.getElementById('modal');
        const modalContent = document.getElementById('modal-content');
        const hall = halls.find(h => h.id === hallId);
        if (!hall) return;

        let imagesHtml = hall.images.map(img => `<img src="${img}" alt="${hall.name}" loading="lazy" class="mb-3 rounded max-h-60 mx-auto">`).join('');
        let reviewsHtml = hall.reviews.map(r => `<p class="italic">"${r.comment}"</p><p class="font-bold mb-3">- ${r.user}</p>`).join('');

        modalContent.innerHTML = `
            <h2 class="text-2xl font-bold mb-3">${hall.name}</h2>
            <p class="mb-2">المدينة: <strong>${hall.city}</strong></p>
            <p class="mb-2">السعة: <strong>${hall.capacity} شخص</strong></p>
            <p class="mb-2 text-yellow-600 font-semibold">السعر: ${hall.price} شيكل</p>
            <p class="mb-4">${hall.description}</p>
            <div class="mb-4">${imagesHtml}</div>
            <h3 class="font-bold mb-2">تقييمات العملاء</h3>
            <div class="mb-4">${reviewsHtml}</div>
            <form action="/book" method="post" class="space-y-4">
                <input type="hidden" name="hallId" value="${hall.id}" />
                <div>
                    <label for="name" class="block font-semibold mb-1">الاسم الكامل</label>
                    <input type="text" id="name" name="name" required class="w-full border p-2 rounded focus:ring-2 focus:ring-yellow-400" />
                </div>
                <div>
                    <label for="phone" class="block font-semibold mb-1">رقم الهاتف</label>
                    <input type="tel" id="phone" name="phone" required class="w-full border p-2 rounded focus:ring-2 focus:ring-yellow-400" />
                </div>
                <div>
                    <label for="date" class="block font-semibold mb-1">تاريخ الحجز</label>
                    <input type="date" id="date" name="date" required class="w-full border p-2 rounded focus:ring-2 focus:ring-yellow-400" />
                </div>
                <button type="submit" class="bg-yellow-400 text-white px-6 py-2 rounded font-bold hover:bg-yellow-500 transition">تأكيد الحجز</button>
            </form>
        `;
        modal.classList.remove('hidden');
        modal.classList.add('flex');
    }

    // إغلاق المودال
    function closeModal() {
        const modal = document.getElementById('modal');
        modal.classList.add('hidden');
        modal.classList.remove('flex');
    }

    // زر العودة للأعلى
    const backToTopBtn = document.getElementById('backToTop');
    window.addEventListener('scroll', () => {
        if (window.scrollY > 300) {
            backToTopBtn.style.display = 'block';
        } else {
            backToTopBtn.st
