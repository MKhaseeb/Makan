<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8" />
    <meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
    <title>${venue.name} - قاعتي</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        body {
            font-family: 'Cairo', sans-serif;
            background-color: #fdfcf9;
        }
        .edit-icon {
            width: 20px; height: 20px; cursor: pointer; transition: color 0.3s;
            color: #4f46e5;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }
        .edit-icon:hover {
            color: #3730a3;
        }
        .hidden { display: none !important; }
        #calendar {
            background-color: white;
            border-radius: 8px;
            padding: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
    </style>
    <link href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.7/index.global.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
    <link rel="stylesheet" href="https://unpkg.com/leaflet/dist/leaflet.css" />
    <script src="https://unpkg.com/leaflet/dist/leaflet.js"></script>
</head>
<body class="min-h-screen flex flex-col">
<c:choose>
    <c:when test="${user.role == 'admin'}">
        <jsp:include page="navbarlogin.jsp" />
    </c:when>
    
    <c:when test="${user.role == 'owner'}">
        <jsp:include page="navbarowner.jsp" />
    </c:when>
    
    <c:otherwise>
        <jsp:include page="navbaruser.jsp" />
    </c:otherwise>
</c:choose>


<main class="flex-grow">

<section class="w-full h-[600px] overflow-hidden">
  <div class="swiper mySwiper h-full">
    <div class="swiper-wrapper h-full">
      <c:forEach var="img" items="${venue.imageUrl}">
        <div class="swiper-slide h-full">
          <img src="${img}" alt="${venue.name}" class="w-full h-full object-cover" />
        </div>
      </c:forEach>
    </div>
    <div class="swiper-pagination"></div>
    <div class="swiper-button-next"></div>
    <div class="swiper-button-prev"></div>
  </div>
</section>

<section class="px-6 py-8 max-w-7xl mx-auto">

  <div class="flex items-center gap-2 mb-6">
    <h1 id="venueNameText" class="text-4xl font-bold text-gray-800">${venue.name}</h1>
    <input type="text" id="venueNameInput" class="hidden border rounded px-2 py-1 text-2xl font-bold" value="${venue.name}" />

    <c:if test="${sessionScope.user != null && (sessionScope.user.id == venue.owner.id || sessionScope.user.role == 'admin')}">
      <button id="editVenueNameBtn" class="edit-icon" title="Edit Venue Name" type="button" aria-label="Edit Venue Name">
        <svg xmlns="http://www.w3.org/2000/svg" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24" class="w-5 h-5">
          <path stroke-linecap="round" stroke-linejoin="round" d="M15.232 5.232l3.536 3.536M9 11l3 3L20.5 5.5a2.121 2.121 0 00-3-3L9 11z"/>
        </svg>
      </button>
    </c:if>
  </div>
  <!-- Tabs -->
  <div class="flex flex-wrap gap-4 mb-8">
    <button class="tabBtn bg-blue-600 hover:bg-blue-700 text-white px-6 py-2 rounded-md" data-tab="description">الوصف</button>
    <button class="tabBtn bg-gray-200 hover:bg-gray-300 text-gray-800 px-6 py-2 rounded-md" data-tab="schedule">المواعيد</button>
    <button class="tabBtn bg-gray-200 hover:bg-gray-300 text-gray-800 px-6 py-2 rounded-md" data-tab="pricing">الأسعار</button>
  </div>

  <!-- Description -->
  <div id="description" class="tabContent">
    <h2 class="text-xl font-semibold mb-2 flex items-center justify-between">
      الوصف:
      <c:if test="${sessionScope.user != null && (sessionScope.user.id == venue.owner.id || sessionScope.user.role == 'admin')}">
        <button id="editVenueDescriptionBtn" class="edit-icon" title="Edit Description" type="button">
          <svg xmlns="http://www.w3.org/2000/svg" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24" class="w-5 h-5">
            <path stroke-linecap="round" stroke-linejoin="round" d="M15.232 5.232l3.536 3.536M9 11l3 3L20.5 5.5a2.121 2.121 0 00-3-3L9 11z"/>
          </svg>
        </button>
      </c:if>
    </h2>
    <p id="venueDescriptionText" class="text-gray-700 leading-relaxed">${venue.description}</p>
    <textarea id="venueDescriptionInput" class="hidden w-full border rounded p-2" rows="5">${venue.description}</textarea>

    <h2 class="text-xl font-semibold mb-2 flex items-center justify-between mt-8">
      العنوان الكامل:
      <c:if test="${sessionScope.user != null && (sessionScope.user.id == venue.owner.id || sessionScope.user.role == 'admin')}">
        <button id="editVenueAddressBtn" class="edit-icon" title="Edit Address" type="button">
          <svg xmlns="http://www.w3.org/2000/svg" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24" class="w-5 h-5">
            <path stroke-linecap="round" stroke-linejoin="round" d="M15.232 5.232l3.536 3.536M9 11l3 3L20.5 5.5a2.121 2.121 0 00-3-3L9 11z"/>
          </svg>
        </button>
      </c:if>
    </h2>
    <p id="venueAddressText" class="text-gray-700 leading-relaxed">${venue.fullAddress}</p>
    <textarea id="venueAddressInput" class="hidden w-full border rounded p-2" rows="3">${venue.fullAddress}</textarea>
  </div>

  <!-- Schedule Tab -->
  <div id="schedule" class="tabContent hidden">
    <div id="calendar"></div>
  </div>

  <!-- Pricing -->
  <div id="pricing" class="tabContent hidden">
    <h2 class="text-xl font-semibold mb-2 flex items-center justify-between">
      الأسعار:
      <c:if test="${sessionScope.user != null && (sessionScope.user.id == venue.owner.id || sessionScope.user.role == 'admin')}">
        <button id="editVenuePriceBtn" class="edit-icon" title="Edit Price" type="button">
          <svg xmlns="http://www.w3.org/2000/svg" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24" class="w-5 h-5">
            <path stroke-linecap="round" stroke-linejoin="round" d="M15.232 5.232l3.536 3.536M9 11l3 3L20.5 5.5a2.121 2.121 0 00-3-3L9 11z"/>
          </svg>
        </button>
      </c:if>
    </h2>
    <p id="venuePriceText" class="text-gray-700 mb-1">السعر اليومي: ${venue.pricePerDay} شيكل</p>
    <input id="venuePriceInput" type="number" min="1" step="0.01" class="hidden border rounded p-2 w-32" value="${venue.pricePerDay}"/>
    <p class="text-gray-600">تخصيص الأسعار حسب اليوم أو المناسبة متاح عند الطلب.</p>
  </div>
    <!-- Map -->
  <div class="mt-10">
    <h2 class="text-xl font-semibold mb-2">موقع القاعة على الخريطة:</h2>
    <div id="venueMap" style="height: 400px; width: 100%;" class="rounded shadow"></div>
  </div>

  <!-- Booking and Edit Buttons -->
  <div class="mt-10 flex gap-4 items-center">
    <a href="<c:url value='/book?venueId=${venue.id}'/>" id="bookingBtn" class="bg-green-600 hover:bg-green-700 text-white px-10 py-3 rounded-md text-lg shadow">
      احجز الآن
    </a>
<c:if test="${sessionScope.user != null && sessionScope.user.id != venue.owner.id}">
    <a href="<c:url value='/owner/chat/${sessionScope.user.id < venue.owner.id ? sessionScope.user.id : venue.owner.id}-${sessionScope.user.id > venue.owner.id ? sessionScope.user.id : venue.owner.id}'/>"
       class="bg-blue-600 hover:bg-blue-700 text-white px-10 py-3 rounded-md text-lg shadow flex items-center gap-2">
        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5"
            stroke="currentColor" class="w-6 h-6">
            <path stroke-linecap="round" stroke-linejoin="round"
                d="M8.625 21.75a.75.75 0 01-.75-.75v-2.25A2.25 2.25 0 005.625 16.5h-2.25a.75.75 0 01-.75-.75v-10.5A2.25 2.25 0 015.625 3h12.75A2.25 2.25 0 0120.625 5.25v10.5a.75.75 0 01-.75.75h-2.25a2.25 2.25 0 00-2.25 2.25v2.25a.75.75 0 01-.75.75h-4.5z" />
        </svg>
        تواصل مع المالك
    </a>
</c:if>
<c:if test="${sessionScope.user != null && sessionScope.user.role == 'admin'}">
    <!-- Delete Button Trigger -->
<button type="button"
        onclick="openDeleteModal()"
        class="flex items-center gap-2 bg-red-600 hover:bg-red-700 text-white px-6 py-3 rounded-md text-lg shadow"
        title="حذف القاعة">
    <svg xmlns="http://www.w3.org/2000/svg" fill="none" stroke="currentColor"
         stroke-width="1.5" viewBox="0 0 24 24" class="w-6 h-6">
        <path stroke-linecap="round" stroke-linejoin="round"
              d="M6 18L18 6M6 6l12 12"/>
    </svg>
    حذف القاعة
</button>


<!-- Confirmation Modal -->
<div id="deleteModal" class="fixed inset-0 bg-black bg-opacity-40 flex items-center justify-center z-50 hidden">
    <div class="bg-white rounded-lg shadow-lg p-6 w-full max-w-md text-right">
        <h2 class="text-xl font-bold text-gray-800 mb-4">تأكيد الحذف</h2>
        <p class="text-gray-600 mb-6">هل أنت متأكد أنك تريد حذف هذه القاعة؟ لا يمكن التراجع عن هذا الإجراء.</p>
        <div class="flex justify-end gap-4">
            <button onclick="closeDeleteModal()" class="px-4 py-2 bg-gray-300 hover:bg-gray-400 rounded">إلغاء</button>
           <button type="button" 
        class="px-4 py-2 bg-red-600 hover:bg-red-700 text-white rounded" 
        onclick="deleteVenue(${venue.id}); closeDeleteModal();">
    نعم، احذف
</button>
        </div>
    </div>
</div>
</c:if>

    <div id="editButtonsContainer" class="hidden gap-4">
      <button id="saveChangesBtn" class="bg-blue-600 hover:bg-blue-700 text-white px-6 py-3 rounded-md">حفظ التغييرات</button>
      <button id="cancelChangesBtn" class="bg-gray-400 hover:bg-gray-500 text-white px-6 py-3 rounded-md">إلغاء</button>
    </div>
  </div>

</section>
</main>

<jsp:include page="footer.jsp" />

<!-- Tabs Logic -->
<script>
    const tabBtns = document.querySelectorAll('.tabBtn');
    const tabContents = document.querySelectorAll('.tabContent');

    tabBtns.forEach(btn => {
        btn.addEventListener('click', () => {
            tabBtns.forEach(b => {
                b.classList.remove('bg-blue-600', 'text-white');
                b.classList.add('bg-gray-200', 'text-gray-800');
            });
            btn.classList.remove('bg-gray-200', 'text-gray-800');
            btn.classList.add('bg-blue-600', 'text-white');

            tabContents.forEach(content => content.classList.add('hidden'));
            document.getElementById(btn.getAttribute('data-tab')).classList.remove('hidden');
        });
    });

    document.getElementById('description').classList.remove('hidden');
</script>

<!-- Map and Calendar Logic -->
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.7/index.global.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>

<script>
document.addEventListener("DOMContentLoaded", function () {
    var lat = ${venue.latitude};
    var lon = ${venue.longitude};

    if (!lat || !lon) {
        document.getElementById("venueMap").innerHTML = "<p class='text-gray-600'>موقع القاعة غير محدد.</p>";
    } else {
        var map = L.map('venueMap').setView([lat, lon], 15);
        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            attribution: '&copy; OpenStreetMap contributors'
        }).addTo(map);
        L.marker([lat, lon]).addTo(map)
            .bindPopup('${venue.name}')
            .openPopup();
    }

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
        firstDay: 6,
        selectable: true,
        events: bookedDates.map(date => ({
            title: 'محجوز',
            start: date,
            display: 'background',
            color: '#fca5a5'
        })),
        dateClick: function(info) {
            if (!bookedDates.includes(info.dateStr)) {
                window.location.href = '/booking/${venue.id}?date=' + info.dateStr;
            } else {
                alert('هذا التاريخ محجوز بالفعل.');
            }
        }
    });

    calendar.render();

    const swiper = new Swiper(".mySwiper", {
        loop: true,
        pagination: { el: ".swiper-pagination", clickable: true },
        navigation: { nextEl: ".swiper-button-next", prevEl: ".swiper-button-prev" },
        autoplay: { delay: 4000, disableOnInteraction: false }
    });
});
</script>
  <!-- Edit Script for Admin or Owner -->
