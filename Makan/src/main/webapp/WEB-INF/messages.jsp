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
      background: #f4f7fa;
    }
    main {
      flex: 1;
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: flex-start;
    }

    .custom-scroll::-webkit-scrollbar {
      width: 7px;
    }
    .custom-scroll::-webkit-scrollbar-thumb {
      background: #c7d2fe;
      border-radius: 8px;
    }
    .custom-scroll {
      scrollbar-width: thin;
      scrollbar-color: #c7d2fe #e0e7ff;
    }
  </style>
</head>

<body class="bg-[#f4f7fa]">

<!-- ✅ الهيدر (لا تغيره) -->
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

<!-- ✅ المحتوى الجديد كلياً -->
<main>
  <div class="w-full max-w-2xl px-3 py-10">
    <div class="flex items-center gap-2 mb-8">
      <svg class="w-8 h-8 text-blue-400" fill="none" stroke="currentColor" stroke-width="2"
           viewBox="0 0 24 24">
        <path stroke-linecap="round" stroke-linejoin="round"
              d="M22 12c0 5.523-4.477 10-10 10S2 17.523 2 12 6.477 2 12 2s10 4.477 10 10zm-5 0a5 5 0 11-10 0 5 5 0 0110 0z" />
      </svg>
      <h1 class="text-2xl font-bold text-blue-700">رسائلك</h1>
    </div>

    <div class="rounded-2xl shadow-lg border border-blue-100 bg-white px-0 py-2">
      <div class="h-[480px] overflow-y-auto px-2 py-3 custom-scroll">
        <c:choose>
          <c:when test="${empty messages}">
            <div class="flex flex-col items-center justify-center h-40 text-gray-400 gap-2">
              <svg class="w-16 h-16" fill="none" stroke="currentColor" stroke-width="1.2" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round"
                      d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"/>
              </svg>
              <span class="text-lg">لا توجد رسائل بعد</span>
            </div>
          </c:when>
          <c:otherwise>
            <ul class="space-y-6">
              <c:forEach var="msg" items="${messages}">
                <li class="relative group" data-id="${msg.id}">

                  <div class="relative z-10 message-gradient rounded-2xl shadow border border-blue-50 p-5 flex flex-col gap-3 hover:shadow-lg message-card select-none cursor-pointer transition-all duration-200 touch-pan-y">
                    <div class="flex flex-col gap-1">
                      <span class="text-sm"><span class="font-semibold text-blue-700">الاسم:</span> ${msg.name}</span>
                      <span class="text-sm"><span class="font-semibold text-blue-700">البريد:</span> ${msg.email}</span>
                      <span class="text-sm"><span class="font-semibold text-blue-700">الهاتف:</span> ${msg.phone}</span>
                      <span class="text-sm"><span class="font-semibold text-blue-700">الرسالة:</span> ${msg.message}</span>
                    </div>
                    <div class="flex items-center justify-between mt-2">
                      <span class="text-xs text-gray-400">بتاريخ: ${msg.sentAt}</span>
                      <button type="button"
                        class="delete-btn bg-transparent text-red-500 font-bold text-xs px-2 py-1 rounded-lg hover:bg-red-100 transition"
                        title="حذف"
                        onclick="showDeleteModal(this.closest('li[data-id]'))">
                        حذف
                      </button>
                    </div>
                  </div>
                </li>
              </c:forEach>
            </ul>
          </c:otherwise>
        </c:choose>
      </div>
    </div>
  </div>
</main>

<!-- ✅ مودال تأكيد الحذف -->
<div id="deleteModal" class="fixed inset-0 bg-black bg-opacity-40 flex items-center justify-center hidden z-50">
  <div class="bg-white rounded-2xl p-8 w-80 shadow-2xl text-center">
    <h2 class="text-2xl font-extrabold text-red-600 mb-3">تأكيد الحذف</h2>
    <p class="text-gray-700 mb-6">هل تريد حذف هذه الرسالة؟</p>
    <div class="flex justify-center gap-4">
      <button id="confirmDelete" class="bg-red-600 text-white px-6 py-2 rounded-lg hover:bg-red-700 transition font-bold">حذف</button>
      <button id="cancelDelete" class="bg-gray-300 text-gray-800 px-6 py-2 rounded-lg hover:bg-gray-400 transition font-bold">إلغاء</button>
    </div>
  </div>
</div>

<jsp:include page="/WEB-INF/footer.jsp" />

<script>
  let startX, currentCard, isDragging = false, deleteTargetWrapper = null;

  function resetCard() {
    if (currentCard) {
      currentCard.style.transition = 'transform 0.2s';
      currentCard.style.transform = 'translateX(0)';
      setTimeout(() => {
        if (currentCard) currentCard.style.transition = '';
      }, 200);
    }
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

  // Swipe-to-delete logic for card
  document.querySelectorAll('.message-card').forEach(card => {
    card.addEventListener('mousedown', function(e) {
      startX = e.clientX;
      currentCard = card;
      isDragging = true;
      document.addEventListener('mousemove', onMove);
      document.addEventListener('mouseup', onEnd);
    });
    card.addEventListener('touchstart', function(e) {
      startX = e.touches[0].clientX;
      currentCard = card;
      isDragging = true;
      document.addEventListener('touchmove', onMove);
      document.addEventListener('touchend', onEnd);
    });
  });

  function onMove(e) {
    if (!isDragging) return;
    let clientX = e.type.includes('mouse') ? e.clientX : e.touches[0].clientX;
    let diffX = clientX - startX;
    currentCard.style.transform = `translateX(${diffX}px)`;
    let bg = currentCard.closest('li[data-id]').querySelector('.delete-bg');
    if(bg) {
      let percent = Math.min(Math.abs(diffX) / 120, 1);
      bg.style.opacity = percent;
      bg.style.backgroundColor = `rgba(254,202,202,${percent})`;
    }
  }

  function onEnd(e) {
    if (!isDragging) return;
    let clientX = e.type.includes('mouse') ? (e.clientX ?? startX) : e.changedTouches[0].clientX;
    let diffX = clientX - startX;
    let wrapper = currentCard.closest('li[data-id]');
    let bg = wrapper.querySelector('.delete-bg');
    if (Math.abs(diffX) > 100) {
      showDeleteModal(wrapper);
    } else {
      resetCard();
      if(bg) bg.style.opacity = 0;
    }
    isDragging = false;
    document.removeEventListener(e.type.includes('mouse') ? 'mousemove' : 'touchmove', onMove);
    document.removeEventListener(e.type.includes('mouse') ? 'mouseup' : 'touchend', onEnd);
  }

  document.getElementById('confirmDelete').addEventListener('click', deleteCard);
  document.getElementById('cancelDelete').addEventListener('click', closeDeleteModal);

  document.addEventListener('selectstart', e => { if (isDragging) e.preventDefault(); });
</script>
</body>
</html>