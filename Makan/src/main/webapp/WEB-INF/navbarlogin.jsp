<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>قاعتي</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <style>
    @import url('https://fonts.googleapis.com/css2?family=Cairo:wght@400;700&display=swap');

    body {
      font-family: 'Cairo', sans-serif;
      background: linear-gradient(135deg, #faf8f6, #f7f4f2);
      color: #333;
    }

    header {
      backdrop-filter: blur(20px);
      background: rgba(255, 255, 255, 0.85);
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.08);
      border-bottom: 1px solid rgba(0, 0, 0, 0.05);
    }

    #site-title {
      font-size: 2.5rem;
      font-weight: 900;
      background: linear-gradient(90deg, #4f46e5, #0ea5e9);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
    }

    nav a {
      position: relative;
      padding: 8px 14px;
      border-radius: 10px;
      font-weight: 600;
      color: #555;
      transition: all 0.3s ease;
    }

    nav a:hover,
    nav a:focus {
      color: #4f46e5;
      background: rgba(79, 70, 229, 0.08);
    }

    .btn-register,
    .btn-logout {
      background: linear-gradient(to right, #6366f1, #0ea5e9);
      color: white;
      padding: 10px 24px;
      font-weight: 700;
      border-radius: 9999px;
      box-shadow: 0 4px 15px rgba(14, 165, 233, 0.4);
      transition: transform 0.2s ease, box-shadow 0.3s ease;
    }

    .btn-register:hover,
    .btn-logout:hover {
      transform: scale(1.05);
      box-shadow: 0 6px 20px rgba(79, 70, 229, 0.4);
    }

    #scrollTopBtn {
      position: fixed;
      bottom: 30px;
      right: 30px;
      background: linear-gradient(to right, #6366f1, #0ea5e9);
      border: none;
      padding: 12px;
      border-radius: 50%;
      cursor: pointer;
      box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
      transition: all 0.3s ease;
      display: flex;
      align-items: center;
      justify-content: center;
      z-index: 1000;
    }

    #scrollTopBtn:hover {
      transform: scale(1.1);
    }

    #scrollTopBtn svg {
      stroke: white;
    }

    @media (max-width: 768px) {
      nav {
        gap: 12px;
        font-size: 0.9rem;
      }

      #site-title {
        font-size: 1.8rem;
      }
    }
  </style>
</head>

<body>

<header class="sticky top-0 z-50">
  <div class="max-w-7xl mx-auto px-6 py-4 flex justify-between items-center">
       <a href="/homes"><h1 id="site-title" class="select-none cursor-default">قاعتي</h1> </a>

    <div class="flex items-center gap-6">
      <a href="/homes">🏠 الرئيسية</a>
      <a href="/admin/owners">👤 إدارة المالكين</a>
      <a href="/venue">➕ إضافة قاعة</a>
<a href="/message" class="relative inline-block" id="messagesLink">
    💬 الرسائل
    <span id="unreadCountBadge" class="absolute -top-2 -right-4 bg-red-600 text-white text-xs font-bold rounded-full px-2 leading-none select-none hidden" style="min-width: 18px; text-align: center;"></span>
</a>

    </div>

    <nav class="flex items-center gap-6">
      <form action="/venue/logout" method="post">
        <button type="submit" class="btn-logout">
          🚪 تسجيل الخروج
        </button>
      </form>
    </nav>
  </div>
</header>

<!-- زر الرجوع لأعلى -->
<button id="scrollTopBtn" onclick="scrollToTop()" title="العودة لأعلى">
  <svg xmlns="http://www.w3.org/2000/svg" fill="none" stroke="white" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round" width="24" height="24" viewBox="0 0 24 24">
    <polyline points="6 15 12 9 18 15"></polyline>
  </svg>
</button>

<script>
  function scrollToTop() {
    window.scrollTo({ top: 0, behavior: 'smooth' });
  }
  async function updateUnreadCount() {
	    try {
	      const response = await fetch('/messages/unread-count');
	      if (!response.ok) throw new Error('Failed to fetch unread count');
	      const count = await response.json();

	      const badge = document.getElementById('unreadCountBadge');
	      if (count > 0) {
	        badge.textContent = count;
	        badge.classList.remove('hidden');
	      } else {
	        badge.classList.add('hidden');
	      }
	    } catch (error) {
	      console.error('Error updating unread count:', error);
	    }
	  }

	  // حدث العدّاد فور تحميل الصفحة
	  document.addEventListener('DOMContentLoaded', () => {
	    updateUnreadCount();

	    // حدث العدّاد كل 30 ثانية
	    setInterval(updateUnreadCount, 30000);
	  });
</script>

</body>
</html>
