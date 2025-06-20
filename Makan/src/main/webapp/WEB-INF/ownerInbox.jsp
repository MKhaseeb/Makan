<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8">
    <title>صندوق الدردشة</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/sockjs.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/stompjs@2/stomp.min.js"></script>
</head>

<body class="bg-gray-100 font-sans">

<div class="flex h-screen">

    <!-- Sidebar -->
    <div class="w-1/4 bg-white border-r overflow-y-auto">
        <h2 class="text-xl font-bold p-4 border-b">الدردشات</h2>
        <c:forEach var="chatId" items="${chatIds}">
            <a href="#" class="block p-4 hover:bg-blue-50" onclick="openChat('${chatId}')">
                محادثة: ${chatId}
            </a>
        </c:forEach>
    </div>

    <!-- Main Chat Window -->
    <div class="flex-1 flex flex-col">
        <div class="bg-white p-4 border-b flex justify-between items-center">
            <h2 class="text-xl font-semibold">الدردشة</h2>
            <span id="currentChatId" class="text-gray-500"></span>
        </div>

        <!-- Message Display Area -->
        <div id="messageArea" class="flex-1 p-4 overflow-y-auto space-y-2"></div>

        <!-- Input Area -->
        <div class="p-4 border-t bg-white">
            <form onsubmit="sendMessage(event)" class="flex gap-2">
                <input id="messageInput" type="text" class="flex-1 p-2 border rounded" placeholder="اكتب رسالة...">
                <button type="submit" class="bg-blue-600 text-white px-4 py-2 rounded">إرسال</button>
            </form>
        </div>
    </div>

</div>

<script>
    let stompClient = null;
    let currentChatId = null;

    function connectWebSocket() {
        const socket = new SockJS('/chat-websocket');
        stompClient = Stomp.over(socket);
        stompClient.connect({}, function () {
            console.log("Connected to WebSocket");
        });
    }

    function openChat(chatId) {
        currentChatId = chatId;
        document.getElementById("currentChatId").textContent = chatId;
        document.getElementById("messageArea").innerHTML = "";

        // Fetch messages from backend
        fetch(`/api/chat/${chatId}/messages`)
            .then(res => res.json())
            .then(messages => {
                messages.forEach(msg => showMessage(msg));
            });

        // Subscribe to this chat topic
        stompClient.subscribe("/topic/chat/" + chatId, function (msg) {
            showMessage(JSON.parse(msg.body));
        });
    }

    function showMessage(message) {
        const msgDiv = document.createElement("div");
        msgDiv.className = "p-2 rounded bg-gray-200 max-w-lg";
        msgDiv.innerHTML = `<strong>${message.senderId}:</strong> ${message.content}`;
        document.getElementById("messageArea").appendChild(msgDiv);
    }

    function sendMessage(event) {
        event.preventDefault();
        const content = document.getElementById("messageInput").value.trim();
        if (!content || !currentChatId) return;

        stompClient.send("/app/chat/" + currentChatId + "/send", {}, JSON.stringify({
            chatId: currentChatId,
            senderId: ${ownerId}, // dynamically inserted from backend
            content: content
        }));

        document.getElementById("messageInput").value = "";
    }

    window.onload = connectWebSocket;
</script>

</body>
</html>
