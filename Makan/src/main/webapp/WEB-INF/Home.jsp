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

    </style>

</head>

<body class="min-h-screen flex flex-col">



<jsp:include page="navbarlogin.jsp" />



<main class="flex-grow">

    <div class="max-w-7xl mx-auto px-6 mt-8">

        <input type="text" name="search" placeholder="🔍 بحث عن قاعة" 

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

                فلترة

            </button>

        </form>



        <div class="w-2/3 grid grid-cols-1 md:grid-cols-2 gap-6">

            <c:forEach var="venue" items="${venues}">

                <div class="bg-white shadow rounded-xl overflow-hidden">

                    <img src="${venue.imageUrl}" alt="${venue.name}" class="w-full h-48 object-cover">

                    <div class="p-4">

                        <h3 class="text-lg font-bold mb-1">${venue.name}</h3>

                        <p class="text-gray-600 mb-1">المدينة: ${venue.city}</p>

                        <p class="text-gray-600 mb-1">الوصف: ${venue.description}</p>

                        <p class="text-gray-600 mb-1">السعر: ${venue.pricePerDay} شيكل</p>

                        <p class="text-gray-600">السعة: ${venue.capacity} شخص</p>

                    </div>

                </div>

            </c:forEach>

        </div>

    </div>

</main>





<jsp:include page="footer.jsp" />



</body>

</html>
