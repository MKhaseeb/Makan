<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
  <meta charset="UTF-8" />
  <title>احجز قاعتك</title>

  <script src="https://cdn.tailwindcss.com"></script>
  <link href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.7/index.global.min.css" rel="stylesheet" />
  <script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.7/index.global.min.js"></script>

  <script>
    function toggleOtherEventField(value) {
      const otherField = document.getElementById('otherEventDiv');
      otherField.classList.toggle('hidden', value !== 'أخرى');
    }

    document.addEventListener('DOMContentLoaded', function () {
      const bookedDates = [
        <c:forEach var="date" items="${bookedDates}">
          "${date}",
        </c:forEach>
      ];

      let selectedEvent = null;
      const calendarEl = document.getElementById('calendar');
      const hiddenInput = document.getElementById('eventDate');

      const calendar = new FullCalendar.Calendar(calendarEl, {
    	  initialView: 'dayGridMonth',
    	  height: 400,
    	  locale: 'ar',
    	  firstDay: 6,
    	  selectable: true,
    	  validRange: {
    	    start: new Date().toISOString().split('T')[0]  // ⬅️ restrict to today and future
    	  },
    	  events: bookedDates.map(date => ({
    		  title: "محجوز",
    		  start: date,
    		  allDay: true,
    		  color: '#dc2626',       // red background
    		  textColor: '#ffffff',   // white text
    		  display: 'block'
    		})),

    	  dateClick: function (info) {
    	    const dateStr = info.dateStr;
    	    if (bookedDates.includes(dateStr)) {
    	      alert("هذا التاريخ محجوز بالفعل.");
    	      return;
    	    }
    	    if (selectedEvent) selectedEvent.remove();
    	    selectedEvent = calendar.addEvent({
    	      start: dateStr,
    	      allDay: true,
    	      title: "تم التحديد",
    	      display: 'list-item',
    	      textColor: '#15803d'
    	    });
    	    hiddenInput.value = dateStr;
    	  }
    	});

      calendar.render();
    });

    function setRating(value) {
      document.getElementById("ratingValue").value = value;
      for (let i = 1; i <= 5; i++) {
        document.getElementById("star" + i).textContent = i <= value ? "★" : "☆";
      }
    }

    function submitRating() {
      const rating = document.getElementById("ratingValue").value;
      if (rating == 0) {
        alert("من فضلك اختر تقييمًا أولاً ⭐");
        return;
      }
      alert("شكراً لتقييمك بـ " + rating + " نجمة ⭐");
      closeModal();
    }

    function showSuccessModal() {
      document.getElementById("successModal").classList.remove("hidden");
    }

    function closeModal() {
      document.getElementById("successModal").classList.add("hidden");
    }
  </script>
</head>

<body >


<c:choose>
    <c:when test="${user.role == 'admin'}">
    <jsp:include page="navbarlogin.jsp" />
        </c:when>
    <c:otherwise>
<header class="sticky top-0 z-50 backdrop-blur-lg bg-white/70 border-b border-black/10 shadow-md">
  <div class="max-w-7xl mx-auto px-6 py-4 flex justify-between items-center">
    <a href="/owner/dashboard">
      <h1 id="site-title" class="select-none cursor-default text-3xl font-extrabold text-indigo-600">
        قاعتي
      </h1>
    </a>
      <div class="flex items-center gap-6">
      <a href="/owner/dashboard">🏠 الرئيسية</a>
    

    </div>
    <nav class="flex items-center gap-6 font-medium text-gray-700">
      <form action="/venue/logout" method="post">
        <button type="submit"
                class="bg-red-600 hover:bg-red-700 text-white font-bold py-2 px-5 rounded-full shadow transition">
          تسجيل الخروج
        </button>
      </form>
    </nav>
  </div>
</header>

    </c:otherwise>
</c:choose>

<c:if test="${not empty selectedVenue}">
  <div class="p-4 bg-blue-50 rounded mb-4 shadow">
    <h3 class="text-xl font-semibold">قاعتي المختارة:</h3>
    <div class="mt-2">
      <img src="${selectedVenue.imageUrl}" alt="Venue image" class="w-48 h-32 object-cover rounded"/>
      <p>${selectedVenue.name}</p>
    </div>
    <input type="hidden" name="venue.id" value="${selectedVenue.id}" />
  </div>
</c:if>



