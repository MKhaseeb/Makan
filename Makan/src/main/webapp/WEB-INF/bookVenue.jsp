<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8" />
    <title>احجز قاعتك</title>

    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>

    <!-- FullCalendar CSS -->
    <link href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.7/index.global.min.css" rel="stylesheet" />

    <!-- FullCalendar JS -->
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

            events: bookedDates.map(date => ({
                start: date,
                display: 'background',
                color: '#fee2e2'
            })),

            dateClick: function (info) {
                const dateStr = info.dateStr;

                if (bookedDates.includes(dateStr)) {
                    alert("هذا التاريخ محجوز بالفعل.");
                    return;
                }

                if (selectedEvent) {
                    selectedEvent.remove();
                    selectedEvent = null;
                }

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

    // modal functions
    function showSuccessModal() {
        document.getElementById("successModal").classList.remove("hidden");
    }

    function closeModal() {
        document.getElementById("successModal").classList.add("hidden");
    }
    </script>
</head>

<body class="bg-gray-100 p-10">

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
        <input type="text" readonly
               value="${user.firstname} ${user.lastname}"
               class="mt-1 block w-full border p-2 rounded bg-gray-100"/>
    </label>

    <label class="block">
        <span class="text-gray-700">البريد الإلكتروني:</span>
        <input type="email" readonly
               value="${user.email}"
               class="mt-1 block w-full border p-2 rounded bg-gray-100"/>
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

<!-- Success Modal -->
<div id="successModal" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center hidden z-50">
  <div class="bg-white rounded-lg p-6 max-w-sm w-full text-center">
    <h2 class="text-2xl font-bold mb-4 text-green-600">تم الحجز بنجاح ✅</h2>
    <p class="mb-6">تم تسجيل حجزك وسيتم التواصل معك قريباً.</p>
    <button onclick="closeModal()" class="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700">حسناً</button>
  </div>
</div>

<!-- Show Modal if success=true in URL -->
<c:if test="${param.success eq 'true'}">
  <script>
    document.addEventListener('DOMContentLoaded', showSuccessModal);
  </script>
</c:if>

</body>
</html>
