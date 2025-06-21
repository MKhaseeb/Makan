<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8" />
    <title>لوحة تحكم المالك - دردشة القاعة</title>

    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>

    <!-- Google Fonts Cairo -->
    <link href="https://fonts.googleapis.com/css2?family=Cairo:wght@400;700&display=swap" rel="stylesheet" />

    <!-- SockJS + STOMP for WebSocket -->
    <script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/stompjs@2.3.3/lib/stomp.min.js"></script>

    <style>
        body {
            font-family: 'Cairo', sans-serif;
            background: linear-gradient(to bottom right, #f3e8ff, #e0f2fe);
            min-height: 100vh;
        }
        /* Custom scrollbar for chatMessages */
        #chatMessages::-webkit-scrollbar {
            width: 8px;
        }
        #chatMessages::-webkit-scrollbar-thumb {
            background-color: #6366f1;
            border-radius: 10px;
        }
    </style>
</head>

<body class="flex flex-col min-h-screen">

<c:choose>
    <c:when test="${user.role == 'admin'}">
        <jsp:include page="navbarlogin.jsp" />
    </c:when>
    <c:when test="${user.role == 'owner'}">
        <jsp:include page="navbarowner.jsp" />
    </c:when>
    <c:otherwise>
        <jsp:include page="navbaruser.jsp" />
    </c:otherwise>
</c:choose>

<main class="flex-grow max-w-7xl mx-auto p-6 grid grid-cols-1 lg:grid-cols-3 gap-8">

    <!-- Sidebar (optional): You can add venue stats or navigation here -->
    <aside class="hidden lg:block bg-white rounded-3xl shadow-lg p-6 text-right space-y-6">
        <h2 class="text-indigo-700 font-bold text-xl mb-4">مرحبًا، <span class="text-indigo-900">${user.firstname}</span>!</h2>
        <p class="text-gray-700 leading-relaxed">
            من هنا يمكنك متابعة دردشاتك الحية مع المستخدمين، إدارة القاعات والحجوزات.
        </p>

        <!-- Example quick info -->
        <div>
            <h3 class="font-semibold text-indigo-600 mb-2">قاعاتك</h3>
            <p class="text-gray-800">${fn:length(venues)} قاعة</p>
        </div>
        <div>
            <h3 class="font-semibold text-indigo-600 mb-2">الحجوزات</h3>
            <p class="text-gray-800">${fn:length(bookings)} حجز</p>
        </div>
    </aside>

    <!-- Chat Section -->
    <section class="col-span-1 lg:col-span-2 bg-white rounded-3xl shadow-lg flex flex-col overflow-hidden" style="min-height: 600px;">

        <!-- Header -->
        <header class="bg-indigo-700 text-white p-5 flex justify-between items-center">
            <h1 class="text-2xl font-extrabold">دردشة مع المستخدم</h1>
            <a href="/owner/dashboard" class="hover:underline">عودة للوحة التحكم</a>
        </header>

        <!-- Messages Container -->
        <div id="chatMessages" class="flex-1 p-6 overflow-y-auto space-y-4" style="direction: rtl; height: 100%;">
            <c:forEach items="${messages}" var="msg">
                <div class="max-w-3xl mx-auto">
                    <div class="flex flex-col text-right">
                        <span class="font-semibold text-indigo-700">${msg.senderName}</span>
                        <div class="bg-indigo-100 text-indigo-900 rounded-2xl inline-block px-4 py-2 mt-1 max-w-full break-words">
                            ${msg.content}
                        </div>
                        <div class="text-xs text-gray-400 mt-1">
                            ${msg.timestamp}
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <!-- Input Form -->
        <form id="chatForm" class="p-5 border-t border-indigo-200 flex gap-3 items-center" onsubmit="sendMessage(event)">
            <input
                id="messageInput"
                type="text"
                placeholder="اكتب رسالتك..."
                class="flex-grow p-3 border border-indigo-300 rounded-full focus:outline-none focus:ring-2 focus:ring-indigo-500"
                autocomplete="off"
                required
            />
            <input type="hidden" id="receiverId" value="${receiverId}" />
            <button
                type="submit"
                class="bg-indigo-600 hover:bg-indigo-700 transition-colors text-white font-bold px-6 py-3 rounded-full shadow-md"
            >
                إرسال
            </button>
        </form>

    </section>
</main>

<!-- Scroll to top button -->
<button id="scrollTopBtn" aria-label="العودة لأعلى" title="العودة لأعلى"
        class="fixed bottom-8 right-8 p-3 rounded-full shadow-lg bg-indigo-600 hover:bg-indigo-700 transition transform hover:scale-110 z-50"
        onclick="window.scrollTo({ top: 0, behavior: 'smooth' });">
    <svg xmlns="http://www.w3.org/2000/svg" class="w-7 h-7 stroke-white" fill="none" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round" viewBox="0 0 24 24">
        <polyline points="6 15 12 9 18 15" />
    </svg>
</button>

<jsp:include page="footer.jsp" />

<script>
    const chatId = "${chatId}";
    const userId = "${sessionScope.user.id}";

    let stompClient = null;

    function connect() {
        const socket = new SockJS('/chat-websocket');
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

        // Create message container
        const div = document.createElement('div');
        div.classList.add('max-w-3xl', 'mx-auto');

        const messageBox = document.createElement('div');
        messageBox.classList.add('flex', 'flex-col', 'text-right');

        // Sender's name bold
        const senderSpan = document.createElement('span');
        senderSpan.classList.add('font-semibold', 'text-indigo-700');
        senderSpan.textContent = message.senderName;

        // Message bubble
        const contentDiv = document.createElement('div');
        contentDiv.classList.add('bg-indigo-100', 'text-indigo-900', 'rounded-2xl', 'inline-block', 'px-4', 'py-2', 'mt-1', 'max-w-full', 'break-words');
        contentDiv.textContent = message.content;

        // Timestamp styled smaller and gray
        const timestampDiv = document.createElement('div');
        timestampDiv.classList.add('text-xs', 'text-gray-400', 'mt-1');
        timestampDiv.textContent = new Date(message.timestamp).toLocaleString('ar-EG');

        // Append elements
        messageBox.appendChild(senderSpan);
        messageBox.appendChild(contentDiv);
        messageBox.appendChild(timestampDiv);

        div.appendChild(messageBox);
        chatMessages.appendChild(div);

        // Auto-scroll to bottom
        chatMessages.scrollTop = chatMessages.scrollHeight;
    }

    function sendMessage(event) {
        event.preventDefault();
        const input = document.getElementById('messageInput');
        const content = input.value.trim();

        if (!content || !stompClient) return;

        const receiverId = document.getElementById('receiverId').value;

        const message = {
            chatId: chatId,
            senderId: userId,
            receiverId: receiverId,
            content: content
        };

        stompClient.send("/app/chat/" + chatId + "/send", {}, JSON.stringify(message));
        input.value = '';
    }

    window.onload = () => {
        connect();

        const chatMessages = document.getElementById('chatMessages');
        chatMessages.scrollTop = chatMessages.scrollHeight;
    };
</script>

</body>
</html>