<div class="max-w-2xl mx-auto bg-white p-8 rounded shadow">
  <h2 class="text-2xl font-bold mb-6 text-center">نموذج حجز القاعة</h2>

  <form:form method="post" action="/book" modelAttribute="newBooking" cssClass="space-y-4">

    <label class="block">
      <span class="text-gray-700">الاسم الكامل:</span>
      <input type="text" readonly value="${user.firstname} ${user.lastname}" class="mt-1 block w-full border p-2 rounded bg-gray-100"/>
    </label>

    <label class="block">
      <span class="text-gray-700">البريد الإلكتروني:</span>
      <input type="email" readonly value="${user.email}" class="mt-1 block w-full border p-2 rounded bg-gray-100"/>
    </label>

    <label class="block">
      <span class="text-gray-700">رقم الهاتف:</span>
      <form:input path="phoneNumber" cssClass="mt-1 block w-full border p-2 rounded" />
      <form:errors path="phoneNumber" cssClass="text-red-600 text-sm mt-1 block" />
    </label>

    <label class="block">
      <span class="text-gray-700">تاريخ الحجز:</span>
      <div id="calendar" class="mt-2 bg-white rounded shadow p-4"></div>
      <form:hidden path="eventDate" id="eventDate" />
      <form:errors path="eventDate" cssClass="text-red-600 text-sm mt-1 block" />
    </label>

    <label class="block">
      <span class="text-gray-700">نوع المناسبة:</span>
      <form:select path="eventType" onchange="toggleOtherEventField(this.value)" cssClass="mt-1 block w-full border p-2 rounded">
        <form:option value="">-- اختر المناسبة --</form:option>
        <form:option value="عرس" />
        <form:option value="خطبة" />
        <form:option value="طلبة" />
        <form:option value="تخرج" />
        <form:option value="أخرى" />
      </form:select>
      <form:errors path="eventType" cssClass="text-red-600 text-sm mt-1 block" />
    </label>

    <div id="otherEventDiv" class="hidden">
      <label class="block">
        <span class="text-gray-700">حدد نوع المناسبة:</span>
        <form:input path="eventType" cssClass="mt-1 block w-full border p-2 rounded"/>
        <form:errors path="eventType" cssClass="text-red-600 text-sm mt-1 block" />
      </label>
    </div>

    <label class="block">
      <span class="text-gray-700">ملاحظات إضافية:</span>
      <form:textarea path="note" rows="3" cssClass="mt-1 block w-full border p-2 rounded"/>
      <form:errors path="note" cssClass="text-red-600 text-sm mt-1 block" />
    </label>

    <input type="hidden" name="venueId" value="${selectedVenue.id}" />

<div class="text-center">
  <button type="submit" class="bg-blue-600 text-white px-6 py-2 rounded hover:bg-blue-700">احجز الآن</button>
</div>


  </form:form>
</div>

<!-- ⭐ Success Modal with Rating ⭐ -->
<div id="successModal" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center hidden z-50">
  <div class="bg-white rounded-lg p-6 max-w-sm w-full text-center">
    <h2 class="text-2xl font-bold mb-4 text-green-600">تم الحجز بنجاح ✅</h2>
    <p class="mb-4">تم تسجيل حجزك وسيتم التواصل معك قريباً.</p>

    <div class="mb-4">
      <p class="mb-2 font-semibold">قيّم تجربتك:</p>
      <div id="ratingStars" class="flex justify-center space-x-1 text-3xl cursor-pointer">
        <span onclick="setRating(1)" id="star1">☆</span>
        <span onclick="setRating(2)" id="star2">☆</span>
        <span onclick="setRating(3)" id="star3">☆</span>
        <span onclick="setRating(4)" id="star4">☆</span>
        <span onclick="setRating(5)" id="star5">☆</span>
      </div>
      <input type="hidden" id="ratingValue" value="0" />
    </div>

    <button onclick="submitRating()" class="bg-green-600 text-white px-4 py-2 rounded hover:bg-green-700 w-full mb-2">إرسال التقييم</button>
    <button onclick="closeModal()" class="bg-gray-300 text-black px-4 py-2 rounded w-full">إغلاق</button>
  </div>
</div>

<!-- ✅ إظهار المودال بعد الحجز -->
<c:if test="${success}">
  <script>
    document.addEventListener('DOMContentLoaded', function () {
      showSuccessModal();
    });
  </script>
</c:if>

</body>
<jsp:include page="footer.jsp" />
</html>
