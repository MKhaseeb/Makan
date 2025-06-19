<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="https://unpkg.com/leaflet/dist/leaflet.css" />
<script src="https://unpkg.com/leaflet/dist/leaflet.js"></script>

<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8" />
    <title>إضافة قاعة جديدة</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="bg-gray-100 min-h-screen flex flex-col items-center justify-center p-4">

    <!-- شريط التنقل -->
    <jsp:include page="navbarlogin.jsp" />

    <div class="bg-white rounded-lg shadow-lg max-w-lg w-full p-8 mt-6">
        <h1 class="text-2xl font-semibold mb-6 text-gray-800 text-center">إضافة قاعة</h1>

        <form:form action="/venue/new" method="post" modelAttribute="newVenue" enctype="multipart/form-data" class="space-y-5">

            <div>
                <label class="block mb-1 font-medium text-gray-700">الاسم:</label>
                <form:input path="name" cssClass="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-indigo-500" />
                <form:errors path="name" cssClass="text-red-600 text-sm mt-1" />
            </div>

            <div>
                <label class="block mb-1 font-medium text-gray-700">المدينة:</label>
                <form:input path="city" cssClass="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-indigo-500" />
                <form:errors path="city" cssClass="text-red-600 text-sm mt-1" />
            </div>

            <div>
                <label class="block mb-1 font-medium text-gray-700">السعر اليومي:</label>
                <form:input path="pricePerDay" type="number" cssClass="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-indigo-500" />
                <form:errors path="pricePerDay" cssClass="text-red-600 text-sm mt-1" />
            </div>

            <div>
                <label class="block mb-1 font-medium text-gray-700">السعة:</label>
                <form:input path="capacity" type="number" cssClass="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-indigo-500" />
                <form:errors path="capacity" cssClass="text-red-600 text-sm mt-1" />
            </div>

            <div>
                <label class="block mb-1 font-medium text-gray-700">الوصف:</label>
                <form:textarea path="description" rows="4" cssClass="w-full border border-gray-300 rounded px-3 py-2 resize-none focus:outline-none focus:ring-2 focus:ring-indigo-500" />
                <form:errors path="description" cssClass="text-red-600 text-sm mt-1" />
            </div>

            <div>
                <label class="block mb-1 font-medium text-gray-700">الصور:</label>

                <!-- نستخدم input عادي لأنه لا يمكن ربطه بـ List مباشرةً في Spring Form -->
                <input 
                    type="file" 
                    name="files" 
                    id="imageUpload" 
                    multiple 
                    accept="image/*"
                    class="hidden"
                    onchange="addImages(event)"
                />

                <label for="imageUpload" class="cursor-pointer flex items-center justify-center border-2 border-dashed border-gray-400 rounded-lg h-32 hover:border-indigo-600 transition-colors text-gray-500">
                    اضغط هنا لاختيار صور أو اسحبها
                </label>

                <div id="preview" class="mt-4 flex flex-wrap gap-4"></div>
            </div>
            <div>
    <label class="block mb-1 font-medium text-gray-700">حدد موقع القاعة على الخريطة:</label>
    <div id="map" style="height: 400px;" class="rounded mb-4"></div>

    <!-- الحقول المخفية التي سترسل مع النموذج -->
    <input type="hidden" name="latitude" id="lat" />
    <input type="hidden" name="longitude" id="lon" />
</div>

            <div class="text-center">
                <button type="submit" class="bg-indigo-600 hover:bg-indigo-700 text-white font-semibold px-6 py-2 rounded transition duration-300">
                    إضافة
                </button>
            </div>

        </form:form>
    </div>

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

// أول قيم تلقائية
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
