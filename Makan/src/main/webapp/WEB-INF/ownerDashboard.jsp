<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8" />
    <title>لوحة تحكم المالك</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Cairo:wght@400;700&display=swap');
        body {
            font-family: 'Cairo', sans-serif;
        }
    </style>
</head>
<body class="min-h-screen bg-gradient-to-br from-gray-100 via-gray-200 to-gray-300 text-gray-800">

<header class="sticky top-0 z-50 bg-white/90 backdrop-blur-md border-b border-gray-200 shadow-md">
    <div class="max-w-7xl mx-auto px-6 py-4 flex justify-between items-center">
        <h1 class="text-indigo-600 text-3xl font-extrabold select-none">لوحة تحكم المالك</h1>
        <nav class="flex items-center gap-6">
            <form action="/venue/logout" method="post">
                <button type="submit" 
                        class="bg-red-600 hover:bg-red-700 text-white font-bold py-2 px-5 rounded-full shadow-lg transition duration-300">
                    تسجيل الخروج
                </button>
            </form>
        </nav>
    </div>
</header>

<main class="max-w-7xl mx-auto p-6 space-y-12">

    <!-- قاعاتي -->
    <section>
        <h2 class="text-center text-indigo-700 text-3xl font-extrabold mb-8">قاعاتي</h2>
        <c:if test="${empty venues}">
            <p class="text-center text-gray-500 text-lg">لا توجد قاعات حالياً.</p>
        </c:if>
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-8">
            <c:forEach items="${venues}" var="v">
                <div class="bg-white rounded-2xl shadow-lg flex flex-col overflow-hidden hover:shadow-2xl transition duration-300">
                    <div class="h-56 overflow-hidden">
                        <c:choose>
                            <c:when test="${not empty v.imageUrl}">
                                <img src="${v.imageUrl[0]}" alt="صورة القاعة" loading="lazy"
                                     class="w-full h-full object-cover transition-transform duration-500 hover:scale-105" />
                            </c:when>
                            <c:otherwise>
                                <div class="bg-gray-200 w-full h-full flex items-center justify-center text-gray-400 select-none">
                                    لا توجد صورة
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="p-6 flex flex-col justify-between flex-1">
                        <div>
                            <h3 class="text-2xl font-bold text-gray-900 mb-2">${v.name}</h3>
                            <p class="text-gray-600 mb-1">📍 ${v.city} - ${v.village}</p>
                            <p class="text-gray-600 mb-1">💰 ${v.pricePerDay} شيكل / اليوم</p>
                            <p class="text-gray-600">👥 السعة: ${v.capacity} شخص</p>
                        </div>
                        <div class="mt-6 flex justify-between items-center border-t border-gray-200 pt-4">
                            <a href="/halls/view/${v.id}" class="text-indigo-600 font-semibold hover:underline">✏️ تعديل</a>
                            <form action="/venue/delete/${v.id}" method="post" onsubmit="return confirm('هل أنت متأكد من حذف هذه القاعة؟');">
                                <button type="submit" class="text-red-600 font-semibold hover:underline">🗑️ حذف</button>
                            </form>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </section>

    <!-- الحجوزات -->
    <section>
        <h2 class="text-indigo-700 text-2xl font-bold mb-6">الحجوزات على قاعاتي</h2>
        <c:if test="${empty bookings}">
            <p class="text-center text-gray-500 text-lg">لا توجد حجوزات حالياً.</p>
        </c:if>
        <div class="overflow-x-auto bg-white shadow rounded-lg">
            <table class="min-w-full text-right divide-y divide-gray-200">
                <thead class="bg-indigo-100">
                    <tr>
                        <th class="px-6 py-3 text-indigo-800 font-semibold">القاعة</th>
                        <th class="px-6 py-3 text-indigo-800 font-semibold">اسم المستخدم</th>
                        <th class="px-6 py-3 text-indigo-800 font-semibold">تاريخ الحجز</th>
                        <th class="px-6 py-3 text-indigo-800 font-semibold">الحالة</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-gray-100">
                    <c:forEach items="${bookings}" var="b">
                        <tr class="hover:bg-indigo-50 transition">
                            <td class="px-6 py-4">${b.venue.name}</td>
                            <td class="px-6 py-4">${b.user.firstname} ${b.user.lastname}</td>
                            <td class="px-6 py-4">${b.eventDate}</td>
                            <td class="px-6 py-4">${b.status}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </section>

    <!-- الدردشات -->
    <section>
        <h2 class="text-indigo-700 text-2xl font-bold mb-6">الدردشات مع المستخدمين</h2>
        <div class="overflow-x-auto bg-white shadow rounded-lg">
            <table class="min-w-full text-right divide-y divide-gray-200">
                <thead class="bg-indigo-100">
                    <tr>
                        <th class="px-6 py-3 text-indigo-800 font-semibold">اسم المستخدم</th>
                        <th class="px-6 py-3 text-indigo-800 font-semibold">آخر رسالة</th>
                        <th class="px-6 py-3 text-indigo-800 font-semibold">آخر تحديث</th>
                        <th class="px-6 py-3 text-indigo-800 font-semibold">الإجراء</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-gray-100">
                    <c:forEach items="${chatSummaries}" var="chat">
                        <tr class="hover:bg-indigo-50 transition">
                            <td class="px-6 py-4">${chat.senderName}</td>
                            <td class="px-6 py-4 truncate max-w-xs" title="${chat.lastMessage}">${chat.lastMessage}</td>
                            <td class="px-6 py-4">${chat.lastTimestamp}</td>
                            <td class="px-6 py-4">
                                <a href="/owner/chat/${chat.chatId}" class="text-indigo-600 font-semibold hover:underline">الدردشة</a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty chatSummaries}">
                        <tr>
                            <td colspan="4" class="text-center text-gray-400 py-6">لا توجد دردشات بعد.</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </section>

</main>

<!-- زر العودة لأعلى -->
<button id="scrollTopBtn" aria-label="العودة لأعلى" title="العودة لأعلى"
        class="fixed bottom-8 right-8 bg-indigo-600 p-3 rounded-full shadow-lg hover:bg-indigo-700 transition transform hover:scale-110 z-50"
        onclick="window.scrollTo({ top: 0, behavior: 'smooth' });">
    <svg xmlns="http://www.w3.org/2000/svg" class="w-7 h-7 stroke-white" fill="none" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round" viewBox="0 0 24 24">
        <polyline points="6 15 12 9 18 15" />
    </svg>
</button>
<jsp:include page="footer.jsp" />

</body>
</html>
