<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8" />
    <title>الأحكام والشروط - قاعتي</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        body {
            font-family: 'Cairo', sans-serif;
            background-color: #fdfcf9;
        }
    </style>
</head>
<body class="text-[#333]">

       <jsp:include page="header.jsp" />


<!-- المحتوى الرئيسي -->
<main class="max-w-4xl mx-auto px-8 py-16 bg-white rounded-lg shadow-xl mt-12">
    <h2 class="text-4xl font-extrabold text-center text-blue-800 mb-14 drop-shadow-md" data-i18n="terms_header">الأحكام والشروط</h2>

    <section class="space-y-10 leading-relaxed text-gray-900">

        <p class="text-xl drop-shadow-sm" data-i18n="terms_intro">
            تسري شروط أحكامنا على أي حجز يتم إجراؤه عبر موقعنا الإلكتروني
            <a href="https://www....com" target="_blank" class="text-blue-700 hover:underline">www....com</a>.
        </p>

        <p class="text-xl drop-shadow-sm" data-i18n="terms_acceptance">
            عند إجراء الحجز، يقر المستأجر ويوافق على قراءة وفهم الشروط والأحكام المنصوص عليها...
        </p>

        <ul class="list-disc pr-8 space-y-4 text-gray-800 text-lg">
            <li data-i18n="li1" class="drop-shadow-sm">الموقع غير مسؤول عن أي عقوبة جزائية أو أضرار أو خسائر.</li>
            <li data-i18n="li2" class="drop-shadow-sm">الاتصال يتم مباشرة مع مالك القاعة في حال حدوث مشكلة.</li>
            <li data-i18n="li3" class="drop-shadow-sm">المستأجر يتحمل كامل المسؤولية عن العقار بعد الاستلام.</li>
            <li data-i18n="li4" class="drop-shadow-sm">الموقع غير مسؤول عن أي إصابة شخصية أو وفاة أو تلف للممتلكات.</li>
            <li data-i18n="li5" class="drop-shadow-sm">يُمنع الإهمال أو سوء السلوك المتعمد .</li>
        </ul>

        <h3 class="text-3xl font-semibold text-gray-900 mt-14 drop-shadow-md" data-i18n="booking_title">شروط الحجز:</h3>

        <ul class="list-decimal pr-10 space-y-4 text-gray-800 text-lg">
            <li data-i18n="b1" class="drop-shadow-sm">الأسعار والمعلومات المعروضة يتم توفيرها من قبل مالك القاعة، والموقع يعمل كوسيط لتسهيل عملية الحجز فقط.</li>
            <li data-i18n="b2" class="drop-shadow-sm">يُطلب من المستأجر دفع عربون تأكيد بقيمة 20٪ من إجمالي المبلغ خلال 24 ساعة من وقت الحجز.</li>
            <li data-i18n="b3" class="drop-shadow-sm">في حال عدم دفع العربون خلال المدة المحددة، يُعتبر الحجز غير مؤكد ويحق للقاعة إلغاء الحجز.</li>
            <li data-i18n="b4" class="drop-shadow-sm">العربون غير قابل للاسترداد في حال إلغاء الحجز من طرف المستأجر لأي سبب.</li>
            <li data-i18n="b5" class="drop-shadow-sm">يتم تحديد مدة استخدام القاعة حسب الاتفاق مع المؤجر (مثلاً: من الساعة 6 مساءً حتى 12 منتصف الليل)، ويجب الالتزام بالمدة المحددة.</li>
            <li data-i18n="b6" class="drop-shadow-sm">في حال تأخر المستأجر عن الحضور أو رغبته في تعديل وقت الحجز، يجب التواصل مع المؤجر قبل الموعد بوقت كافٍ.</li>
            <li data-i18n="b7" class="drop-shadow-sm">أي أضرار أو تلفيات في القاعة خلال فترة الحجز تقع تحت مسؤولية المستأجر، ويتم تقدير قيمتها من قبل المالك.</li>
        </ul>

    </section>
