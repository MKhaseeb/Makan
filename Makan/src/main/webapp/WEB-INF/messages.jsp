<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
  <meta charset="UTF-8">
  <title>سحب بطاقة مع Modal</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <style>
    .message-wrapper {
      position: relative;
      overflow: hidden;
    }
    .delete-bg {
      position: absolute;
      inset: 0;
      background-color: #f8f8f8;
      color: white;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 1.5rem;
      font-weight: bold;
      z-index: 0;
      transition: background-color 0.05s linear;
    }
    .message-card {
      position: relative;
      background-color: white;
      padding: 1rem;
      border-radius: 0.5rem;
      box-shadow: 0 0 5px rgba(0,0,0,0.1);
      transition: transform 0.2s ease;
      z-index: 10;
      user-select: none;
      touch-action: pan-y;
    }
  </style>
</head>
<body class="p-8 bg-gray-100">

<h1 class="text-2xl font-bold mb-6">رسائلك</h1>

<div class="space-y-4">
  <c:forEach var="msg" items="${messages}">
    <div class="message-wrapper" data-id="${msg.id}">
      <div class="delete-bg">حذف</div>
      <div class="message-card">
        <p><strong>الاسم:</strong> ${msg.name}</p>
        <p><strong>البريد:</strong> ${msg.email}</p>
        <p><strong>الهاتف:</strong> ${msg.phone}</p>
        <p><strong>الرسالة:</strong> ${msg.message}</p>
        <p class="text-sm text-gray-500">بتاريخ: ${msg.sentAt}</p>
      </div>
    </div>
  </c:forEach>
</div>

<!-- Modal -->
<div id="deleteModal" class="fixed inset-0 bg-black bg-opacity-40 flex items-center justify-center hidden z-50">
  <div class="bg-white rounded-lg p-6 w-80 text-center">
    <h2 class="text-xl font-bold mb-4">تأكيد الحذف</h2>
    <p class="mb-6">هل تريد حذف هذه الرسالة؟</p>
    <div class="flex justify-center gap-4">
      <button id="confirmDelete" class="bg-red-600 text-white px-4 py-2 rounded hover:bg-red-700">حذف</button>
      <button id="cancelDelete" class="bg-gray-300 px-4 py-2 rounded hover:bg-gray-400">إلغاء</button>
    </div>
  </div>
</div>

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
    wrapper = cardEl.closest('.message-wrapper');
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
