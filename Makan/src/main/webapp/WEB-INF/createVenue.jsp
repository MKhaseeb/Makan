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

<!-- ✅ شريط التنقل -->
<header class="bg-white shadow sticky top-0 z-50">
    <div class="max-w-7xl mx-auto px-6 py-4 flex justify-between items-center">
        <h1 class="text-2xl font-bold text-indigo-700">قاعتي</h1>
        <nav class="flex items-center gap-6 text-gray-700 font-medium">
            <a href="/homes" class="hover:text-indigo-600 transition">قائمة القاعات</a>
            <a href="/venue" class="hover:text-indigo-600 transition">إضافة قاعة</a>
            <form action="/venue/logout" method="post">
                <button type="submit" class="bg-red-600 text-white px-4 py-1 rounded hover:bg-red-700 transition">تسجيل الخروج</button>
            </form>
        </nav>
    </div>
</header>

<!-- ✅ نموذج الإضافة -->
<main class="flex justify-center items-start py-10 px-4">
    <div class="bg-white rounded-xl shadow-md w-full max-w-3xl p-8 space-y-6">

        <h1 class="text-3xl font-bold text-center text-indigo-700">إضافة قاعة جديدة</h1>

        <form:form action="/venue/new" method="post" modelAttribute="newVenue" enctype="multipart/form-data" class="space-y-6">

            <!-- الاسم -->
            <div>
                <label class="block font-medium text-gray-700 mb-1">الاسم:</label>
                <form:input path="name" cssClass="form-input w-full" />
                <form:errors path="name" cssClass="text-red-600 text-sm mt-1" />
            </div>

            <!-- المدينة -->
            <div>
                <label class="block font-medium text-gray-700 mb-1">المدينة:</label>
                <form:select path="city" cssClass="form-select w-full">
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
                <form:errors path="city" cssClass="text-red-600 text-sm mt-1" />
            </div>

            <!-- القرية -->
            <div>
                <label class="block font-medium text-gray-700 mb-1">القرية/البلدة:</label>
                <form:input path="village" placeholder="مثال: بيتونيا" cssClass="form-input w-full" />
                <form:errors path="village" cssClass="text-red-600 text-sm mt-1" />
            </div>
<div>
    <label class="block font-medium text-gray-700 mb-1">العنوان الكامل:</label>
    <form:input path="fullAddress" placeholder="مثال: شارع الإرسال، عمارة رقم 5" cssClass="form-input w-full" />
    <form:errors path="fullAddress" cssClass="text-red-600 text-sm mt-1" />
</div>
            <!-- السعر -->
            <div>
                <label class="block font-medium text-gray-700 mb-1">السعر اليومي:</label>
                <form:input path="pricePerDay" type="number" cssClass="form-input w-full" />
                <form:errors path="pricePerDay" cssClass="text-red-600 text-sm mt-1" />
            </div>

            <!-- السعة -->
            <div>
                <label class="block font-medium text-gray-700 mb-1">السعة:</label>
                <form:input path="capacity" type="number" cssClass="form-input w-full" />
                <form:errors path="capacity" cssClass="text-red-600 text-sm mt-1" />
            </div>

            <!-- الوصف -->
            <div>
                <label class="block font-medium text-gray-700 mb-1">الوصف:</label>
                <form:textarea path="description" rows="4" cssClass="form-textarea w-full resize-none" />
                <form:errors path="description" cssClass="text-red-600 text-sm mt-1" />
            </div>

            <!-- الصور -->
            <div>
                <label class="block font-medium text-gray-700 mb-1">الصور:</label>
                <input type="file" name="files" id="imageUpload" multiple accept="image/*" class="hidden" onchange="addImages(event)" />
                <label for="imageUpload" class="cursor-pointer flex items-center justify-center border-2 border-dashed border-gray-400 rounded-lg h-32 hover:border-indigo-600 transition-colors text-gray-500">اضغط هنا لاختيار صور أو اسحبها</label>
                <div id="preview" class="mt-4 flex flex-wrap gap-4"></div>
            </div>

            <!-- الخريطة -->
            <div>
                <label class="block font-medium text-gray-700 mb-1">حدد موقع القاعة على الخريطة:</label>
                <div id="map" style="height: 400px;" class="rounded border mt-2"></div>
                <input type="hidden" name="latitude" id="lat" />
                <input type="hidden" name="longitude" id="lon" />
            </div>

            <!-- المالك -->
            <div>
                <label class="block font-medium text-gray-700 mb-1">اختر مالك القاعة:</label>
                <form:select path="owner.id" cssClass="form-select w-full">
                    <form:option value="" label="اختر مالكًا" />
                    <c:forEach items="${owners}" var="owner">
                        <form:option value="${owner.id}">
                            ${owner.firstname} ${owner.lastname} - ${owner.email}
                        </form:option>
                    </c:forEach>
                </form:select>
                <form:errors path="owner.id" cssClass="text-red-600 text-sm mt-1" />
            </div>

            <!-- زر الإرسال -->
            <div class="text-center">
                <button type="submit" class="bg-indigo-600 hover:bg-indigo-700 text-white font-bold px-6 py-2 rounded-lg shadow-md transition">إضافة</button>
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