</main>

       <jsp:include page="footer.jsp" />

    <!-- السكربت كما هو -->
    <script>
    const translations = {
            ar: {
                site_title: "قاعتي",
                home: "الرئيسية",
                about: "نبذة عنا",
                terms: "الأحكام والشروط",
                payment: "طريقة الدفع",
                register: "سجّل الآن",
                footer_about: "منصة رائدة لحجز القاعات في فلسطين...",
                quick_links: "روابط سريعة",
                contact_us: "تواصل معنا",
                phone: "هاتف: 00970 525 789",
                email: "البريد الإلكتروني: info@qa3ti.ps",
                address: "العنوان: فلسطين",
                rights: "جميع الحقوق محفوظة.",
                terms_header: "الأحكام والشروط",
                terms_intro: `تسري شروط أحكامنا على أي حجز يتم إجراؤه عبر موقعنا الإلكتروني
                <a href="https://www....com" class="text-blue-600 hover:underline">www....com</a>.`,
                terms_acceptance: "عند إجراء الحجز، يقر المستأجر ويوافق على قراءة وفهم الشروط والأحكام المنصوص عليها. يجب على الأطراف المعنية عند استلام المستأجر الالتزام بكافة التعليمات، بما في ذلك:",
                li1: "الموقع غير مسؤول عن أي عقوبة جزائية أو أضرار أو خسائر.",
                li2: "الاتصال يتم مباشرة مع مالك القاعة في حال حدوث مشكلة.",
                li3: "المستأجر يتحمل كامل المسؤولية عن العقار بعد الاستلام.",
                li4: "الموقع غير مسؤول عن أي إصابة شخصية أو وفاة أو تلف للممتلكات.",
                li5: "يُمنع الإهمال أو سوء السلوك المتعمد أو التشويه أو الإغفال.",
                booking_title: "شروط الحجز:",
                b1: "الأسعار والمعلومات المعروضة يتم توفيرها من قبل مالك القاعة، والموقع يعمل كوسيط لتسهيل عملية الحجز فقط.",
                b2: "يُطلب من المستأجر دفع عربون تأكيد بقيمة 20٪ من إجمالي المبلغ خلال 24 ساعة من وقت الحجز.",
                b3: "في حال عدم دفع العربون خلال المدة المحددة، يُعتبر الحجز غير مؤكد ويحق للقاعة إلغاء الحجز.",
                b4: "العربون غير قابل للاسترداد في حال إلغاء الحجز من طرف المستأجر لأي سبب.",
                b5: "يتم تحديد مدة استخدام القاعة حسب الاتفاق مع المؤجر (مثلاً: من الساعة 6 مساءً حتى 12 منتصف الليل)، ويجب الالتزام بالمدة المحددة.",
                b6: "في حال تأخر المستأجر عن الحضور أو رغبته في تعديل وقت الحجز، يجب التواصل مع المؤجر قبل الموعد بوقت كافٍ.",
                b7: "أي أضرار أو تلفيات في القاعة خلال فترة الحجز تقع تحت مسؤولية المستأجر، ويتم تقدير قيمتها من قبل المالك."
            },
            en: {
                site_title: "Qa3ti",
                home: "Home",
                about: "About Us",
                terms: "Terms & Conditions",
                payment: "Payment",
                register: "Register Now",
                footer_about: "Leading platform for hall booking in Palestine...",
                quick_links: "Quick Links",
                contact_us: "Contact Us",
                phone: "Phone: 00970 525 789",
                email: "Email: info@qa3ti.ps",
                address: "Address: Palestine",
                rights: "All rights reserved.",
                terms_header: "Terms & Conditions",
                terms_intro: `Our terms and conditions apply to any booking made through our website
                <a href="https://www....com" class="text-blue-600 hover:underline">www....com</a>.`,
                terms_acceptance: "By making a booking, the renter acknowledges and agrees to have read and understood the stated terms and conditions. The concerned parties must adhere to all instructions upon receiving the property, including:",
                li1: "The site is not responsible for any criminal penalties, damages, or losses.",
                li2: "Contact is made directly with the hall owner in case of any issue.",
                li3: "The renter bears full responsibility for the property after receipt.",
                li4: "The site is not responsible for any personal injury, death, or property damage.",
                li5: "Negligence, intentional misconduct, defacement, or omission is prohibited.",
                booking_title: "Booking Conditions:",
                b1: "Prices and information displayed are provided by the hall owner; the site acts only as an intermediary to facilitate the booking process.",
                b2: "The renter is required to pay a 20% confirmation deposit of the total amount within 24 hours of booking.",
                b3: "Failure to pay the deposit within the specified period will render the booking unconfirmed and the hall may cancel the booking.",
                b4: "The deposit is non-refundable if the booking is canceled by the renter for any reason.",
                b5: "The duration of hall use is determined by agreement with the owner (e.g., from 6 PM to midnight) and must be adhered to.",
                b6: "If the renter is late or wishes to modify the booking time, they must contact the owner well in advance.",
                b7: "Any damages or defects during the booking period are the renter's responsibility and will be assessed by the owner."
            }
        };

        function toggleLanguage() {
            const htmlTag = document.documentElement;
            const currentLang = htmlTag.lang === "ar" ? "ar" : "en";
            const newLang = currentLang === "ar" ? "en" : "ar";

            // تغيير اللغة واتجاه الصفحة
            htmlTag.lang = newLang;
            htmlTag.dir = newLang === "ar" ? "rtl" : "ltr";

            // تحديث النصوص حسب اللغة الجديدة
            document.querySelectorAll("[data-i18n]").forEach(el => {
                const key = el.getAttribute("data-i18n");
                const translation = translations[newLang][key];

                // دعم روابط داخل النصوص HTML
                if (translation && translation.includes('<a ')) {
                    el.innerHTML = translation;
                } else {
                    el.textContent = translation || key;
                }
            });

            // تغيير نص زر اللغة
            document.getElementById("langToggle").textContent = newLang === "ar" ? "EN" : "AR";
        }
    </script>

</body>
</html>
