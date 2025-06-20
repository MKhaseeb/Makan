<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

        <!DOCTYPE html>
        <html lang="ar" dir="rtl">

        <head>

            <meta charset="UTF-8" />
            <title>قاعتي - بحث القاعات</title>

            <script src="https://cdn.tailwindcss.com"></script>
            <script>
                // تصفية القاعات بناءً على النص في مربع البحث
                function filterVenues() {
                    let searchQuery = document.getElementById("searchInput").value.toLowerCase();
                    let venues = document.querySelectorAll(".venue-item");

                    venues.forEach(function (venue) {
                        let name = venue.querySelector(".venue-name").textContent.toLowerCase();
                        let city = venue.querySelector(".venue-city").textContent.toLowerCase();
                        let village = venue.querySelector(".venue-village").textContent.toLowerCase();

                        if (name.includes(searchQuery) || city.includes(searchQuery) || village.includes(searchQuery)) {
                            venue.style.display = "block"; // عرض العنصر
                        } else {
                            venue.style.display = "none"; // إخفاء العنصر
                        }
                    });
                }
            </script>

            <style>
                body {
                    font-family: 'Cairo', sans-serif;
                    background-color: #fdfcf9;
                }

                input,
                select {
                    outline: none;
                }
            </style>

        </head>

        <body class="min-h-screen flex flex-col">

            <jsp:include page="navbarlogin.jsp" />

            <main class="flex-grow">
                <div class="max-w-7xl mx-auto px-6 mt-8">
                    <input id="searchInput" type="text" name="search" placeholder="🔍 بحث عن قاعة"
                        class="w-full p-3 rounded-md border border-gray-300 focus:ring-2 focus:ring-blue-400"
                        oninput="filterVenues()" />
                </div>

                <div class="max-w-7xl mx-auto px-6 mt-10 flex gap-8">

                    <form action="/halls/filter" method="get" class="w-1/3 bg-white p-6 rounded-xl shadow">
                        <h2 class="text-xl font-bold mb-4">فلاتر البحث</h2>

                        <label class="block mb-2 text-gray-700">المدينة:</label>
                        <select name="city" class="w-full mb-4 p-2 rounded-md border" onchange="filterVenues()">
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

                        <label class="block mb-2 text-gray-700">القرية:</label>
                        <input type="text" name="village" placeholder="مثال: بيتونيا"
                            class="w-full mb-4 p-2 rounded-md border" oninput="filterVenues()" />

                        <label class="block mb-2 text-gray-700">السعر الأقصى:</label>
                        <input type="number" name="maxPrice" class="w-full mb-4 p-2 rounded-md border"
                            oninput="filterVenues()" />

                        <label class="block mb-2 text-gray-700">الحد الأدنى للسعة:</label>
                        <input type="number" name="minCapacity" class="w-full mb-6 p-2 rounded-md border"
                            oninput="filterVenues()" />

                        <button type="submit" class="w-full bg-blue-600 hover:bg-blue-700 text-white py-2 rounded-md">
                            فلترة
                        </button>
                    </form>

                    <div class="space-y-6">

                        <c:forEach var="venue" items="${venues}">
                            <div class="venue-item">
                                <div class="block bg-white shadow rounded-xl overflow-hidden flex hover:shadow-lg transition-shadow duration-300 relative"
                                    data-id="${venue.id}">
                                    <img src="${venue.imageUrl}" alt="${venue.name}"
                                        class="w-48 h-48 object-cover flex-shrink-0" />
                                    <div class="p-4 flex flex-col justify-center text-right">
                                        <h3 class="text-lg font-bold mb-1 venue-name">${venue.name}</h3>
                                        <p class="text-gray-600 mb-1 venue-city">المدينة: ${venue.city}</p>
                                        <p class="text-gray-600 mb-1 venue-village">القرية: ${venue.village}</p>
                                        <p class="text-gray-600 mb-1">الوصف: ${venue.description}</p>
                                        <p class="text-gray-600 mb-1">السعر: ${venue.pricePerDay} شيكل</p>
                                        <p class="text-gray-600">السعة: ${venue.capacity} شخص</p>

                                        <div class="flex gap-2 mt-4">
                                            <a href="/halls/edit/${venue.id}"
                                                class="bg-blue-600 text-white px-3 py-1 rounded hover:bg-blue-700">تعديل</a>

                                            <button onclick="openDeleteModal(${venue.id})"
                                                class="bg-red-600 text-white px-3 py-1 rounded hover:bg-red-700">حذف</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>

                    </div>

                </div>

            </main>

            <!-- Modal الحذف -->
            <div id="deleteModal"
                class="fixed inset-0 bg-black bg-opacity-40 flex items-center justify-center hidden z-50">
                <div class="bg-white rounded-lg p-6 w-80 text-center">
                    <h2 class="text-xl font-bold mb-4">تأكيد الحذف</h2>
                    <p class="mb-6">هل تريد حذف هذه القاعة؟</p>
                    <div class="flex justify-center gap-4">
                        <button id="confirmDelete"
                            class="bg-red-600 text-white px-4 py-2 rounded hover:bg-red-700">حذف</button>
                        <button onclick="closeDeleteModal()"
                            class="bg-gray-300 px-4 py-2 rounded hover:bg-gray-400">إلغاء</button>
                  </div>
                if (name.includes(searchQuery) || city.includes(searchQuery) || village.includes(searchQuery)) {
                    venue.style.display = "block"; // عرض العنصر
                } else {
                    venue.style.display = "none"; // إخفاء العنصر
                }
            });
        }
    </script>

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

