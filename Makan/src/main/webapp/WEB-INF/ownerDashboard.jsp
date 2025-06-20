<!DOCTYPE html>
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
            <h2 class="text-3xl font-bold text-indigo-800 mb-6 text-center">قاعاتي</h2>
            <c:if test="${empty venues}">
                <p class="text-center text-gray-600">لا توجد قاعات حالياً.</p>
            </c:if>
            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-8">
                <c:forEach items="${venues}" var="v">
                    <div class="bg-white shadow-lg rounded-2xl overflow-hidden hover:shadow-2xl transition-shadow duration-300 flex flex-col">
                        <div class="relative h-56 overflow-hidden">
                            <c:choose>
                                <c:when test="${not empty v.imageUrl}">
                                    <img src="${v.imageUrl[0]}" alt="صورة القاعة" class="object-cover w-full h-full">
                                </c:when>
                                <c:otherwise>
                                    <div class="bg-gray-200 w-full h-full flex items-center justify-center text-gray-500">
                                        لا توجد صورة
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="p-6 flex-1 flex flex-col justify-between">
                            <div>
                                <h3 class="text-2xl font-semibold text-gray-800 mb-2">${v.name}</h3>
                                <p class="text-gray-600 mb-1">📍 ${v.city} - ${v.village}</p>
                                <p class="text-gray-600 mb-1">💰 ${v.pricePerDay} شيكل / اليوم</p>
                                <p class="text-gray-600">👥 السعة: ${v.capacity} شخص</p>
                            </div>
                            <div class="flex justify-between items-center pt-4 border-t mt-6">
                                <a href="/halls/view/${v.id}" class="text-indigo-600 font-medium hover:underline">✏️ تعديل</a>
                                <form action="/venue/delete/${v.id}" method="post" onsubmit="return confirm('هل أنت متأكد من حذف هذه القاعة؟');">
                                    <button type="submit" class="text-red-600 font-medium hover:underline">🗑️ حذف</button>
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
                                <td class="py-2 px-4">${b.user.firstname} ${b.user.lastname}</td>
                                <td class="py-2 px-4">${b.eventDate}</td>
                                <td class="py-2 px-4">${b.status}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </section>

        <!-- قسم الدردشات -->
        <section class="mt-10">
            <h2 class="text-2xl font-semibold text-gray-800 mb-4">الدردشات مع المستخدمين</h2>
            <div class="bg-white shadow rounded overflow-x-auto">
                <table class="min-w-full text-right">
                    <thead>
                        <tr class="bg-gray-200 text-gray-700">
                            <th class="py-2 px-4">اسم المستخدم</th>
                            <th class="py-2 px-4">آخر رسالة</th>
                            <th class="py-2 px-4">آخر تحديث</th>
                            <th class="py-2 px-4">الإجراء</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${chatSummaries}" var="chat">
                            <tr class="border-b">
                                <td class="py-2 px-4">${chat.senderName}</td>
                                <td class="py-2 px-4 truncate max-w-xs" title="${chat.lastMessage}">${chat.lastMessage}</td>
                                <td class="py-2 px-4">${chat.lastTimestamp}</td>
                                <td class="py-2 px-4">
                                    <a href="/owner/chat/${chat.chatId}" class="text-indigo-600 font-medium hover:underline">الدردشة</a>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty chatSummaries}">
                            <tr>
                                <td colspan="4" class="py-4 text-center text-gray-500">لا توجد دردشات بعد.</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </section>

    </main>
</body>
</html>
