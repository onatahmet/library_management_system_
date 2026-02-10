-- KİTAPKAP VERİTABANI PROJESİ
-- Tasarlayan: Ahmet

-- 1. TABLOLARIN OLUŞTURULMASI
CREATE TABLE IF NOT EXISTS "books" (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "book_name" TEXT NOT NULL,
    "book_writer" TEXT NOT NULL,
    "number_of_books" INTEGER CHECK(number_of_books >= 0)
);

CREATE TABLE IF NOT EXISTS "book_type"(
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "book_type" TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS "sub_type_limit"(
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "sub_type_name" TEXT CHECK(sub_type_name IN ('basic','standart','premium')), 
    "book_limit" INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS "users"(
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "sub_type_id" INTEGER,
    "user_name" TEXT NOT NULL,
    "user_mail" TEXT NOT NULL,
    FOREIGN KEY ("sub_type_id") REFERENCES "sub_type_limit"("id")
);

CREATE TABLE IF NOT EXISTS "book_shopping"(
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "book_id" INTEGER,
    "user_id" INTEGER,
    "delivery_date" TEXT DEFAULT CURRENT_TIMESTAMP,
    "delivery" INTEGER DEFAULT 0 CHECK(delivery IN (0,1)),
    FOREIGN KEY ("book_id") REFERENCES "books"("id"),
    FOREIGN KEY ("user_id") REFERENCES "users"("id")
);

-- 2. RAPORLAMA GÖRÜNÜMÜ (VIEW)
CREATE VIEW IF NOT EXISTS "book_and_user" AS
SELECT "delivery_date", "delivery", "books"."book_name", "users"."user_name" 
FROM "book_shopping"
JOIN "books" ON "book_shopping"."book_id" = "books"."id"
JOIN "users" ON "book_shopping"."user_id" = "users"."id";

-- 3. İŞ MANTIKLARI (TRIGGERS)

-- Limit Kontrolü: Kitap almadan önce kotayı kontrol eder
CREATE TRIGGER "limit_kontrol"
BEFORE INSERT ON "book_shopping"
FOR EACH ROW
WHEN (
    (SELECT COUNT(*) FROM "book_shopping" WHERE "user_id" = NEW."user_id" AND "delivery" = 0) 
    >= 
    (SELECT "book_limit" FROM "sub_type_limit" 
     WHERE "id" = (SELECT "sub_type_id" FROM "users" WHERE "id" = NEW."user_id"))
)
BEGIN
    SELECT RAISE(ABORT, 'Hata: Kitap alma limitiniz dolmuştur!');
END;

-- Stok Yönetimi: Kitap alındığında sayıyı düşürür
CREATE TRIGGER "stok_dusur_insert" 
AFTER INSERT ON "book_shopping"
FOR EACH ROW 
BEGIN 
    UPDATE "books" SET "number_of_books" = "number_of_books" - 1 WHERE "id" = NEW."book_id";
END;

-- Stok Yönetimi: Kitap iade edildiğinde sayıyı artırır
CREATE TRIGGER "stok_arttir_update"
AFTER UPDATE OF "delivery" ON "book_shopping"
FOR EACH ROW
WHEN NEW."delivery" = 1 AND OLD."delivery" = 0
BEGIN 
    UPDATE "books" SET "number_of_books" = "number_of_books" + 1 WHERE "id" = NEW."book_id";
END;