<c:if test="${sessionScope.user != null && (sessionScope.user.id == venue.owner.id || sessionScope.user.role == 'admin')}">
<script>
    let isEditing = false;

    const venueNameText = document.getElementById("venueNameText");
    const venueNameInput = document.getElementById("venueNameInput");
    const editVenueNameBtn = document.getElementById("editVenueNameBtn");

    const venueDescriptionText = document.getElementById("venueDescriptionText");
    const venueDescriptionInput = document.getElementById("venueDescriptionInput");
    const editVenueDescriptionBtn = document.getElementById("editVenueDescriptionBtn");

    const venueAddressText = document.getElementById("venueAddressText");
    const venueAddressInput = document.getElementById("venueAddressInput");
    const editVenueAddressBtn = document.getElementById("editVenueAddressBtn");

    const venuePriceText = document.getElementById("venuePriceText");
    const venuePriceInput = document.getElementById("venuePriceInput");
    const editVenuePriceBtn = document.getElementById("editVenuePriceBtn");

    const bookingBtn = document.getElementById("bookingBtn");
    const editButtonsContainer = document.getElementById("editButtonsContainer");
    const saveChangesBtn = document.getElementById("saveChangesBtn");
    const cancelChangesBtn = document.getElementById("cancelChangesBtn");

    function enterEditMode() {
        if (isEditing) return;
        isEditing = true;

        venueNameText.classList.add("hidden");
        venueNameInput.classList.remove("hidden");
        editVenueNameBtn.classList.add("hidden");

        venueDescriptionText.classList.add("hidden");
        venueDescriptionInput.classList.remove("hidden");
        editVenueDescriptionBtn.classList.add("hidden");

        venueAddressText.classList.add("hidden");
        venueAddressInput.classList.remove("hidden");
        editVenueAddressBtn.classList.add("hidden");

        venuePriceText.classList.add("hidden");
        venuePriceInput.classList.remove("hidden");
        editVenuePriceBtn.classList.add("hidden");

        bookingBtn.classList.add("hidden");
        editButtonsContainer.classList.remove("hidden");
    }

    function exitEditMode() {
        if (!isEditing) return;
        isEditing = false;

        venueNameText.classList.remove("hidden");
        venueNameInput.classList.add("hidden");
        editVenueNameBtn.classList.remove("hidden");
        venueNameInput.value = venueNameText.textContent.trim();

        venueDescriptionText.classList.remove("hidden");
        venueDescriptionInput.classList.add("hidden");
        editVenueDescriptionBtn.classList.remove("hidden");
        venueDescriptionInput.value = venueDescriptionText.textContent.trim();

        venueAddressText.classList.remove("hidden");
        venueAddressInput.classList.add("hidden");
        editVenueAddressBtn.classList.remove("hidden");
        venueAddressInput.value = venueAddressText.textContent.trim();

        venuePriceText.classList.remove("hidden");
        venuePriceInput.classList.add("hidden");
        editVenuePriceBtn.classList.remove("hidden");
        venuePriceInput.value = venuePriceText.textContent.replace(/[^\d.]/g, '').trim();

        bookingBtn.classList.remove("hidden");
        editButtonsContainer.classList.add("hidden");
    }

    function validateInputs() {
        if (venueNameInput.value.trim() === "") {
            alert("اسم القاعة لا يمكن أن يكون فارغًا");
            return false;
        }
        if (venueDescriptionInput.value.trim() === "") {
            alert("الوصف لا يمكن أن يكون فارغًا");
            return false;
        }
        if (venueAddressInput.value.trim() === "") {
            alert("العنوان الكامل لا يمكن أن يكون فارغًا");
            return false;
        }
        if (venuePriceInput.value.trim() === "" || isNaN(venuePriceInput.value) || Number(venuePriceInput.value) <= 0) {
            alert("السعر يجب أن يكون رقماً أكبر من صفر");
            return false;
        }
        return true;
    }

    editVenueNameBtn.addEventListener("click", enterEditMode);
    editVenueDescriptionBtn.addEventListener("click", enterEditMode);
    editVenueAddressBtn.addEventListener("click", enterEditMode);
    editVenuePriceBtn.addEventListener("click", enterEditMode);

    cancelChangesBtn.addEventListener("click", exitEditMode);

    saveChangesBtn.addEventListener("click", () => {
        if (!validateInputs()) return;

        const payload = {
            id: ${venue.id},
            name: venueNameInput.value.trim(),
            description: venueDescriptionInput.value.trim(),
            fullAddress: venueAddressInput.value.trim(),
            pricePerDay: parseFloat(venuePriceInput.value.trim())
        };

        fetch('/updateDetails', {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
                "X-Requested-With": "XMLHttpRequest"
            },
            body: JSON.stringify(payload)
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                venueNameText.textContent = payload.name;
                venueDescriptionText.textContent = payload.description;
                venueAddressText.textContent = payload.fullAddress;
                venuePriceText.textContent = `السعر اليومي: ${payload.pricePerDay} شيكل`;
                exitEditMode();
            } else {
                alert("فشل التحديث: " + (data.message || "خطأ غير معروف"));
            }
        })
        .catch(err => {
            console.error(err);
            alert("فشل الاتصال بالخادم");
        });
    });
    
    
