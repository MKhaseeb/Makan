<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8">
    <title>دردشة القاعة</title>
    <script src="https://cdn.tailwindcss.com"></script>

    <!-- مكتبة SockJS و Stomp.js لـ WebSocket -->
    <script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/stompjs@2.3.3/lib/stomp.min.js"></script>
</head>
<body class="bg-gray-100 min-h-screen flex flex-col">

<header class="bg-indigo-700 text-white p-4 flex justify-between items-center">
    <h1 class="text-xl font-bold">دردشة مع المستخدم</h1>
    <a href="/owner/dashboard" class="hover:underline">عودة للوحة التحكم</a>
</header>

<main class="flex-1 p-4 max-w-4xl mx-auto flex flex-col">

    <!-- صندوق عرض الرسائل -->
    <div id="chatMessages" class="bg-white rounded shadow p-4 mb-4 overflow-y-auto flex-grow" style="height: 500px;">
        <c:forEach items="${messages}" var="msg">
            <div class="mb-3">
                <span class="font-semibold">${msg.senderName}</span>:
                <span>${msg.content}</span>
                <div class="text-xs text-gray-400">${msg.timestamp}</div>
            </div>
        </c:forEach>
    </div>

    <!-- نموذج ارسال رسالة -->
    <form id="chatForm" class="flex gap-2" onsubmit="sendMessage(event)">
        <input id="messageInput" type="text" placeholder="اكتب رسالتك..." 
               class="flex-grow p-2 border rounded" autocomplete="off" required />
        <button type="submit" class="bg-indigo-600 text-white px-4 rounded hover:bg-indigo-700">
            إرسال
        </button>
    </form>

</main>

<script>
    const chatId = "${chatId}";  // معرف الدردشة
    const userId = "${sessionScope.userId}";  // معرف المستخدم الحالي (المالك)
    
    let stompClient = null;

    function connect() {
        const socket = new SockJS('/ws');  // تأكد من مسار websocket عندك
        stompClient = Stomp.over(socket);
        stompClient.connect({}, function(frame) {
            console.log('Connected: ' + frame);
            stompClient.subscribe('/topic/chat/' + chatId, function(messageOutput) {
                const msg = JSON.parse(messageOutput.body);
                showMessage(msg);
            });
        });
    }

    function showMessage(message) {
        const chatMessages = document.getElementById('chatMessages');

        // إنشاء عنصر جديد للرسالة
        const div = document.createElement('div');
        div.classList.add('mb-3');

        const senderSpan = document.createElement('span');
        senderSpan.classList.add('font-semibold');
        senderSpan.textContent = message.senderName + ': ';

        const contentSpan = document.createElement('span');
        contentSpan.textContent = message.content;

        const timestampDiv = document.createElement('div');
        timestampDiv.classList.add('text-xs', 'text-gray-400');
        timestampDiv.textContent = new Date(message.timestamp).toLocaleString('ar-EG');

        div.appendChild(senderSpan);
        div.appendChild(contentSpan);
        div.appendChild(timestampDiv);

        chatMessages.appendChild(div);
        chatMessages.scrollTop = chatMessages.scrollHeight; // تمرير تلقائي للأسفل
    }

    function sendMessage(event) {
        event.preventDefault();
        const input = document.getElementById('messageInput');
        const content = input.value.trim();
        if (content && stompClient) {
            const message = {
                chatId: chatId,
                senderId: userId,
                receiverId: null, // يمكن وضع id المستلم إذا تعرفه
                content: content
            };
            stompClient.send("/app/chat/" + chatId + "/send", {}, JSON.stringify(message));
            input.value = '';
        }
    }

    // الاتصال عند تحميل الصفحة
    window.onload = function() {
        connect();
        // تمرير صندوق الرسائل للاسفل تلقائياً عند التحميل
        const chatMessages = document.getElementById('chatMessages');
        chatMessages.scrollTop = chatMessages.scrollHeight;
    };
</script>

</body>
</html>
