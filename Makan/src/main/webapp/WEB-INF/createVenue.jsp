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
                <label class="block mb-1 font-medium text-gray-700">الصورة:</label>
                <input type="file" name="file" class="w-full text-gray-700" />
                <c:if test="${not empty error}">
                    <p class="text-red-600 mt-1">${error}</p>
                </c:if>
            </div>

            <div class="text-center">
                <button type="submit" class="bg-indigo-600 hover:bg-indigo-700 text-white font-semibold px-6 py-2 rounded transition duration-300">
                    إضافة
                </button>
            </div>

        </form:form>
    </div>

</body>
</html>