</script>

<script>
  function openDeleteModal() {
    document.getElementById("deleteModal").classList.remove("hidden");
  }

  function closeDeleteModal() {
    document.getElementById("deleteModal").classList.add("hidden");
  }
</script>

<script>
  // Show the modal
  function openDeleteModal() {
    document.getElementById('deleteModal').classList.remove('hidden');
  }

  // Hide the modal
  function closeDeleteModal() {
    document.getElementById('deleteModal').classList.add('hidden');
  }

  // Optional: close modal if clicked outside the modal content
  window.addEventListener('click', function(event) {
    const modal = document.getElementById('deleteModal');
    if (!modal.classList.contains('hidden') && event.target === modal) {
      closeDeleteModal();
    }
  });
</script>


<script>
	function deleteVenue(id) {
		  fetch(`/admin/deleteVenue/${id}`, {
		    method: 'POST',
		    headers: {
		      'Content-Type': 'application/json',
		      'X-CSRF-TOKEN': document.querySelector('meta[name="_csrf"]').getAttribute('content')
		    },
		  })
		  .then(response => response.text())
		  .then(result => {
		    if (result === 'success') {
		      alert('تم حذف القاعة بنجاح');
		      window.location.href = '/homes';
		    } else {
		      alert('فشل حذف القاعة');
		    }
		  })
		  .catch(error => {
		    console.error('خطأ:', error);
		    alert('حدث خطأ أثناء حذف القاعة');
		  });
		}
</script>


</c:if>

</body>
</html>
  