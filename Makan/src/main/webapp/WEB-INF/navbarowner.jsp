<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- navbarowner.jsp -->
<header class="sticky top-0 z-50 backdrop-blur-lg bg-white/70 border-b border-black/10 shadow-md">
  <div class="max-w-7xl mx-auto px-6 py-4 flex justify-between items-center">
    <a href="/owner/dashboard">
      <h1 id="site-title" class="select-none cursor-default text-3xl font-extrabold text-indigo-600">
        قاعتي
      </h1>
    </a>
      <div class="flex items-center gap-6">
      <a href="/owner/dashboard">🏠 الرئيسية</a>
    
<button id="sidebarToggleBtn" onclick="toggleSidebar()" 
    class="lg:hidden text-indigo-800 hover:text-indigo-600 focus:outline-none text-3xl ml-4">
    &#9776; <!-- أيقونة الخطوط الثلاثة -->
</button>
    </div>
    <nav class="flex items-center gap-6 font-medium text-gray-700">
      <form action="/venue/logout" method="post">
        <button type="submit"
                class="bg-red-600 hover:bg-red-700 text-white font-bold py-2 px-5 rounded-full shadow transition">
          تسجيل الخروج
        </button>
      </form>
    </nav>
  </div>
</header>


</body>
</html>