<jsp:include page="navbarlogin.jsp" />

<main class="flex-grow">
    <div class="max-w-7xl mx-auto px-6 mt-8">
        <input id="searchInput" type="text" name="search" placeholder="🔍 بحث عن قاعة" 
               class="w-full p-3 rounded-md border border-gray-300 focus:ring-2 focus:ring-blue-400" 
               oninput="filterVenues()" />
    </div>

    <div class="max-w-7xl mx-auto px-6 mt-10 flex gap-8">

        <form action="/halls/filter" method="get" class="w-1/3 bg-white p-6 rounded-xl shadow">
            <h2 class="text-xl font-bold mb-4">فلاتر البحث</h2>

            <label class="block mb-2 text-gray-700">المدينة:</label>
            <select name="city" class="w-full mb-4 p-2 rounded-md border" onchange="filterVenues()">
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

            <label class="block mb-2 text-gray-700">القرية:</label>
            <input type="text" name="village" placeholder="مثال: بيتونيا" class="w-full mb-4 p-2 rounded-md border" oninput="filterVenues()" />

            <label class="block mb-2 text-gray-700">السعر الأقصى:</label>
            <input type="number" name="maxPrice" class="w-full mb-4 p-2 rounded-md border" oninput="filterVenues()" />

            <label class="block mb-2 text-gray-700">الحد الأدنى للسعة:</label>
            <input type="number" name="minCapacity" class="w-full mb-6 p-2 rounded-md border" oninput="filterVenues()" />

            <button type="submit" class="w-full bg-blue-600 hover:bg-blue-700 text-white py-2 rounded-md">
                بحث
            </button>
        </form>

        <div class="w-2/3 flex flex-col gap-6">

            <c:forEach var="venue" items="${venues}">
                <div class="venue-item">
                    <a href="/halls/view/${venue.id}" class="block bg-white shadow rounded-xl overflow-hidden flex hover:shadow-lg transition-shadow duration-300">
                        <img src="${venue.imageUrl[0]}" alt="${venue.name}" class="w-48 h-48 object-cover flex-shrink-0" />
                        <div class="p-4 flex flex-col justify-center text-right">
                            <h3 class="text-lg font-bold mb-1 venue-name">${venue.name}</h3>
                            <p class="text-gray-600 mb-1 venue-city">المدينة: ${venue.city}</p>
                            <p class="text-gray-600 mb-1 venue-village">القرية: ${venue.village}</p>
                            <p class="text-gray-600 mb-1">الوصف: ${venue.description}</p>
                            <p class="text-gray-600 mb-1">السعر: ${venue.pricePerDay} شيكل</p>
                            <p class="text-gray-600">السعة: ${venue.capacity} شخص</p>
                        </div>
                    </a>
                </div>
            </div>
            </c:forEach>
        </div>


            <jsp:include page="footer.jsp" />
            <script>
                function scrollToTop() {
                    window.scrollTo({ top: 0, behavior: 'smooth' });
                }
                let deleteTargetId = null;

                function openDeleteModal(id) {
                    deleteTargetId = id;
                    document.getElementById('deleteModal').classList.remove('hidden');
                }

                function closeDeleteModal() {
                    deleteTargetId = null;
                    document.getElementById('deleteModal').classList.add('hidden');
                }

                function deleteVenue() {
                    fetch(`/halls/delete?id=${deleteTargetId}`, {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json'
                        }
                    })
                        .then(r => r.json())
                        .then(data => {
                            if (data.success) {
                                const targetItem = document.querySelector(`.venue-item[data-id="${deleteTargetId}"]`);
                                if (targetItem) targetItem.remove();
                            } else {
                                alert('فشلت عملية الحذف');
                            }
                            closeDeleteModal();
                        })
                        .catch(() => {
                            alert('حدث خطأ أثناء الحذف');
                            closeDeleteModal();
                        });
                }

                document.getElementById('confirmDelete').addEventListener('click', deleteVenue);



            </script>

        </body>

</html>
