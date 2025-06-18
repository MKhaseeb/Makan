<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8">
    <title>احجز قاعتك</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        function toggleOtherEventField(value) {
            const otherField = document.getElementById('otherEventDiv');
            if (value === 'أخرى') {
                otherField.classList.remove('hidden');
            } else {
                otherField.classList.add('hidden');
            }
        }
    </script>
</head>
<body class="bg-gray-100 p-10">

<div class="max-w-2xl mx-auto bg-white p-8 rounded shadow">
    <h2 class="text-2xl font-bold mb-6 text-center">نموذج حجز القاعة</h2>

    <form method="post" action="/book" class="space-y-4">

        <label class="block">
            <span class="text-gray-700">الاسم الكامل:</span>
            <input type="text" readonly
                   value="${sessionScope.user.firstname} ${sessionScope.user.lastname}"
                   class="mt-1 block w-full border p-2 rounded bg-gray-100"/>
        </label>

        <label class="block">
            <span class="text-gray-700">البريد الإلكتروني:</span>
            <input type="email" readonly
                   value="${sessionScope.user.email}"
                   class="mt-1 block w-full border p-2 rounded bg-gray-100"/>
        </label>

        <label class="block">
            <span class="text-gray-700">رقم الهاتف:</span>
            <input type="text" name="phoneNumber" required class="mt-1 block w-full border p-2 rounded"/>
        </label>

        <label class="block">
            <span class="text-gray-700">تاريخ الحجز:</span>
            <input type="date" name="date" required class="mt-1 block w-full border p-2 rounded"/>
        </label>

        <label class="block">
            <span class="text-gray-700">الوقت:</span>
            <input type="time" name="time" required class="mt-1 block w-full border p-2 rounded"/>
        </label>

        <label class="block">
            <span class="text-gray-700">نوع المناسبة:</span>
            <select name="eventType" required onchange="toggleOtherEventField(this.value)" class="mt-1 block w-full border p-2 rounded">
                <option value="">-- اختر المناسبة --</option>
                <option value="عرس">عرس</option>
                <option value="خطبة">خطبة</option>
                <option value="طلبة">طلبة</option>
                <option value="تخرج">تخرج</option>
                <option value="أخرى">أخرى</option>
            </select>
        </label>

        <div id="otherEventDiv" class="hidden">
            <label class="block">
                <span class="text-gray-700">حدد نوع المناسبة:</span>
                <input type="text" name="otherEvent" class="mt-1 block w-full border p-2 rounded"/>
            </label>
        </div>

        <label class="block">
            <span class="text-gray-700">ملاحظات إضافية:</span>
            <textarea name="notes" rows="3" class="mt-1 block w-full border p-2 rounded"></textarea>
        </label>

        <div class="text-center">
            <button type="submit" class="bg-blue-600 text-white px-6 py-2 rounded hover:bg-blue-700">احجز الآن</button>
        </div>
    </form>
</div>

</body>
</html>
