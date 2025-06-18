<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8" />
    <title>${venue.name} - قاعتي</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        body {
            font-family: 'Cairo', sans-serif;
            background-color: #fdfcf9;
        }
    </style>

    <!-- FullCalendar CSS -->
    <link href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.7/index.global.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
    
</head>
<body class="min-h-screen flex flex-col">

<jsp:include page="navbarlogin.jsp" />

<main class="flex-grow">

  <!-- Hero Image Slider -->
<section class="w-full h-[600px] overflow-hidden">
  <div class="swiper mySwiper h-full">
    <div class="swiper-wrapper h-full">
      <c:forEach var="img" items="${venue.imageUrl}">
        <div class="swiper-slide h-full">
          <img src="${img}" alt="${venue.name}" class="w-full h-full object-cover" />
        </div>
      </c:forEach>
    </div>
    <!-- Pagination (dots) -->
    <div class="swiper-pagination"></div>

    <!-- Navigation buttons -->
    <div class="swiper-button-next"></div>
    <div class="swiper-button-prev"></div>
  </div>
</section>

    <!-- Venue Title and Action Buttons -->
    <section class="px-6 py-8 max-w-7xl mx-auto">
        <h1 class="text-4xl font-bold text-gray-800 mb-6">${venue.name}</h1>

        <div class="flex flex-wrap gap-4 mb-8">
            <button class="tabBtn bg-blue-600 hover:bg-blue-700 text-white px-6 py-2 rounded-md" data-tab="description">الوصف</button>
            <button class="tabBtn bg-gray-200 hover:bg-gray-300 text-gray-800 px-6 py-2 rounded-md" data-tab="schedule">المواعيد</button>
            <button class="tabBtn bg-gray-200 hover:bg-gray-300 text-gray-800 px-6 py-2 rounded-md" data-tab="pricing">الأسعار</button>
        </div>

        <!-- Description Only -->
        <div id="description" class="tabContent">
            <h2 class="text-xl font-semibold mb-2">الوصف:</h2>
            <p class="text-gray-700 leading-relaxed">${venue.description}</p>
        </div>

        <!-- Schedule Tab with Calendar -->
        <div id="schedule" class="tabContent hidden">
            <h2 class="text-xl font-semibold mb-2">المواعيد المتاحة:</h2>
            
            <!-- Calendar Container -->
            <div id="calendar" class="mt-6 bg-white rounded shadow p-4"></div>
        </div>

        <!-- Pricing Tab -->
        <div id="pricing" class="tabContent hidden">
            <h2 class="text-xl font-semibold mb-2">الأسعار:</h2>
            <p class="text-gray-700 mb-1">السعر اليومي: ${venue.pricePerDay} شيكل</p>
            <p class="text-gray-600">تخصيص الأسعار حسب اليوم أو المناسبة متاح عند الطلب.</p>
        </div>

        <!-- Booking Button -->
        <div class="mt-10">
            <a href="<c:url value='/book?venueId=${venue.id}'/>" 
               class="bg-green-600 hover:bg-green-700 text-white px-10 py-3 rounded-md text-lg shadow">
                احجز الآن
            </a>
        </div>
        
    </section>
</main>

<jsp:include page="footer.jsp" />

<!-- Tabs Script -->
<script>
    const tabBtns = document.querySelectorAll('.tabBtn');
    const tabContents = document.querySelectorAll('.tabContent');

    tabBtns.forEach(btn => {
        btn.addEventListener('click', () => {
            // Reset button styles
            tabBtns.forEach(b => {
                b.classList.remove('bg-blue-600', 'text-white');
                b.classList.add('bg-gray-200', 'text-gray-800');
            });
            btn.classList.remove('bg-gray-200', 'text-gray-800');
            btn.classList.add('bg-blue-600', 'text-white');

            // Show selected tab
            tabContents.forEach(content => content.classList.add('hidden'));
            document.getElementById(btn.getAttribute('data-tab')).classList.remove('hidden');
        });
    });
</script>

<!-- FullCalendar JS -->
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.7/index.global.min.js"></script>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        // Parse booked dates passed from server into JS array
        const bookedDates = [
            <c:forEach var="date" items="${bookedDates}">
                "${date}",
            </c:forEach>
        ];

        const calendarEl = document.getElementById('calendar');
        const calendar = new FullCalendar.Calendar(calendarEl, {
            initialView: 'dayGridMonth',
            height: 500,
            locale: 'ar',
            firstDay: 6, // Saturday as first day (adjust if needed)
            selectable: true,
            events: bookedDates.map(date => ({
                title: 'محجوز',
                start: date,
                display: 'background',
                color: '#fca5a5' // light red background for booked days
            })),
            dateClick: function(info) {
                if (!bookedDates.includes(info.dateStr)) {
                    // Redirect to booking page with date query param
                    window.location.href = '/booking/${venue.id}?date=' + info.dateStr;
                } else {
                    alert('هذا التاريخ محجوز بالفعل.');
                }
            }
        });

        calendar.render();
    });
</script>

<script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>

<script>
  const swiper = new Swiper(".mySwiper", {
    loop: true,
    pagination: {
      el: ".swiper-pagination",
      clickable: true,
    },
    navigation: {
      nextEl: ".swiper-button-next",
      prevEl: ".swiper-button-prev",
    },
    autoplay: {
      delay: 4000,
      disableOnInteraction: false,
    },
  });
</script>

</body>
</html>
