<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8" />
    <title>لوحة تحكم المالك</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Cairo:wght@400;700&display=swap" rel="stylesheet" />
    <style>
        body {
            font-family: 'Cairo', sans-serif;
            background: linear-gradient(to bottom right, #f3e8ff, #e0f2fe);
            min-height: 100vh;
        }

        /* بطاقات القاعات */
        .venue-card {
            transition: all 0.4s ease;
            border-radius: 24px;
            box-shadow: 0 6px 20px rgb(99 102 241 / 0.3);
        }

        .venue-card:hover {
            transform: translateY(-8px) scale(1.02);
            box-shadow: 0 10px 30px rgb(99 102 241 / 0.5);
        }

        /* تدرج ألوان الهيدر */
        header {
            background: rgba(99, 102, 241, 0.85);
            backdrop-filter: saturate(180%) blur(10px);
            border-bottom: 1px solid #6366f1;
        }

        header h1 {
            color: #eef2ff;
            text-shadow: 0 0 10px rgb(99 102 241);
        }

        /* زر الحجز */
        .btn-book {
            background: linear-gradient(90deg, #6366f1, #3b82f6);
            color: white;
            font-weight: 700;
            padding: 0.5rem 1.5rem;
            border-radius: 9999px;
            box-shadow: 0 4px 10px rgb(99 102 241 / 0.6);
            transition: background 0.3s ease;
        }
        .btn-book:hover {
            background: linear-gradient(90deg, #4338ca, #2563eb);
            box-shadow: 0 6px 15px rgb(67 56 202 / 0.8);
        }

        /* جدول الحجوزات والدردشات */
        table {
            border-collapse: separate;
            border-spacing: 0 8px;
            font-size: 1rem;
            width: 100%;
        }

        thead tr th {
            background: #c7d2fe; /* لون أزرق فاتح */
            color: #3730a3;
            padding: 12px 16px;
            font-weight: 700;
            border-radius: 12px 12px 0 0;
            text-align: right;
        }

        tbody tr {
            background: white;
            border-radius: 20px;
            box-shadow: 0 4px 12px rgb(147 197 253 / 0.4);
            transition: background 0.3s ease;
        }

        tbody tr:hover {
            background: #e0e7ff;
        }

        tbody tr td {
            padding: 12px 16px;
            vertical-align: middle;
            color: #1e293b;
        }

        /* زر العودة لأعلى */
        #scrollTopBtn {
            background: linear-gradient(90deg, #6366f1, #3b82f6);
            box-shadow: 0 6px 15px rgb(99 102 241 / 0.8);
        }
        #scrollTopBtn:hover {
            background: linear-gradient(90deg, #4338ca, #2563eb);
            transform: scale(1.15);
            #site-title {
  user-select: none;
}

nav a {
  color: #555;
  font-weight: 600;
  text-decoration: none;
  border-radius: 12px;
}

nav a:hover,
nav a:focus {
  color: #4f46e5;
  background: rgba(79, 70, 229, 0.12);
  outline: none;
}

.btn-register {
    background: linear-gradient(90deg, #6366f1, #0ea5e9);
    color: white;
    font-weight: 700;
    padding: 10px 24px;
    border-radius: 9999px;
    box-shadow: 0 4px 15px rgba(14, 165, 233, 0.4);
    border: none;
    cursor: pointer;
    transition: transform 0.2s ease, box-shadow 0.3s ease;
    font-size: 1rem;
  }

  .btn-register:hover,
  .btn-register:focus {
    transform: scale(1.05);
    box-shadow: 0 6px 20px rgba(79, 70, 229, 0.5);
    outline: none;
  }
  box-shadow: 0 6px 20px rgba(79, 70, 229, 0.5);
}
            
        }
    </style>
</head>
<body>
<c:choose>
    <c:when test="${user.role == 'admin'}">
        <jsp:include page="navbarlogin.jsp" />
    </c:when>
    <c:when test="${user.role == 'owner'}">
        <jsp:include page="navbarowner.jsp" />
    </c:when>
    <c:otherwise>
        <jsp:include page="navbaruser.jsp" />
    </c:otherwise>
</c:choose>



<main class="max-w-7xl mx-auto p-6 space-y-16">

    <div class="max-w-7xl mx-auto p-6 grid grid-cols-1 lg:grid-cols-2 gap-10">


    <!-- قاعاتي -->
    <section>
        <c:if test="${empty venues}">
            <p class="text-center text-gray-500 text-xl">لا توجد قاعات حالياً.</p>
        </c:if>

        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-1 gap-10">
            <c:forEach items="${venues}" var="v">
                <div class="venue-card bg-white overflow-hidden flex flex-col shadow-lg">
                    <div class="h-56 overflow-hidden rounded-t-3xl">
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
                    <div class="p-6 flex flex-col justify-between flex-1 text-right">
                        <div>
                            <h3 class="text-2xl font-bold text-indigo-800 mb-3">${v.name}</h3>
                            <p class="text-gray-700 mb-1">📍 ${v.city} - ${v.village}</p>
                            <p class="text-green-700 mb-1 font-semibold">💰 ${v.pricePerDay} شيكل / اليوم</p>
                            <p class="text-blue-700">👥 السعة: ${v.capacity} شخص</p>
                        </div>

                        <div class="mt-5 flex justify-between items-center border-t border-indigo-100 pt-4">
                            <a href="/book?venueId=${v.id}" class="btn-book">
                                🏷️ احجز القاعة
                            </a>

                            <div class="space-x-4">
                                <a href="/halls/view/${v.id}" class="text-indigo-700 font-semibold hover:underline">✏️ تعديل</a>
                          <!--       <form action="/venue/delete/${v.id}" method="post" class="inline" onsubmit="return confirm('هل أنت متأكد من حذف هذه القاعة؟');">
                                    <button type="submit" class="text-red-600 font-semibold hover:underline">🗑️ حذف</button>
                                </form>-->
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </section>

    <!-- سكشن الترحيب -->
<section class="bg-indigo-100 bg-opacity-40 backdrop-blur-md rounded-3xl shadow-lg text-right p-6 flex flex-col justify-center items-center space-y-4" style="min-height: 140px;">
    <h2 class="text-3xl font-extrabold text-indigo-900 select-none text-center w-full drop-shadow-md">
        مرحبًا بك، <span class="text-indigo-700">${user.firstname}</span>! 👋
    </h2>
    <p class="text-indigo-800 text-base leading-relaxed max-w-xl text-center drop-shadow-sm">
        يسعدنا وجودك في لوحة التحكم الخاصة بك. من هنا يمكنك إدارة قاعاتك بكل سهولة ويسر، متابعة الحجوزات الحصرية، والتواصل المباشر مع العملاء لضمان أفضل تجربة. استمتع بتجربة استخدام مريحة وفعالة تحقق لك أفضل النتائج وتنمي عملك بثقة.
    </p>
</section>


</div>

  

    <!-- الحجوزات -->
    <section>
        <h2 class="text-indigo-700 text-3xl font-bold mb-8 text-right">الحجوزات على قاعاتي</h2>
        <c:if test="${empty bookings}">
            <p class="text-center text-gray-500 text-xl">لا توجد حجوزات حالياً.</p>
        </c:if>
        <div class="overflow-x-auto bg-white shadow-xl rounded-3xl p-4">
            <table>
                <thead>
                    <tr>
                        <th>القاعة</th>
                        <th>اسم المستخدم</th>
                        <th>رقم الجوال</th>
                        <th>تاريخ الحجز</th>
                        <th>الحالة</th>
                        <th>الملاحظات</th>
                        <th>الإجراء</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${bookings}" var="b">
                        <tr>
                            <td>${b.venue.name}</td>
                            <td>${b.user.firstname} ${b.user.lastname}</td>
                            <td>${b.phoneNumber}</td>
                            <td>${b.eventDate}</td>
                            <td>${b.eventType}</td>
                            <td>${b.note}</td>
                            <td>
                                <form action="/booking/delete" method="post" onsubmit="return confirm('هل أنت متأكد من حذف هذا الحجز؟');">
                                    <input type="hidden" name="bookingId" value="${b.id}" />
                                    <button type="submit" class="text-red-600 font-semibold hover:underline">🗑️ حذف</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </section>

    <!-- الدردشات -->
    <section>
        <h2 class="text-indigo-700 text-3xl font-bold mb-8 text-right">الدردشات مع المستخدمين</h2>
        <div class="overflow-x-auto bg-white shadow-xl rounded-3xl p-4">
            <table>
                <thead>
                    <tr>
                        <th>اسم المستخدم</th>
                        <th>آخر رسالة</th>
                        <th>آخر تحديث</th>
                        <th>الإجراء</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${chatSummaries}" var="chat">
                        <tr>
                            <td>${chat.senderName}</td>
                            <td class="truncate max-w-xs" title="${chat.lastMessage}">${chat.lastMessage}</td>
                            <td>${chat.lastTimestamp}</td>
                            <td>
                                <a href="/owner/chat/${chat.chatId}" class="text-indigo-700 font-semibold hover:underline">الدردشة</a>
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
        class="fixed bottom-8 right-8 p-3 rounded-full shadow-lg transition transform hover:scale-110 z-50"
        onclick="window.scrollTo({ top: 0, behavior: 'smooth' });">
    <svg xmlns="http://www.w3.org/2000/svg" class="w-7 h-7 stroke-white" fill="none" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round" viewBox="0 0 24 24">
        <polyline points="6 15 12 9 18 15" />
    </svg>
</button>

<jsp:include page="footer.jsp" />

</body>
</html>
