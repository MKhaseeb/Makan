<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>

<html lang="ar" dir="rtl">

<head>

    <meta charset="UTF-8" />

    <title>قاعتي - بحث القاعات</title>

    <script src="https://cdn.tailwindcss.com"></script>

    <style>

        body {

            font-family: 'Cairo', sans-serif;

            background-color: #fdfcf9;

        }

        input, select {

            outline: none;

        }
        #site-title {
  color: #0c6efd;
  font-size: 2.2rem;
  font-weight: 900;
}
        

    </style>

</head>



<body class="min-h-screen flex flex-col">


<header class="sticky top-0 z-50 backdrop-blur-lg bg-white/70 border-b border-black/10 shadow-md">
  <div class="max-w-7xl mx-auto px-6 py-4 flex justify-between items-center">
    <h1 id="site-title" class="select-none cursor-default text-3xl font-extrabold text-blue-600">
      قاعتي
    </h1>

    <nav class="flex items-center gap-6 font-medium text-gray-700">
      <!-- روابط إضافية إن وجدت -->
      <!-- <a href="#" class="hover:text-blue-600 transition">رابط</a> -->

      <form action="/venue/logout" method="post">
        <button type="submit"
          class="bg-red-600 hover:bg-red-700 text-white font-bold py-2 px-5 rounded-full shadow-lg transition duration-300">
          تسجيل الخروج
        </button>
      </form>
    </nav>
  </div>
</header>


<main class="flex-grow">
    <div class="max-w-7xl mx-auto px-6 mt-8">
     <input id="searchInput" type="text" name="search" placeholder="🔍 بحث عن قاعة" 
       class="w-full p-3 rounded-md border border-gray-300 focus:ring-2 focus:ring-blue-400" />
    </div>



    <div class="max-w-7xl mx-auto px-6 mt-10 flex gap-8">

        <form action="/halls/filter" method="get" class="w-1/3 bg-white p-6 rounded-xl shadow">

            <h2 class="text-xl font-bold mb-4">فلاتر البحث</h2>



            <label class="block mb-2 text-gray-700">المدينة:</label>

            <select name="city" class="w-full mb-4 p-2 rounded-md border">

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
            <input type="text" name="village" placeholder="مثال: بيتونيا" class="w-full mb-4 p-2 rounded-md border" />

            <label class="block mb-2 text-gray-700">السعر الأقصى:</label>

            <input type="number" name="maxPrice" class="w-full mb-4 p-2 rounded-md border" />

            <label class="block mb-2 text-gray-700">الحد الأدنى للسعة:</label>

            <input type="number" name="minCapacity" class="w-full mb-6 p-2 rounded-md border" />

            <button type="submit" class="w-full bg-blue-600 hover:bg-blue-700 text-white py-2 rounded-md">

                بحث

            </button>

        </form>



<div class="w-2/3 flex flex-col gap-6">

<div id="noResultsMessage"
     class="text-center text-gray-500 text-xl font-semibold py-10"
     style="${empty venues ? '' : 'display:none;'}">
    لا يوجد قاعات .
</div>


<c:forEach var="venue" items="${venues}">
    <a data-venue href="/halls/view/${venue.id}" class="block bg-white shadow rounded-xl overflow-hidden flex hover:shadow-lg transition-shadow duration-300">
        <img src="${venue.imageUrl[1]}" alt="${venue.name}" class="w-48 h-48 object-cover flex-shrink-0" />
        <div class="p-4 flex flex-col justify-center text-right">
            <h3 class="text-lg font-bold mb-1">${venue.name}</h3>
            <p class="text-gray-600 mb-1">المدينة: ${venue.city}</p>
            <p class="text-gray-600 mb-1">القرية: ${venue.village}</p>
            <p class="text-gray-600 mb-1">الوصف: ${venue.description}</p>
            <p class="text-gray-600 mb-1">السعر: ${venue.pricePerDay} شيكل</p>
            <p class="text-gray-600">السعة: ${venue.capacity} شخص</p>
        </div>
    </a>
</c:forEach> 



        </div>

    </div>

</main>

<jsp:include page="footer.jsp" />

<script>
  const searchInput = document.getElementById("searchInput");
  const venues = document.querySelectorAll("[data-venue]");
  const noResultsMessage = document.getElementById("noResultsMessage");

  searchInput.addEventListener("input", function () {
    const value = this.value.trim().toLowerCase();
    let visibleCount = 0;

    venues.forEach(venue => {
      const name = venue.querySelector("h3").textContent.toLowerCase();
      const city = venue.querySelector("p:nth-child(2)").textContent.toLowerCase();
      const description = venue.querySelector("p:nth-child(3)").textContent.toLowerCase();

      const isMatch = name.includes(value) || city.includes(value) || description.includes(value);
      venue.style.display = isMatch ? "flex" : "none";

      if (isMatch) visibleCount++;
    });

    if (noResultsMessage) {
      noResultsMessage.style.display = visibleCount === 0 ? "block" : "none";
    }
  });
</script>


</body>

</html>