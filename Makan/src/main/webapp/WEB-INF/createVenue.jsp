<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8" />
    <title>إضافة قاعة جديدة</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://unpkg.com/leaflet/dist/leaflet.css" />
    <script src="https://unpkg.com/leaflet/dist/leaflet.js"></script>
</head>

<body class="bg-gray-100 min-h-screen">

<jsp:include page="navbarlogin.jsp" />

<main class="flex justify-center py-12 px-4 ">

  <div class="bg-white rounded-3xl shadow-xl w-full max-w-4xl p-10 space-y-10">

    <h1 class="text-4xl font-extrabold text-center text-indigo-800 mb-6 animate-fade-in-down">إضافة قاعة جديدة</h1>

    <form:form action="/venue/new" method="post" modelAttribute="newVenue" enctype="multipart/form-data" class="space-y-6">

      <!-- الاسم -->
      <div>
        <label class="block text-lg font-semibold text-gray-800 mb-2">اسم القاعة :</label>
        <form:input path="name" cssClass="w-full px-4 py-2 rounded-xl border border-gray-300 focus:ring-2 focus:ring-indigo-400 focus:outline-none shadow-sm" />
        <form:errors path="name" cssClass="text-red-500 text-sm mt-1" />
      </div>

      <!-- المدينة والقرية -->
      <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
        <div>
          <label class="block text-lg font-semibold text-gray-800 mb-2">المدينة :</label>
          <form:select path="city" cssClass="w-full px-4 py-2 rounded-xl border border-gray-300 bg-white focus:ring-2 focus:ring-indigo-400 focus:outline-none shadow-sm">
            <form:option value="" label="اختر مدينة" />
                    <form:option value="القدس" />
                    <form:option value="رام الله" />
                    <form:option value="البيرة" />
                    <form:option value="نابلس" />
                    <form:option value="الخليل" />
                    <form:option value="بيت لحم" />
                    <form:option value="طولكرم" />
                    <form:option value="قلقيلية" />
                    <form:option value="سلفيت" />
                    <form:option value="جنين" />
                    <form:option value="أريحا" />
                    <form:option value="طوباس" />
                    <form:option value="غزة" />
                    <form:option value="خانيونس" />
                    <form:option value="رفح" />
                    <form:option value="دير البلح" />
                    <form:option value="جباليا" />
                    <form:option value="الزهراء" />
                    <form:option value="بيت حانون" />
                    <form:option value="بيت لاهيا" />
          </form:select>
          <form:errors path="city" cssClass="text-red-500 text-sm mt-1" />
        </div>
        <div>
          <label class="block text-lg font-semibold text-gray-800 mb-2">القرية / البلدة :</label>
          <form:input path="village" placeholder="مثال: بيتونيا" cssClass="w-full px-4 py-2 rounded-xl border border-gray-300 focus:ring-2 focus:ring-indigo-400 focus:outline-none shadow-sm" />
          <form:errors path="village" cssClass="text-red-500 text-sm mt-1" />
        </div>
      </div>

      <!-- العنوان الكامل -->
      <div>
        <label class="block text-lg font-semibold text-gray-800 mb-2">العنوان الكامل :</label>
        <form:input path="fullAddress" placeholder="مثال: شارع الإرسال" cssClass="w-full px-4 py-2 rounded-xl border border-gray-300 focus:ring-2 focus:ring-indigo-400 focus:outline-none shadow-sm" />
        <form:errors path="fullAddress" cssClass="text-red-500 text-sm mt-1" />
      </div>

      <!-- السعر والسعة -->
      <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
        <div>
          <label class="block text-lg font-semibold text-gray-800 mb-2">السعر اليومي :</label>
          <form:input path="pricePerDay" type="number" cssClass="w-full px-4 py-2 rounded-xl border border-gray-300 focus:ring-2 focus:ring-indigo-400 focus:outline-none shadow-sm" />
          <form:errors path="pricePerDay" cssClass="text-red-500 text-sm mt-1" />
        </div>
        <div>
          <label class="block text-lg font-semibold text-gray-800 mb-2">السعة :</label>
          <form:input path="capacity" type="number" cssClass="w-full px-4 py-2 rounded-xl border border-gray-300 focus:ring-2 focus:ring-indigo-400 focus:outline-none shadow-sm" />
          <form:errors path="capacity" cssClass="text-red-500 text-sm mt-1" />
        </div>
      </div>

      <!-- الوصف -->
      <div>
        <label class="block text-lg font-semibold text-gray-800 mb-2"> الوصف :</label>
        <form:textarea path="description" rows="4" cssClass="w-full px-4 py-2 rounded-xl border border-gray-300 focus:ring-2 focus:ring-indigo-400 focus:outline-none shadow-sm resize-none" />
        <form:errors path="description" cssClass="text-red-500 text-sm mt-1" />
      </div>

      <!-- الصور -->
      <div>
        <label class="block text-lg font-semibold text-gray-800 mb-2">الصور :</label>
        <input type="file" name="files" id="imageUpload" multiple accept="image/*" class="hidden" onchange="addImages(event)" />
        <label for="imageUpload" class="cursor-pointer flex items-center justify-center border-2 border-dashed border-gray-400 rounded-xl h-36 bg-white hover:border-indigo-600 transition-colors text-gray-500">
          📷 اضغط هنا لاختيار الصور أو اسحبها هنا
        </label>
        <div id="preview" class="mt-4 flex flex-wrap gap-4"></div>
      </div>

      <!-- الخريطة -->
      <div>
        <label class="block text-lg font-semibold text-gray-800 mb-2">حدد الموقع على الخريطة</label>
        <div id="map" class="rounded-xl border-2 border-gray-300" style="height: 400px;"></div>
        <input type="hidden" name="latitude" id="lat" />
        <input type="hidden" name="longitude" id="lon" />
      </div>

      <!-- المالك -->
      <div>
        <label class="block text-lg font-semibold text-gray-800 mb-2">اختر مالك القاعة :</label>
        <form:select path="owner.id" cssClass="w-full px-4 py-2 rounded-xl border border-gray-300 bg-white focus:ring-2 focus:ring-indigo-400 focus:outline-none shadow-sm">
          <form:option value="" label="اختر مالكًا" />
          <c:forEach items="${owners}" var="owner">
            <form:option value="${owner.id}">${owner.firstname} ${owner.lastname} - ${owner.email}</form:option>
          </c:forEach>
        </form:select>
        <form:errors path="owner.id" cssClass="text-red-500 text-sm mt-1" />
      </div>

      <!-- زر الإرسال -->
      <div class="text-center pt-4">
        <button type="submit" class="bg-gradient-to-r from-indigo-600 to-purple-600 hover:from-indigo-700 hover:to-purple-700 text-white text-lg font-bold px-10 py-3 rounded-full shadow-lg transition-all duration-300">
          ➕ إضافة القاعة
        </button>
      </div>

    </form:form>
  </div>
