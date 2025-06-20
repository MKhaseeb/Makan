<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>قاعتي - Footer</title>
<script src="https://cdn.tailwindcss.com"></script>
<style>
  @import url('https://fonts.googleapis.com/css2?family=Cairo:wght@400;700&display=swap');
  body {
    font-family: 'Cairo', sans-serif;
  }
  /* تأثير بسيط عند المرور على الأيقونات */
  .social-icon:hover {
    color: #3b82f6; /* أزرق Tailwind */
    transform: scale(1.1);
    transition: transform 0.2s ease, color 0.2s ease;
  }
</style>
</head>
<body>

<footer class="bg-gray-900 text-gray-300 py-6 mt-12">
  <div class="max-w-7xl mx-auto px-4 grid grid-cols-1 md:grid-cols-3 gap-6 text-center md:text-right">
    <div>
      <h4 class="text-xl font-semibold mb-2 text-white" data-i18n="site_title">قاعتي</h4>
<p class="text-xs leading-tight" data-i18n="footer_about">
  قاعتي هي منصتك الذكية لحجز القاعات في فلسطين. نوفّر لك أفضل الأماكن بأسعار منافسة،  
  وخدمات مميزة لتجربة حجز سهلة وسريعة. مناسبتك تبدأ من هنا!
</p>

    </div>
    <div>
      <h4 class="text-xl font-semibold mb-2 text-white" data-i18n="quick_links">روابط سريعة</h4>
      <ul class="space-y-2 text-sm">
        <li><a href="/about" class="hover:text-blue-400 transition duration-200 font-medium" data-i18n="about">نبذة عنا</a></li>
        <li><a href="/terms" class="hover:text-blue-400 transition duration-200 font-medium" data-i18n="terms">الأحكام والشروط</a></li>
        <li><a href="/contactus" class="hover:text-blue-400 transition duration-200 font-medium" data-i18n="payment">تواصل معنا</a></li>
        <li><a href="/login" class="hover:text-blue-400 transition duration-200 font-medium" data-i18n="register">سجّل الآن</a></li>
      </ul>
    </div>
    <div>
      <h4 class="text-xl font-semibold mb-2 text-white" data-i18n="contact_us">تواصل معنا</h4>
           <ul class="text-sm space-y-3">
        <li class="flex items-center justify-center md:justify-start gap-2">
          <span class="text-blue-400">📞</span>
          <span>00970 525 789</span>
        </li>
        <li class="flex items-center justify-center md:justify-start gap-2">
          <span class="text-blue-400">📧</span>
          <span>info@qa3ti.ps</span>
        </li>
        <li class="flex items-center justify-center md:justify-start gap-2">
          <span class="text-blue-400">📍</span>
          <span>فلسطين</span>
        </li>
      </ul>

      <!-- روابط التواصل الاجتماعي -->
      <div class="flex justify-center md:justify-start space-x-6 rtl:space-x-reverse">
        <a href="https://www.facebook.com/qa3ti" target="_blank" rel="noopener" aria-label="فيسبوك" class="social-icon text-gray-300 hover:text-blue-600">
          <svg xmlns="http://www.w3.org/2000/svg" fill="currentColor" class="h-6 w-6" viewBox="0 0 24 24">
            <path d="M22 12a10 10 0 1 0-11.5 9.87v-6.98H8v-2.89h2.5V9.5a3.5 3.5 0 0 1 3.76-3.85 15.04 15.04 0 0 1 2.2.2v2.41h-1.25c-1 0-1.3.62-1.3 1.25v1.5h2.5l-.4 2.89h-2.1v6.98A10 10 0 0 0 22 12z"/>
          </svg>
        </a>
        <a href="https://www.instagram.com/qa3ti" target="_blank" rel="noopener" aria-label="إنستاجرام" class="social-icon text-gray-300 hover:text-pink-500">
          <svg xmlns="http://www.w3.org/2000/svg" fill="currentColor" class="h-6 w-6" viewBox="0 0 24 24">
            <path d="M7 2C4.243 2 2 4.243 2 7v10c0 2.757 2.243 5 5 5h10c2.757 0 5-2.243 5-5V7c0-2.757-2.243-5-5-5H7zm10 3a1 1 0 1 1 0 2 1 1 0 0 1 0-2zm-5 3.5a4.5 4.5 0 1 1 0 9 4.5 4.5 0 0 1 0-9zm0 2a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5z"/>
          </svg>
        </a>
        <a href="https://wa.me/970525789" target="_blank" rel="noopener" aria-label="واتساب" class="social-icon text-gray-300 hover:text-green-500">
          <svg xmlns="http://www.w3.org/2000/svg" fill="currentColor" class="h-6 w-6" viewBox="0 0 24 24">
            <path d="M20.52 3.48a11.42 11.42 0 0 0-16.12 0c-4.49 4.5-4.49 11.82 0 16.32l-1.8 5.52 5.68-1.48a11.47 11.47 0 0 0 11.1-4.62 11.42 11.42 0 0 0 1.04-11.74zm-9.67 13.9a7.07 7.07 0 0 1-3.7-1.03l-.26-.16-2.2.56.59-2.17-.17-.28a7.05 7.05 0 0 1 1.12-8.82 6.96 6.96 0 0 1 9.9-.23 6.97 6.97 0 0 1-5.98 11.33z"/>
            <path d="M15.9 14.3a1.08 1.08 0 0 1-1.5.28 6.27 6.27 0 0 1-1.92-2.28 1.08 1.08 0 0 1 .27-1.51l.92-.7a.56.56 0 0 0 .21-.54.55.55 0 0 0-.7-.47l-1.12.2a1.87 1.87 0 0 0-1.5 1.17 3.12 3.12 0 0 0 1.12 3.77 3.21 3.21 0 0 0 3.41.28z"/>
          </svg>
        </a>
      </div>
    </div>
  </div>

  <div class="border-t border-gray-700 mt-8 pt-4 text-center text-xs text-gray-500 select-none">
    &copy; <%= java.time.Year.now() %> <span data-i18n="site_title">قاعتي</span>. <span data-i18n="rights">جميع الحقوق محفوظة.</span>
  </div>
</footer>

</body>
</html>
