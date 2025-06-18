<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8">
    <title>لوحة تحكم المالك</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen">

    <!-- رأس الصفحة -->
    <header class="bg-indigo-700 text-white py-4 px-6 flex justify-between items-center">
        <h1 class="text-xl font-bold">لوحة تحكم المالك</h1>
        <form action="/venue/logout" method="post">
            <button type="submit" class="bg-red-500 px-4 py-2 rounded hover:bg-red-600">تسجيل الخروج</button>
        </form>
    </header>

    <!-- المحتوى الرئيسي -->
    <main class="p-6">

        <!-- عرض القاعات التابعة لهذا المالك -->
        <section class="mb-10">
            <h2 class="text-2xl font-semibold text-gray-800 mb-4">قاعاتي</h2>
            <c:if test="${empty venues}">
                <p class="text-gray-600">لا توجد قاعات حالياً.</p>
            </c:if>
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                <c:forEach items="${venues}" var="v">
                    <div class="bg-white shadow rounded overflow-hidden">
                        <img src="${v.imageUrl}" alt="صورة القاعة" class="h-48 w-full object-cover">
                        <div class="p-4">
                            <h3 class="text-xl font-bold mb-1">${v.name}</h3>
                            <p class="text-gray-600">${v.city} - ${v.pricePerDay} شيكل / يوم</p>
                            <p class="text-sm text-gray-500 mt-1">السعة: ${v.capacity}</p>
                            <div class="mt-3 flex justify-between items-center">
                                <a href="/venue/edit?id=${v.id}" class="text-indigo-600 hover:underline">✏️ تعديل</a>
                                <form action="/venue/delete/${v.id}" method="post" onsubmit="return confirm('هل أنت متأكد من حذف هذه القاعة؟');">
                                    <button type="submit" class="text-red-600 hover:underline">🗑️ حذف</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </section>

        <!-- قسم الحجوزات -->
        <section>
            <h2 class="text-2xl font-semibold text-gray-800 mb-4">الحجوزات على قاعاتي</h2>
            <c:if test="${empty bookings}">
                <p class="text-gray-600">لا توجد حجوزات حالياً.</p>
            </c:if>
            <div class="bg-white shadow rounded overflow-x-auto">
                <table class="min-w-full text-right">
                    <thead>
                        <tr class="bg-gray-200 text-gray-700">
                            <th class="py-2 px-4">القاعة</th>
                            <th class="py-2 px-4">اسم المستخدم</th>
                            <th class="py-2 px-4">تاريخ الحجز</th>
                            <th class="py-2 px-4">الحالة</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${bookings}" var="b">
                            <tr class="border-b">
                                <td class="py-2 px-4">${b.venue.name}</td>
                                <td class="py-2 px-4">${b.user.userName}</td>
                                <td class="py-2 px-4">${b.bookingDate}</td>
                                <td class="py-2 px-4">${b.status}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </section>

    </main>

</body>
</html>
