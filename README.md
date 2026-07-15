# Marn Web Dashboard — Supabase Edition

واجهة مرن ويب كاملة بنفس تصميم النسخة المحلية، مع حسابات مستخدمين ومزامنة Supabase.

## المزايا
- إنشاء حساب بالاسم + البريد الإلكتروني + كلمة المرور
- تسجيل الدخول والخروج
- استعادة كلمة المرور بالبريد
- كل مستخدم يرى بياناته فقط عبر Row Level Security (RLS)
- حفظ ومزامنة الشهور والشفتات والاستلام مع Supabase
- نسخة Cache محلية لعرض آخر بيانات محفوظة عند مشكلة اتصال مؤقتة
- إضافة شفت منفرد أو إدخال شهر كامل مع تحديد عدد الأيام/الشفتات
- عربي / English و RTL / LTR
- Light / Dark
- تصدير واستيراد JSON
- إعادة تعيين بيانات حساب المستخدم
- مناسب للنشر على GitHub Pages أو Netlify أو Vercel كواجهة Static

## الإعداد في Supabase
1. أنشئ مشروعًا جديدًا في Supabase.
2. افتح SQL Editor.
3. انسخ كامل محتوى `supabase-schema.sql` وشغّله مرة واحدة.
4. افتح `config.js` وضع:
   - Project URL
   - Publishable key (أو anon key في المشاريع القديمة)
5. من Authentication > URL Configuration:
   - ضع رابط موقعك في Site URL.
   - أضف رابط موقعك إلى Redirect URLs، خصوصًا لاستخدام استعادة كلمة المرور.
6. من Authentication > Providers > Email تأكد أن Email provider مفعّل.
7. ارفع الملفات إلى GitHub Pages أو استضافة Static.

## ملفات المشروع
- `index.html`: التطبيق الكامل
- `styles.css`: التصميم
- `config.js`: إعداد اتصال Supabase
- `supabase-schema.sql`: الجدول وسياسات الحماية RLS

## ملاحظة أمنية مهمة
استخدم Publishable/anon key فقط في الواجهة. لا تضع Service Role key داخل ملفات الموقع أبدًا.
