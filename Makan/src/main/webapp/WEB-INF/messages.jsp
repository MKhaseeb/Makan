<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
  <meta charset="UTF-8">
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
  </style>
</head>

<body class="bg-gray-100">

<!-- ✅ الهيدر -->
<header class="sticky top-0 z-50 bg-white shadow backdrop-blur-sm bg-opacity-70 border-b border-gray-200">
  <div class="max-w-7xl mx-auto px-6 py-4 flex justify-between items-center">
    <h1 class="text-3xl font-extrabold text-blue-600 select-none cursor-default">قاعتي</h1>
    <div class="flex items-center gap-6 text-gray-700 font-medium">
      <a href="/admin/owners" class="hover:text-blue-600 transition">إدارة المالكين</a>
      <a href="/venue" class="hover:text-blue-600 transition">إضافة قاعة</a>
      <a href="/message" class="hover:text-blue-600 relative transition">
        رسالة
        <c:if test="${hasUnreadMessages}">
          <span class="absolute -top-1 -right-2 w-3 h-3 bg-red-600 rounded-full animate-ping"></span>
          <span class="absolute -top-1 -right-2 w-3 h-3 bg-red-600 rounded-full"></span>
        </c:if>
      </a>
    </div>
    <form action="/venue/logout" method="post">
      <button type="submit"
              class="bg-red-600 hover:bg-red-700 text-white font-bold py-2 px-5 rounded-full shadow-lg transition duration-300">
        تسجيل الخروج
      </button>
    </form>
  </div>
</header>

<!-- ✅ المحتوى -->
<main>
  <div class="max-w-4xl mx-auto p-6">

    <h1 class="text-3xl font-bold text-indigo-700 mb-8">رسائلك</h1>

    <div class="space-y-4">
      <c:forEach var="msg" items="${messages}">
        <div class="relative overflow-hidden rounded-xl shadow bg-white" data-id="${msg.id}">
          <div class="absolute inset-0 flex items-center justify-center bg-gray-100 text-red-600 text-2xl font-bold transition-all duration-300 delete-bg z-0">حذف</div>
          <div class="relative z-10 p-5 cursor-pointer message-card select-none touch-pan-y">
            <p class="mb-1"><span class="font-semibold text-gray-700">الاسم:</span> ${msg.name}</p>
            <p class="mb-1"><span class="font-semibold text-gray-700">البريد:</span> ${msg.email}</p>
            <p class="mb-1"><span class="font-semibold text-gray-700">الهاتف:</span> ${msg.phone}</p>
            <p class="mb-2"><span class="font-semibold text-gray-700">الرسالة:</span> ${msg.message}</p>
            <p class="text-sm text-gray-500">بتاريخ: ${msg.sentAt}</p>
          </div>
        </div>
      </c:forEach>
    </div>

  </div>
</main>

<!-- ✅ المودال -->
<div id="deleteModal" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center hidden z-50">
  <div class="bg-white rounded-xl p-8 w-80 shadow-lg text-center">
    <h2 class="text-2xl font-bold text-red-600 mb-4">تأكيد الحذف</h2>
    <p class="text-gray-700 mb-6">هل تريد حذف هذه الرسالة؟</p>
    <div class="flex justify-center gap-4">
      <button id="confirmDelete" class="bg-red-600 text-white px-5 py-2 rounded-lg hover:bg-red-700 transition">حذف</button>
      <button id="cancelDelete" class="bg-gray-300 text-gray-800 px-5 py-2 rounded-lg hover:bg-gray-400 transition">إلغاء</button>
    </div>
  </div>
</div>

<!-- ✅ الفوتر الثابت -->
<jsp:include page="/WEB-INF/footer.jsp" />
<!-- ✅ السكربت -->
<script>
  let startX, currentCard, wrapper, bg, isDragging = false;
  let deleteTargetWrapper = null;

  function updateBg(diffX) {
    if (!bg) return;
    let percent = Math.min(Math.abs(diffX) / 120, 1);
    let r = Math.floor(248 - percent * (248 - 220));
    let g = Math.floor(248 - percent * (248 - 38));
    let b = Math.floor(248 - percent * (248 - 38));
    bg.style.backgroundColor = `rgb(${r},${g},${b})`;
  }

  function resetCard() {
    if (currentCard) {
      currentCard.style.transition = 'transform 0.2s ease';
      currentCard.style.transform = 'translateX(0)';
    }
    if (bg) bg.style.backgroundColor = '#f8f8f8';
    setTimeout(() => {
      if (currentCard) currentCard.style.transition = '';
    }, 200);
  }

  function showDeleteModal(wrapperToDelete) {
    deleteTargetWrapper = wrapperToDelete;
    document.getElementById('deleteModal').classList.remove('hidden');
  }

  function closeDeleteModal() {
    document.getElementById('deleteModal').classList.add('hidden');
    resetCard();
  }

  function deleteCard() {
    let id = deleteTargetWrapper.dataset.id;
    fetch(`/deleteMessage?id=${id}`, { method: 'POST' })
      .then(r => r.json())
      .then(data => {
        if (data.success) {
          deleteTargetWrapper.remove();
        } else {
          alert('فشلت عملية الحذف');
        }
        closeDeleteModal();
      })
      .catch(() => {
        alert('حدث خطأ أثناء الحذف');
        closeDeleteModal();
      });
  }

  function startDrag(e, cardEl) {
    startX = e.type.includes('mouse') ? e.clientX : e.touches[0].clientX;
    currentCard = cardEl;
    wrapper = cardEl.closest('div[data-id]');
    bg = wrapper.querySelector('.delete-bg');
    isDragging = true;

    document.addEventListener(e.type.includes('mouse') ? 'mousemove' : 'touchmove', onMove);
    document.addEventListener(e.type.includes('mouse') ? 'mouseup' : 'touchend', onEnd);
  }

  function onMove(e) {
    if (!isDragging) return;
    let clientX = e.type.includes('mouse') ? e.clientX : e.touches[0].clientX;
    let diffX = clientX - startX;
    currentCard.style.transform = `translateX(${diffX}px)`;
    updateBg(diffX);
  }

  function onEnd(e) {
    if (!isDragging) return;
    let clientX = e.type.includes('mouse') ? (e.clientX ?? startX) : e.changedTouches[0].clientX;
    let diffX = clientX - startX;

    if (Math.abs(diffX) > 100) {
      showDeleteModal(wrapper);
    } else {
      resetCard();
    }

    isDragging = false;
    document.removeEventListener(e.type.includes('mouse') ? 'mousemove' : 'touchmove', onMove);
    document.removeEventListener(e.type.includes('mouse') ? 'mouseup' : 'touchend', onEnd);
  }

  document.querySelectorAll('.message-card').forEach(card => {
    card.addEventListener('mousedown', e => startDrag(e, card));
    card.addEventListener('touchstart', e => startDrag(e, card));
  });

  document.getElementById('confirmDelete').addEventListener('click', deleteCard);
  document.getElementById('cancelDelete').addEventListener('click', closeDeleteModal);

  document.addEventListener('selectstart', e => {
    if (isDragging) e.preventDefault();
  });
</script>

</body>
</html>
