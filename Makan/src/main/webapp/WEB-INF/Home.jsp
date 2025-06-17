<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8" />
    <title>قاعتي - بحث القاعات</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        body {
            font-family: 'Cairo', sans-serif;
            background-color: #fdfcf9;
        }
        input, select {
            outline: none;
        }
    </style>
</head>
<body class="min-h-screen flex flex-col">

<jsp:include page="header.jsp" />

<main class="flex-grow">
    <div class="max-w-7xl mx-auto px-6 mt-8">
        <input type="text" name="search" placeholder="🔍 بحث عن قاعة" 
               class="w-full p-3 rounded-md border border-gray-300 focus:ring-2 focus:ring-blue-400" />
    </div>

    <div class="max-w-7xl mx-auto px-6 mt-10 flex gap-8">
        <form action="/halls/filter" method="get" class="w-1/3 bg-white p-6 rounded-xl shadow">
            <h2 class="text-xl font-bold mb-4">فلاتر البحث</h2>

            <label class="block mb-2 text-gray-700">المدينة:</label>
            <select name="city" class="w-full mb-4 p-2 rounded-md border">
                <option value="">اختر مدينة</option>
                <option value="القدس">القدس</option>
                <option value="رام الله">رام الله</option>
                <option value="البيرة">البيرة</option>
                <option value="نابلس">نابلس</option>
                <option value="الخليل">الخليل</option>
                <option value="بيت لحم">بيت لحم</option>
                <option value="طولكرم">طولكرم</option>
                <option value="قلقيلية">قلقيلية</option>
                <option value="سلفيت">سلفيت</option>
                <option value="جنين">جنين</option>
                <option value="أريحا">أريحا</option>
                <option value="طوباس">طوباس</option>
                <option value="غزة">غزة</option>
                <option value="خانيونس">خانيونس</option>
                <option value="رفح">رفح</option>
                <option value="دير البلح">دير البلح</option>
                <option value="جباليا">جباليا</option>
                <option value="الزهراء">الزهراء</option>
                <option value="بيت حانون">بيت حانون</option>
                <option value="بيت لاهيا">بيت لاهيا</option>
            </select>

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
=======
            <label class="block mb-2 text-gray-700">القرية:</label>
            <input type="text" name="village" placeholder="مثال: بيتونيا" class="w-full mb-4 p-2 rounded-md border" />

            <label class="block mb-2 text-gray-700">السعر الأقصى:</label>
            <input type="number" name="maxPrice" class="w-full mb-4 p-2 rounded-md border" />

            <label class="block mb-2 text-gray-700">الحد الأدنى للسعة:</label>
            <input type="number" name="minCapacity" class="w-full mb-6 p-2 rounded-md border" />

            <button type="submit" class="w-full bg-blue-600 hover:bg-blue-700 text-white py-2 rounded-md">
                فلترة
            </button>
        </form>

        <div class="w-2/3 grid grid-cols-1 md:grid-cols-2 gap-6">
            <c:forEach var="hall" items="${halls}">
                <div class="bg-white shadow rounded-xl overflow-hidden">
                    <img src="${hall.imageUrl}" alt="${hall.name}" class="w-full h-48 object-cover">
                    <div class="p-4">
                        <h3 class="text-lg font-bold mb-1">${hall.name}</h3>
                        <p class="text-gray-600 mb-1">المدينة: ${hall.city}</p>
                        <p class="text-gray-600 mb-1">القرية: ${hall.village}</p>
                        <p class="text-gray-600 mb-1">السعر: ${hall.price} شيكل</p>
                        <p class="text-gray-600">السعة: ${hall.capacity} شخص</p>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</main>


<jsp:include page="footer.jsp" />

</body>
</html>
