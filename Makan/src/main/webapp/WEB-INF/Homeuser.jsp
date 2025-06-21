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
       .star-icon {
  font-size: 1.8rem;
  color: #ccc; /* لون افتراضي رمادي فاتح */
  cursor: pointer;
  transition: color 0.3s ease, text-shadow 0.3s ease;
  user-select: none;
  filter: drop-shadow(0 0 0 transparent);
}

/* النجوم المحددة (التقييم الحالي) */
.star-icon.selected {
  color: #facc15; /* أصفر ذهبي */

}

/* تأثير التمرير بالماوس */
.star-icon.hovered {
  color: #fbbf24; /* أصفر فاتح */
  transform: scale(1.2);
}

/* لما يمر الماوس على المجموعة كلها */
.stars:hover .star-icon {
  color: #fbbf24;
  filter: drop-shadow(0 0 2px #fbbf24);
  transition: color 0.3s ease, transform 0.3s ease;
}

    </style>
</head>


<body class="min-h-screen flex flex-col">
    <jsp:include page="navbaruser.jsp" />

    <main class="flex-grow">
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
                    <!-- إيجاد الحجز المرتبط بهذه القاعة (لو موجود) -->
                    <c:set var="bookingForVenue" value="" />
                    <c:forEach var="booking" items="${bookings}">
                        <c:if test="${booking.venue.id == venue.id}">
                            <c:set var="bookingForVenue" value="${booking.id}" />
                        </c:if>
                    </c:forEach>

                    <div class="venue-item fade-in-up bg-white rounded-3xl shadow-xl overflow-hidden venue-card w-[7cm]"
                         data-id="${venue.id}"
                         data-booking-id="${bookingForVenue}"
                         data-rating="${venue.avgRating != null ? venue.avgRating.intValue() : 0}">

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

                        <!-- قسم التقييم -->
                        <div class="rating text-right flex items-center gap-2 mt-2 px-4 pb-4">
                            <div class="stars" aria-label="تقييم القاعة" role="radiogroup">
                                <button type="button" class="star-icon" data-value="1" aria-label="نجمة 1" tabindex="0">★</button>
                                <button type="button" class="star-icon" data-value="2" aria-label="نجمة 2" tabindex="-1">★</button>
                                <button type="button" class="star-icon" data-value="3" aria-label="نجمة 3" tabindex="-1">★</button>
                                <button type="button" class="star-icon" data-value="4" aria-label="نجمة 4" tabindex="-1">★</button>
                                <button type="button" class="star-icon" data-value="5" aria-label="نجمة 5" tabindex="-1">★</button>
                            </div>

                            
                        </div>
<p class="text-yellow-500 text-sm mt-1">
  ⭐ متوسط التقييم:
  <fmt:formatNumber value="${venue.avgRating}" type="number" maxFractionDigits="1" />
</p>
                    </div>
                </c:forEach>                

            </section>
        </div>

        <div id="noResultsMessage" class="text-center mt-12 text-gray-500 text-lg" style="display:none;">
            لم يتم العثور على قاعات تطابق البحث.
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
        <div id="messageModal" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 hidden">
  <div class="bg-white rounded-xl shadow-lg max-w-md w-11/12 p-6 text-center">
    <p id="modalMessage" class="text-lg text-gray-800 mb-6"></p>
    <button id="modalOkBtn" class="px-6 py-2 bg-indigo-600 text-white rounded-lg hover:bg-indigo-700 transition">
      موافق
    </button>
  </div>
</div>

   <!-- مودال رسالة عام -->
<div id="messageModal" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 hidden">
  <div class="bg-white rounded-xl shadow-lg max-w-md w-11/12 p-6 text-center">
    <p id="modalMessage" class="text-lg text-gray-800 mb-6"></p>
    <button id="modalOkBtn" class="px-6 py-2 bg-indigo-600 text-white rounded-lg hover:bg-indigo-700 transition">
      موافق
    </button>
  </div>
</div>

<script>
  // تمرير userId من السيرفر (لو متوفر)
  const currentUserId = ${user != null ? user.id : 'null'};

  // دالة التصفية (تملأها بنفس كود التصفية عندك)
  function filterVenues() {
    // ... نفس كود التصفية الموجود عندك ...
  }

  // دالة عرض رسالة مودال مع زر موافق
  function showModalMessage(message) {
    const modal = document.getElementById('messageModal');
    const messageEl = document.getElementById('modalMessage');
    const okBtn = document.getElementById('modalOkBtn');

    messageEl.textContent = message;
    modal.classList.remove('hidden');

    function onOk() {
      modal.classList.add('hidden');
      okBtn.removeEventListener('click', onOk);
      location.reload(); // إعادة تحميل الصفحة عند الضغط على موافق
    }

    okBtn.addEventListener('click', onOk);
  }

  document.addEventListener('DOMContentLoaded', () => {
    document.querySelectorAll('.venue-item').forEach(venueItem => {
      const stars = venueItem.querySelector('.stars');
      if (!stars) return;

      const starButtons = stars.querySelectorAll('button.star-icon');
      const ratingDisplay = venueItem.querySelector('.rating-value');
      let currentRating = 0;

      function updateStars(rating) {
        starButtons.forEach((btn, idx) => {
          if (idx < rating) {
            btn.classList.add('selected');
          } else {
            btn.classList.remove('selected');
          }
        });
        if (ratingDisplay) {
          ratingDisplay.textContent = `التقييم: ${rating}`;
        }
      }

      async function sendRatingToServer(venueId, bookingId, rating) {
        if (!currentUserId || currentUserId === 'null') {
          showModalMessage('❌ يجب تسجيل الدخول لتقييم القاعة');
          return;
        }

        try {
          const data = {
            venueId: venueId,
            userId: currentUserId,
            bookingId: bookingId,
            score: rating,
            comment: ''
          };

          const response = await fetch('/api/ratings/add', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(data)
          });

          const contentType = response.headers.get('content-type') || '';

          if (!response.ok) {
            if (contentType.includes('application/json')) {
              const errorJson = await response.json();
              throw new Error(errorJson.error || 'حدث خطأ غير معروف');
            } else {
              const errorText = await response.text();
              throw new Error(errorText || 'استجابة غير صالحة من الخادم');
            }
          }

          if (contentType.includes('application/json')) {
            const responseData = await response.json();
            console.log('تم حفظ التقييم:', responseData);
            showModalMessage('✅ تم حفظ تقييمك بنجاح، شكراً لك!');
          } else {
            showModalMessage('✅ تم حفظ التقييم بنجاح (لكن الاستجابة لم تكن JSON)');
          }

        } catch (error) {
          console.error('خطأ في إرسال التقييم:', error);
          showModalMessage('❌ لا يمكنك التقييم دون حجز القاعة: ' + error.message);
        }
      }

      starButtons.forEach(btn => {
        btn.addEventListener('click', () => {
          currentRating = parseInt(btn.getAttribute('data-value'));
          updateStars(currentRating);

          const venueId = venueItem.getAttribute('data-id');
          const bookingId = venueItem.getAttribute('data-booking-id');
          sendRatingToServer(venueId, bookingId, currentRating);
        });

        btn.addEventListener('mouseenter', () => {
          let hoverValue = parseInt(btn.getAttribute('data-value'));
          starButtons.forEach((b, i) => {
            if (i < hoverValue) {
              b.classList.add('hovered');
            } else {
              b.classList.remove('hovered');
            }
          });
        });

        btn.addEventListener('mouseleave', () => {
          starButtons.forEach(b => b.classList.remove('hovered'));
          updateStars(currentRating);
        });
      });

      const initialRating = parseInt(venueItem.getAttribute('data-rating')) || 0;
      currentRating = initialRating;
      updateStars(currentRating);
    });
  });
  function filterVenues() {
	  const query = document.getElementById("searchInput").value.toLowerCase();
	  const cityFilter = document.getElementById("cityFilter").value.toLowerCase();
	  const villageFilter = document.getElementById("villageFilter").value.toLowerCase();
	  const maxPriceStr = document.getElementById("maxPriceFilter").value;
	  const maxPrice = maxPriceStr ? parseFloat(maxPriceStr) : NaN;
	  const minCapacityStr = document.getElementById("minCapacityFilter").value;
	  const minCapacity = minCapacityStr ? parseInt(minCapacityStr) : NaN;

	  let anyVisible = false;

	  document.querySelectorAll(".venue-item").forEach(item => {
	    const name = item.querySelector(".venue-name")?.textContent.toLowerCase() || "";
	    const city = item.querySelector(".venue-city")?.textContent.toLowerCase() || "";
	    const village = item.querySelector(".venue-village")?.textContent.toLowerCase() || "";
	    const priceText = item.querySelector(".venue-price")?.textContent || "";
	    const price = parseFloat(priceText.replace(/[^\d.]/g, "")) || 0;
	    const capacityText = item.querySelector(".venue-capacity")?.textContent || "";
	    const capacity = parseInt(capacityText.replace(/[^\d]/g, "")) || 0;

	    const matchesSearch = name.includes(query) || city.includes(query) || village.includes(query);
	    const matchesCity = !cityFilter || city.includes(cityFilter);
	    const matchesVillage = !villageFilter || village.includes(villageFilter);
	    const matchesPrice = isNaN(maxPrice) || price <= maxPrice;
	    const matchesCapacity = isNaN(minCapacity) || capacity >= minCapacity;

	    const show = matchesSearch && matchesCity && matchesVillage && matchesPrice && matchesCapacity;

	    item.style.display = show ? "block" : "none";

	    if (show) anyVisible = true;
	  });

	  // إظهار رسالة "لا توجد نتائج" لو ما في قاعات ظاهرة
	  const noResults = document.getElementById("noResultsMessage");
	  if (noResults) {
	    noResults.style.display = anyVisible ? "none" : "block";
	  }
	}
  
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

</script>


    </main>

    <jsp:include page="footer.jsp" />
</body>
</html>
