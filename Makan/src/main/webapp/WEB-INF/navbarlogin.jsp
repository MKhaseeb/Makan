<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>قاعتي</title>
<script src="https://cdn.tailwindcss.com"></script>
<script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css"/>
<style>
  @import url('https://fonts.googleapis.com/css2?family=Cairo:wght@400;700&display=swap');
  body {
    font-family: 'Cairo', sans-serif;
    background: linear-gradient(135deg, #f0f4f8, #d9e2ec, #bcccdc);
    min-height: 100vh;
    margin: 0;
    padding: 0;
    color: #333;
  }
  header {
    backdrop-filter: blur(15px);
    background: rgba(255 255 255 / 0.7);
    border-bottom: 1px solid rgba(0 0 0 / 0.1);
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
  }
  #site-title {
    color: #0c6efd;
    font-size: 2.2rem;
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
  nav a:hover,
  nav a:focus {
    color: #0c6efd;
    background: rgba(12, 110, 253, 0.1);
    outline: none;
  }
  .btn-register {
    background: #0c6efd;
    color: white;
    font-weight: 700;
    padding: 10px 20px;
    border-radius: 9999px;
    box-shadow: 0 4px 15px rgba(12, 110, 253, 0.3);
    transition: background 0.3s ease;
  }
  .btn-register:hover {
    background: #084ecf;
    box-shadow: 0 6px 20px rgba(8, 78, 207, 0.5);
  }
  #scrollTopBtn {
    position: fixed;
    bottom: 30px;
    right: 30px;
    background-color: #0c6efd;
    border: none;
    padding: 12px;
    border-radius: 50%;
    cursor: pointer;
    box-shadow: 0 4px 15px rgba(12, 110, 253, 0.5);
    transition: background-color 0.3s ease, transform 0.2s ease;
    display: flex;
    align-items: center;
    justify-content: center;
    z-index: 1000;
  }
  #scrollTopBtn:hover {
    background-color: #084ecf;
    transform: scale(1.1);
  }
  #scrollTopBtn svg {
    stroke: white;
  }
</style>
</head>
<body>

<header class="sticky top-0 z-50 bg-white shadow">
  <div class="max-w-7xl mx-auto px-6 py-4 flex justify-between items-center">
    <h1 id="site-title" class="select-none cursor-default">قاعتي</h1>

    <div class="flex items-center gap-6">
      <a href="/admin/owners" class="hover:text-blue-600">إدارة المالكين</a>
      <a href="/venue" class="hover:text-blue-600">إضافة قاعة</a>
      <a href="/message" class="hover:text-blue-600 relative">
        رسالة
        <c:if test="${hasUnreadMessages}">
          <span class="absolute -top-1 -right-2 w-3 h-3 bg-red-600 rounded-full animate-ping"></span>
          <span class="absolute -top-1 -right-2 w-3 h-3 bg-red-600 rounded-full"></span>
        </c:if>
      </a>
    </div>

    <nav class="flex items-center gap-8 font-medium">
      <form action="/venue/logout" method="post">
        <button type="submit"
                class="bg-red-600 hover:bg-red-700 text-white font-bold py-2 px-4 rounded-full shadow-lg transition duration-300">
          تسجيل الخروج
        </button>
      </form>
    </nav>
  </div>
</header>

<!-- القاعات -->
<section class="py-16 px-6">
  <div class="text-center mb-10">
    <h2 class="text-3xl font-bold text-gray-800">قاعات المناسبات</h2>
    <p class="text-gray-500 mt-2">استعرض أحدث القاعات المتوفرة للحجز</p>
  </div>

  <div class="swiper mySwiper">
    <div class="swiper-wrapper">
      <c:forEach items="${venues}" var="venue">
        <div class="swiper-slide bg-white rounded-lg shadow p-5 flex flex-col items-center text-center">
          <img src="${venue.imageUrl}" alt="قاعة ${venue.name}" class="w-full h-48 object-cover rounded mb-4">
          <h3 class="text-xl font-semibold text-gray-800">${venue.name}</h3>
          <p class="text-gray-600 mt-2">${venue.description}</p>
          <p class="text-blue-600 font-bold mt-2">${venue.price} ر.س</p>
          <a href="/venue/details/${venue.id}"
             class="mt-4 bg-blue-600 text-white px-4 py-2 rounded-full hover:bg-blue-700 transition">عرض التفاصيل</a>
        </div>
      </c:forEach>
    </div>
    <div class="swiper-pagination mt-6"></div>
  </div>
</section>

<button id="scrollTopBtn" aria-label="العودة لأعلى" title="العودة لأعلى" onclick="scrollToTop()">
  <svg xmlns="http://www.w3.org/2000/svg" fill="none" stroke="white" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round" width="24" height="24" viewBox="0 0 24 24">
    <polyline points="6 15 12 9 18 15"></polyline>
  </svg>
</button>

<script>
  function scrollToTop() {
    window.scrollTo({ top: 0, behavior: 'smooth' });
  }

  const swiper = new Swiper(".mySwiper", {
    slidesPerView: 1,
    spaceBetween: 20,
    pagination: { el: ".swiper-pagination", clickable: true },
    breakpoints: {
      640: { slidesPerView: 2 },
      1024: { slidesPerView: 3 }
    }
  });
</script>

</body>
</html>
