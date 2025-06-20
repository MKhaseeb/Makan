<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8">
    <title>لوحة تحكم المالك</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Cairo:wght@400;700&display=swap');
        body {
            font-family: 'Cairo', sans-serif;
            background: linear-gradient(135deg, #f0f4f8, #d9e2ec, #bcccdc);
            color: #333;
        }
        header {
            backdrop-filter: blur(15px);
            background: rgba(255, 255, 255, 0.8);
            border-bottom: 1px solid rgba(0, 0, 0, 0.05);
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
        }
        #site-title {
            color: #4f46e5;
            font-size: 2rem;
            font-weight: 900;
        }
        nav a {
            position: relative;
            padding: 8px 12px;
            transition: color 0.3s ease;
            border-radius: 8px;
            color: #444;
            font-weight: 600;
        }
        nav a:hover {
            color: #4f46e5;
            background: rgba(79, 70, 229, 0.1);
        }
        #scrollTopBtn {
            position: fixed;
            bottom: 30px;
            right: 30px;
            background-color: #4f46e5;
            border: none;
            padding: 12px;
            border-radius: 50%;
            cursor: pointer;
            box-shadow: 0 4px 15px rgba(79, 70, 229, 0.5);
            transition: background-color 0.3s ease, transform 0.2s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 1000;
        }
        #scrollTopBtn:hover {
            background-color: #3730a3;
            transform: scale(1.1);
        }
        #scrollTopBtn svg {
            stroke: white;
        }
    </style>
</head>
<body class="min-h-screen">

<!-- هيدر احترافي -->
<header class="sticky top-0 z-50">
    <div class="max-w-7xl mx-auto px-6 py-4 flex justify-between items-center">
        <h1 id="site-title" class="select-none cursor-default">لوحة تحكم المالك</h1>

        <nav class="flex items-center gap-6">
            <a href="/venue" class="hover:text-indigo-600">إضافة قاعة</a>
            <form action="/venue/logout" method="post">
                <button type="submit"
                        class="bg-red-600 hover:bg-red-700 text-white font-bold py-2 px-4 rounded-full shadow-lg transition duration-300">
                    تسجيل الخروج
                </button>
            </form>
        </nav>
    </div>
</header>

<!-- المحتوى الرئيسي -->
<main class="p-6 max-w-7xl mx-auto">

    <!-- قاعاتي -->
    <section class="mb-12">
        <h2 class="text-3xl font-bold text-indigo-800 mb-6 text-center">قاعاتي</h2>
        <c:if test="${empty venues}">
            <p class="text-center text-gray-600">لا توجد قاعات حالياً.</p>
        </c:if>
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-8">
            <c:forEach items="${venues}" var="v">
                <div class="bg-white shadow-lg rounded-2xl overflow-hidden hover:shadow-2xl transition flex flex-col">
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

    <!-- الحجوزات -->
    <section class="mb-12">
        <h2 class="text-2xl font-semibold text-indigo-800 mb-4">الحجوزات على قاعاتي</h2>
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

    <!-- الدردشات -->
    <section>
        <h2 class="text-2xl font-semibold text-indigo-800 mb-4">الدردشات مع المستخدمين</h2>
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

<!-- زر العودة لأعلى -->
<button id="scrollTopBtn" aria-label="العودة لأعلى" title="العودة لأعلى" onclick="scrollToTop()">
    <svg xmlns="http://www.w3.org/2000/svg" fill="none" stroke="white" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round" width="24" height="24" viewBox="0 0 24 24">
        <polyline points="6 15 12 9 18 15"></polyline>
    </svg>
</button>

<script>
    function scrollToTop() {
        window.scrollTo({ top: 0, behavior: 'smooth' });
    }
</script>

</body>
</html>
