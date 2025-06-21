<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8" />
    <title>قاعتي - بحث القاعات</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Cairo:wght@400;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Cairo', sans-serif;
            background: linear-gradient(to bottom right, #f3f4f6, #e0f2fe);
        }
        .venue-card:hover {
            transform: translateY(-6px) scale(1.01);
        }
        .venue-card {
            transition: all 0.4s ease;
        }
        @keyframes fade-in-up {
            0% { opacity: 0; transform: translateY(30px); }
            100% { opacity: 1; transform: translateY(0); }
        }
        .fade-in-up {
            animation: fade-in-up 0.8s ease-out both;
        }
    </style>
    <script>
        function filterVenues() {
            const query = document.getElementById("searchInput").value.toLowerCase();
            const cityFilter = document.getElementById("cityFilter").value.toLowerCase();
            const villageFilter = document.getElementById("villageFilter").value.toLowerCase();
            const maxPrice = parseFloat(document.getElementById("maxPriceFilter").value.replace(/,/g, ""));
            const minCapacity = parseInt(document.getElementById("minCapacityFilter").value);

            let visibleCount = 0;
            document.querySelectorAll(".venue-item").forEach(item => {
                const name = item.querySelector(".venue-name").textContent.toLowerCase();
                const city = item.querySelector(".venue-city").textContent.toLowerCase();
                const village = item.querySelector(".venue-village").textContent.toLowerCase();
                const price = parseFloat(item.querySelector(".venue-price")?.textContent.replace(/[^\d]/g, "") || "0");
                const capacity = parseInt(item.querySelector(".venue-capacity")?.textContent.replace(/[^\d]/g, "") || "0");

                const matchesSearch = name.includes(query) || city.includes(query) || village.includes(query);
                const matchesCity = !cityFilter || city.includes(cityFilter);
                const matchesVillage = !villageFilter || village.includes(villageFilter);
                const matchesPrice = isNaN(maxPrice) || price <= maxPrice;
                const matchesCapacity = isNaN(minCapacity) || capacity >= minCapacity;

                const isVisible = matchesSearch && matchesCity && matchesVillage && matchesPrice && matchesCapacity;
                item.style.display = isVisible ? "block" : "none";
                if (isVisible) visibleCount++;
            });

            const noResults = document.getElementById("noResultsMessage");
            if (noResults) noResults.style.display = visibleCount === 0 ? "block" : "none";
        }
    </script>
</head>

<body class="min-h-screen flex flex-col">
        <jsp:include page="navbaruser.jsp" />
       
<main class="flex-grow">
    <div class="text-center py-12">
<div class="text-center py-12">
    <h2 class="text-4xl font-extrabold text-indigo-800">
        مرحبًا بك <span class="text-indigo-600"></span>! 👋
    </h2>
    
    <h1 class="text-5xl font-bold text-indigo-800 mt-4">اكتشف قاعة أحلامك</h1>
    <p class="text-lg text-gray-500 mt-3">✨ قاعات فاخرة للمناسبات الاستثنائية ✨</p>
</div>

    <div class="max-w-screen-xl mx-auto px-10">
        <input id="searchInput" type="text" name="search" placeholder="🔍 بحث عن قاعة"
               class="w-full p-5 rounded-xl border border-gray-300 shadow focus:ring-3 focus:ring-indigo-500 text-lg"
               oninput="filterVenues()" />
    </div>

