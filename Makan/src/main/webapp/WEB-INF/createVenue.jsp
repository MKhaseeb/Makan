<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8" />
    <title>إضافة قاعة جديدة</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen flex items-center justify-center p-4">

    <div class="bg-white rounded-lg shadow-lg max-w-lg w-full p-8">
        <h1 class="text-2xl font-semibold mb-6 text-gray-800 text-center">إضافة قاعة</h1>

        <form:form action="/venue/new" method="post" modelAttribute="newVenue" enctype="multipart/form-data" class="space-y-5">
            
            <div>
                <label class="block mb-1 font-medium text-gray-700">الاسم:</label>
                <form:input path="name" cssClass="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-indigo-500" />
                <form:errors path="name" cssClass="text-red-600 text-sm mt-1" />
            </div>

            <div>
                <label class="block mb-1 font-medium text-gray-700">المدينة:</label>
                <form:input path="city" cssClass="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-indigo-500" />
                <form:errors path="city" cssClass="text-red-600 text-sm mt-1" />
            </div>

            <div>
                <label class="block mb-1 font-medium text-gray-700">السعر اليومي:</label>
                <form:input path="pricePerDay" type="number" cssClass="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-indigo-500" />
                <form:errors path="pricePerDay" cssClass="text-red-600 text-sm mt-1" />
            </div>

            <div>
                <label class="block mb-1 font-medium text-gray-700">السعة:</label>
                <form:input path="capacity" type="number" cssClass="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-indigo-500" />
                <form:errors path="capacity" cssClass="text-red-600 text-sm mt-1" />
            </div>

            <div>
                <label class="block mb-1 font-medium text-gray-700">الوصف:</label>
                <form:textarea path="description" rows="4" cssClass="w-full border border-gray-300 rounded px-3 py-2 resize-none focus:outline-none focus:ring-2 focus:ring-indigo-500" />
                <form:errors path="description" cssClass="text-red-600 text-sm mt-1" />
            </div>

<div>
  <label class="block mb-1 font-medium text-gray-700">الصور:</label>

  <input 
    type="file" 
    id="imageUpload" 
    multiple 
    accept="image/*"
    class="hidden" 
    onchange="addImages(event)" 
  />

  <label for="imageUpload" 
    class="cursor-pointer flex items-center justify-center border-2 border-dashed border-gray-400 rounded-lg h-32 hover:border-indigo-600 transition-colors text-gray-500"
  >
    اضغط هنا لاختيار صور أو اسحبها
  </label>

  <div id="preview" class="mt-4 flex flex-wrap gap-4"></div>

  <button type="button" onclick="uploadFiles()" class="mt-4 bg-indigo-600 text-white px-4 py-2 rounded">رفع الصور</button>
</div>
            <div class="text-center">
                <button type="submit" class="bg-indigo-600 hover:bg-indigo-700 text-white font-semibold px-6 py-2 rounded transition duration-300">
                    إضافة
                </button>
            </div>

        </form:form>
    </div>
<script>
  let selectedFiles = [];

  function addImages(event) {
    const files = Array.from(event.target.files);

    files.forEach(file => {
      if(!selectedFiles.some(f => f.name === file.name && f.size === file.size)) {
        selectedFiles.push(file);
      }
    });

    updatePreview();

    event.target.value = '';
  }

  function updatePreview() {
    const preview = document.getElementById('preview');
    preview.innerHTML = '';

    selectedFiles.forEach(file => {
      if(!file.type.startsWith('image/')) return;

      const reader = new FileReader();
      reader.onload = function(e) {
        const img = document.createElement('img');
        img.src = e.target.result;
        img.className = 'w-24 h-24 object-cover rounded-lg border border-gray-300 shadow-sm';
        preview.appendChild(img);
      };
      reader.readAsDataURL(file);
    });
  }

  function uploadFiles() {
    if(selectedFiles.length === 0) {
      alert('اختر صورًا للرفع أولاً');
      return;
    }

    const formData = new FormData();
    selectedFiles.forEach((file, i) => {
      formData.append('files', file);
    });

    fetch('/venue/new', {
      method: 'POST',
      body: formData
    })
    .then(response => {
      if(response.ok) {
        alert('تم رفع الصور بنجاح');
        // optionally clear selectedFiles and preview
        selectedFiles = [];
        updatePreview();
      } else {
        alert('حدث خطأ أثناء الرفع');
      }
    })
    .catch(() => alert('خطأ في الاتصال بالخادم'));
  }
</script>
</body>
</html>
