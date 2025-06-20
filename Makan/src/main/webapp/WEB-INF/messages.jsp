<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
  <meta charset="UTF-8" />
  <title>رسائلك</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <style>
    body {
      display: flex;
      flex-direction: column;
      min-height: 100vh;
    }
    main {
      flex: 1;
    }
    .message-card {
      transition: transform 0.3s ease, opacity 0.3s ease;
      touch-action: pan-y;
      user-select: none;
      cursor: grab;
    }
    .message-card:active {
      cursor: grabbing;
    }
  </style>
</head>

<body class="bg-gray-100">

<jsp:include page="navbarlogin.jsp" />

<!-- المحتوى -->
<main>
  <div class="max-w-4xl mx-auto p-6">
    <h1 class="text-3xl font-bold text-indigo-700 mb-8">جميع الرسائل</h1>

    <div class="space-y-4">
      <c:forEach var="msg" items="${messages}">
<div id="msg-${msg.id}" class="relative overflow-hidden rounded-xl shadow bg-white mb-4">
  <div class="p-5 message-card select-none touch-pan-y rounded-xl flex items-center gap-4">
    <!-- سهم يمين -->
    <div class="flex-shrink-0 text-indigo-500" style="font-size: 2rem;">
      &#8594; <!-- سهم يمين -->
    </div>

    <div class="flex-grow">
      <p class="mb-1"><span class="font-semibold text-gray-700">الاسم:</span> ${msg.name}</p>
      <p class="mb-1"><span class="font-semibold text-gray-700">البريد:</span> ${msg.email}</p>
      <p class="mb-1"><span class="font-semibold text-gray-700">الهاتف:</span> ${msg.phone}</p>
      <p class="mb-2"><span class="font-semibold text-gray-700">الرسالة:</span> ${msg.message}</p>
      <p class="text-sm text-gray-500">بتاريخ: <fmt:formatDate value="${msg.sentAtAsDate}" pattern="yyyy-MM-dd" /></p>
    </div>
  </div>

  <!-- رسالة "اسحب لليمين للحذف" -->
<div class="absolute inset-y-0 left-0 flex items-center pl-4 pointer-events-none select-none text-indigo-300 font-semibold text-lg opacity-70">
  اسحب لليمين للحذف
</div>

</div>

      </c:forEach>
    </div>
  </div>
</main>

<jsp:include page="/WEB-INF/footer.jsp" />

<!-- صندوق الإشعار (Toast) -->
<div id="toast" class="fixed bottom-5 left-1/2 -translate-x-1/2 bg-indigo-600 text-white px-5 py-3 rounded shadow-lg opacity-0 pointer-events-none transition-opacity duration-300 z-50"></div>

<script>
  // دالة عرض الإشعار (Toast)
  function showToast(message) {
    const toast = document.getElementById('toast');
    toast.textContent = message;
    toast.classList.remove('opacity-0');
    toast.classList.add('opacity-100');

    setTimeout(() => {
      toast.classList.remove('opacity-100');
      toast.classList.add('opacity-0');
    }, 3000);
  }

  // دالة حذف رسالة من السيرفر والواجهة
  function deleteMessage(id, cardElement) {
    fetch('/deleteMessage', {
      method: 'POST',
      headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
      body: 'id=' + encodeURIComponent(id)
    })
    .then(response => response.json())
    .then(data => {
      if (data.success) {
        cardElement.style.transition = 'transform 0.5s ease, opacity 0.5s ease';
        cardElement.style.transform = 'translateX(100%)';
        cardElement.style.opacity = '0';
        setTimeout(() => {
          const el = document.getElementById('msg-' + id);
          if (el) el.remove();
        }, 500);
        showToast('تم حذف الرسالة بنجاح');
      } else {
        alert('فشل حذف الرسالة.');
        cardElement.style.transform = 'translateX(0)';
        cardElement.style.opacity = '1';
      }
    })
    .catch(err => {
      alert('حدث خطأ أثناء الحذف: ' + err.message);
      cardElement.style.transform = 'translateX(0)';
      cardElement.style.opacity = '1';
    });
  }

  // زر الحذف بالضغط العادي
  document.querySelectorAll('.delete-btn').forEach(button => {
    button.addEventListener('click', function() {
      const id = this.dataset.id;
      const card = this.closest('.message-card');
      deleteMessage(id, card);
    });
  });

  // التعامل مع السحب يمين لليسار (لـ RTL)
  document.querySelectorAll('.message-card').forEach(card => {
    let startX = 0;
    let currentX = 0;
    let threshold = 100; // مقدار السحب المطلوب للحذف
    let isDragging = false;

    card.addEventListener('pointerdown', e => {
      startX = e.clientX;
      isDragging = true;
      card.style.transition = 'none'; // إيقاف الانتقال أثناء السحب
    });

    card.addEventListener('pointermove', e => {
      if (!isDragging) return;
      currentX = e.clientX;
      let deltaX = currentX - startX;

      // لأن الصفحة RTL، السحب للحذف يكون بالسحب لليمين (deltaX موجب)
      if (deltaX > 0) {
        card.style.transform = `translateX(${deltaX}px)`;
        card.style.opacity = `${1 - deltaX / 300}`;
      }
    });

    card.addEventListener('pointerup', e => {
      if (!isDragging) return;
      isDragging = false;
      let deltaX = currentX - startX;
      card.style.transition = 'transform 0.3s ease, opacity 0.3s ease';

      if (deltaX > threshold) {
        let msgId = card.closest('[id^="msg-"]').id.split('-')[1];
        deleteMessage(msgId, card);
      } else {
        card.style.transform = 'translateX(0)';
        card.style.opacity = '1';
      }
    });

    card.addEventListener('pointercancel', () => {
      isDragging = false;
      card.style.transition = 'transform 0.3s ease, opacity 0.3s ease';
      card.style.transform = 'translateX(0)';
      card.style.opacity = '1';
    });
  });
</script>

</body>
</html>
