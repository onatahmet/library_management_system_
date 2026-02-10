# 📚 KitapKap - Library Management System (SQL)

[İsteğe bağlı: Buraya projenin bir şemasını veya ekran görüntüsünü ekleyebilirsin]

## 🇹🇷 Proje Hakkında
Bu proje, bir kütüphane otomasyonunun veritabanı mimarisini ve iş mantığını (Business Logic) içermektedir. Projenin temel amacı, veritabanı seviyesinde otomatik stok yönetimi ve kullanıcı limit kontrollerini sağlamaktır.

### Ana Özellikler:
* **Otomatik Stok Yönetimi:** Triggerlar sayesinde kitap ödünç alındığında stok düşer, iade edildiğinde artar.
* **Abonelik Limit Kontrolü:** Kullanıcıların abonelik tiplerine (Basic, Standard, Premium) göre alabileceği kitap sayısı veritabanı seviyesinde kısıtlanmıştır.
* **İlişkisel Mimari:** Many-to-Many (Çoka Çok) ilişki yapısı ile kitapların birden fazla türe sahip olması sağlanmıştır.
* **Raporlama:** Görünümler (Views) ile karmaşık sorgular basitleştirilmiştir.

---

## 🇺🇸 About The Project
This project includes the database architecture and business logic of a library automation system. The main goal is to provide automatic inventory management and user limit controls at the database level.

### Key Features:
* **Automatic Inventory Management:** Thanks to triggers, stock decreases when a book is borrowed and increases when returned.
* **Subscription Limit Control:** The number of books users can borrow is restricted based on their subscription types (Basic, Standard, Premium).
* **Relational Architecture:** Books can have multiple genres using a Many-to-Many relationship.
* **Reporting:** Complex queries are simplified using Views.

---

## 🛠 Database Schema (Veritabanı Şeması)
Proje şu tablolar üzerine kuruludur / The project is built on the following tables:
* `books`: Kitap bilgileri ve stok / Book info & stock.
* `users`: Kullanıcı bilgileri ve abonelik tipi / User info & sub type.
* `book_shopping`: Ödünç alma işlemleri / Borrowing transactions.
* `sub_type_limit`: Abonelik kuralları / Subscription rules.
* `book_type` & `book_type_match`: Tür yönetimi / Genre management.



---

## 🚀 How to Run? (Nasıl Çalıştırılır?)
1. Herhangi bir SQL istemcisini (SQLite, PostgreSQL, MySQL vb.) açın.
2. `library_management_system.sql` dosyasındaki kodları kopyalayıp çalıştırın.
3. Veritabanı otomatik olarak tüm tablo ve tetikleyicileri (trigger) oluşturacaktır.