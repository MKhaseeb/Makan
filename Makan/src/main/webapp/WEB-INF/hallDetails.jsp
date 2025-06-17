<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8" />
    <title>تفاصيل القاعة - ${venue.name}</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="min-h-screen bg-gray-50 font-sans p-8">

<jsp:include page="navbarlogin.jsp" />

<div class="max-w-4xl mx-auto bg-white p-6 rounded-xl shadow-lg">
    <img src="${venue.imageUrl}" alt="${venue.name}" class="w-full h-64 object-cover rounded-md mb-6" />
    <h1 class="text-3xl font-bold mb-4">${venue.name}</h1>
    <p class="mb-2"><strong>المدينة:</strong> ${venue.city}</p>
    <p class="mb-2"><strong>القرية:</strong> ${venue.village}</p>
    <p class="mb-2"><strong>الوصف:</strong> ${venue.description}</p>
    <p class="mb-2"><strong>السعر لكل يوم:</strong> ${venue.pricePerDay} شيكل</p>
    <p class="mb-2"><strong>السعة:</strong> ${venue.capacity} شخص</p>

    <a href="/halls" class="inline-block mt-6 px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-700">العودة لصفحة البحث</a>
</div>

<jsp:include page="footer.jsp" />

</body>
</html>