<div class="max-w-7xl mx-auto px-6 mt-12 flex flex-col lg:flex-row gap-10">

        <!-- الفلاتر -->
        <aside class="w-full lg:w-1/3">
            <div class="sticky top-6 bg-white p-8 rounded-3xl shadow-xl border border-gray-200 space-y-6">
                <h2 class="text-3xl font-bold text-indigo-700 mb-4">🎯 فلاتر البحث</h2>

                <label class="block text-gray-800 font-semibold text-lg">المدينة:</label>
                <select id="cityFilter" class="w-full p-3 rounded-lg border border-gray-300 text-lg" onchange="filterVenues()">
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

                <label class="block text-gray-800 font-semibold text-lg">القرية/البلدة:</label>
                <input type="text" id="villageFilter" placeholder="مثال: بيتونيا"
                       class="w-full p-3 rounded-lg border border-gray-300 text-lg" oninput="filterVenues()" />

                <label class="block text-gray-800 font-semibold text-lg">السعر الأقصى:</label>
                <input type="number" id="maxPriceFilter"
                       class="w-full p-3 rounded-lg border border-gray-300 text-lg" oninput="filterVenues()" />

                <label class="block text-gray-800 font-semibold text-lg">الحد الأدنى للسعة:</label>
                <input type="number" id="minCapacityFilter"
                       class="w-full p-3 rounded-lg border border-gray-300 text-lg" oninput="filterVenues()" />
            </div>
        </aside>

        <!-- القاعات -->
          <section class="w-full flex flex-wrap justify-center gap-10">
    <c:forEach var="venue" items="${venues}">
        <div class="venue-item fade-in-up bg-white rounded-3xl shadow-xl overflow-hidden venue-card w-[7cm]">
            <a href="/halls/view/${venue.id}" class="block">
                <img src="${venue.imageUrl[0]}" alt="${venue.name}" class="w-full h-40 object-cover rounded-t-3xl" />
                <div class="p-4 text-right">
                    <h3 class="text-xl font-bold text-indigo-700 venue-name mb-2">${venue.name}</h3>
                    <p class="text-sm text-gray-700 venue-city">📍 المدينة: ${venue.city}</p>
                    <p class="text-sm text-gray-700 venue-village mb-2">🏡 القرية: ${venue.village}</p>
                    <p class="text-xs text-gray-600 mb-2 truncate">💬 ${venue.description}</p>
                    <p class="text-green-700 font-semibold text-sm venue-price">
                        💰 <fmt:formatNumber value="${venue.pricePerDay}" type="number" maxFractionDigits="0" /> شيكل
                    </p>
                    <p class="text-blue-700 text-sm venue-capacity">👥 ${venue.capacity} شخص</p>
                </div>
            </a>
        </div>
    </c:forEach>
</section>
    </div>


<!-- الشريط الجانبي للحجوزات -->
<div id="bookingSidebar"
     class="hidden fixed top-[5rem] left-0 w-full bg-white z-40 border-t border-b border-gray-200 shadow-md p-6">

  <h2 class="text-2xl font-extrabold mb-6 text-indigo-800 flex items-center gap-2 justify-center">
    📋 حجوزاتك
  </h2>

  <c:if test="${not empty bookings}">
    <div class="flex flex-wrap justify-center gap-6">
      <c:forEach var="booking" items="${bookings}">
        <div class="w-72 bg-gradient-to-br from-white to-indigo-50 border border-indigo-200 shadow rounded-2xl p-5 hover:shadow-md transition">
          <div class="flex flex-col text-right gap-1">
            <h3 class="text-lg font-bold text-indigo-700">🎉 ${booking.venue.name}</h3>
            <p class="text-sm text-gray-600">📍 ${booking.venue.city}، ${booking.venue.village}</p>
            <p class="text-sm text-gray-600">📅 
              <span class="font-medium text-indigo-900">
                <fmt:formatDate value="${booking.eventDateAsDate}" pattern="yyyy-MM-dd" />
              </span>
            </p>
            <a href="/halls/view/${booking.venue.id}" target="_blank"
               class="text-sm mt-2 inline-block text-blue-600 hover:underline">🔎 عرض تفاصيل القاعة</a>
          </div>
        </div>
      </c:forEach>
    </div>
  </c:if>

  <c:if test="${empty bookings}">
    <div class="text-center text-gray-500 mt-8">
      <span class="text-5xl block">😕</span>
      <p class="mt-4 text-lg font-semibold">لا توجد حجوزات حالياً</p>
      <p class="text-sm mt-2">ابدأ بالبحث عن قاعتك المناسبة واحجزها الآن!</p>
    </div>
  </c:if>
</div>


<script>
function toggleSidebar() {
  const sidebar = document.getElementById('bookingSidebar');
  sidebar.classList.toggle('hidden');
}

document.addEventListener('click', function(event) {
  const sidebar = document.getElementById('bookingSidebar');
  const button = document.getElementById('toggleSidebarBtn');

  if (!sidebar.contains(event.target) && event.target !== button && !button.contains(event.target)) {
    sidebar.classList.add('hidden');
  }
});

  // إغلاق الشريط عند الضغط خارج الشريط
  document.addEventListener('click', function(event) {
    const sidebar = document.getElementById('bookingSidebar');
    const button = document.getElementById('toggleSidebarBtn');

    if (!sidebar.contains(event.target) && event.target !== button && !button.contains(event.target)) {
      if (!sidebar.classList.contains('translate-x-full')) {
        sidebar.classList.add('translate-x-full');
        button.innerHTML = '📂 عرض حجوزاتي';
      }
    }
  });
</script>



</main>

<jsp:include page="footer.jsp" />
</body>
</html>
