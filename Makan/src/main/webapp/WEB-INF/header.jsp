<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
    background: linear-gradient(135deg, #f0f4f8, #d9e2ec, #bcccdc);
    min-height: 100vh;
    margin: 0;
    padding: 0;
    color: #333; /* نص داكن للوضوح */
  }
  header {
    backdrop-filter: blur(15px);
    background: rgba(255 255 255 / 0.7);
    border-bottom: 1px solid rgba(0 0 0 / 0.1);
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
  }
  #site-title {
    color: #0c6efd; /* أزرق قوي هادئ */
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
  button#langToggle {
    border: 2px solid #0c6efd;
    background: transparent;
    color: #0c6efd;
    padding: 8px 16px;
    border-radius: 9999px;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.3s ease;
  }
  button#langToggle:hover {
    background: #0c6efd;
    color: white;
  }

#scrollTopBtn {
  position: fixed;
  bottom: 30px;
  right: 30px;
  left: auto;
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


  /* Responsive */
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
    <h1 id="site-title" class="select-none cursor-default">قاعتي</h1>
    <nav class="flex items-center gap-8 font-medium">
      <a href="/" tabindex="0">الرئيسية</a>
      <a href="/about" tabindex="0">نبذة عنا</a>
      <a href="/terms" tabindex="0">الأحكام والشروط</a>
      <a href="/contactus" tabindex="0">تواصل معنا</a>
      <a href="/login" class="btn-register" tabindex="0">سجّل الآن</a>
      <button id="langToggle" onclick="toggleLanguage()" aria-label="تبديل اللغة" tabindex="0">EN</button>
    </nav>
  </div>
</header>

<!-- زر العودة لأعلى الصفحة -->
<!-- زر العودة لأعلى الصفحة مع أيقونة SVG -->
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