</main>


<!-- ✅ السكريبتات -->
<script>
    var defaultLat = 31.95;
    var defaultLon = 35.93;

    var map = L.map('map').setView([defaultLat, defaultLon], 13);

    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        attribution: '&copy; OpenStreetMap contributors'
    }).addTo(map);

    var marker = L.marker([defaultLat, defaultLon], { draggable: true }).addTo(map);

    function updateLatLon(lat, lon) {
        document.getElementById("lat").value = lat;
        document.getElementById("lon").value = lon;
    }

    marker.on('dragend', function (e) {
        var position = marker.getLatLng();
        updateLatLon(position.lat, position.lng);
    });

    map.on('click', function (e) {
        marker.setLatLng(e.latlng);
        updateLatLon(e.latlng.lat, e.latlng.lng);
    });

    updateLatLon(defaultLat, defaultLon);

    function addImages(event) {
        const preview = document.getElementById('preview');
        preview.innerHTML = '';
        const files = event.target.files;

        Array.from(files).forEach(file => {
            if (!file.type.startsWith('image/')) return;

            const reader = new FileReader();
            reader.onload = function (e) {
                const img = document.createElement('img');
                img.src = e.target.result;
                img.className = 'w-24 h-24 object-cover rounded-lg border border-gray-300 shadow-sm';
                preview.appendChild(img);
            };
            reader.readAsDataURL(file);
        });
    }
</script>

</body>
</html>











