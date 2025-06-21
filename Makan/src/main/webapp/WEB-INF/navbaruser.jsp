<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
<meta charset="UTF-8" />
<title>قاعتي</title>
<script src="https://cdn.tailwindcss.com"></script>
<style>
  @import url('https://fonts.googleapis.com/css2?family=Cairo:wght@400;700&display=swap');

  body {
    font-family: 'Cairo', sans-serif;
  }

  #site-title {
    font-size: 2.5rem;
    font-weight: 900;
    background: linear-gradient(90deg, #4f46e5, #0ea5e9);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
  }

  .btn-logout {
    background: linear-gradient(to right, #6366f1, #0ea5e9);
    color: white;
    padding: 10px 24px;
    font-weight: 700;
    border-radius: 9999px;
    box-shadow: 0 4px 15px rgba(14, 165, 233, 0.4);
    transition: transform 0.2s ease, box-shadow 0.3s ease;
  }

  .btn-logout:hover {
    transform: scale(1.05);
    box-shadow: 0 6px 20px rgba(79, 70, 229, 0.4);
  }
</style>
</head>
<body>

<header class="sticky top-0 z-50 backdrop-blur-lg bg-white/70 border-b border-black/10 shadow-md">
  <div class="max-w-7xl mx-auto px-6 py-4 flex justify-between items-center">

    <!-- الجهة اليمين: زر ☰ + العنوان -->
    <div class="flex items-center gap-4">
      <!-- زر الشريط الجانبي (☰) -->
<button id="sidebarToggleBtn" onclick="toggleSidebar()" 
    class="text-indigo-800 hover:text-indigo-600 focus:outline-none text-3xl ml-4">
    &#9776;
</button>

      <!-- العنوان -->
      <h1 id="site-title" class="select-none cursor-default">قاعتي</h1>
    </div>

    <!-- الجهة اليسار: تسجيل الخروج -->
    <nav>
      <form action="/venue/logout" method="post">
        <button type="submit" class="btn-logout">
          🚪 تسجيل الخروج
        </button>
      </form>
    </nav>
  </div>
</header>

</body>
</html>
