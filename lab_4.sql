INSERT INTO Product (name, category, price, stockquantity) VALUES
('Ноутбук', 'Електроніка', 25000, 10),
('Мишка', 'Комп`ютерні аксесуари', 500, 50),
('Смартфон', 'Електроніка', 15000, 20),
('Клавіатура', 'Комп`ютерні аксесуари', 1200, 30),
('Монітор', 'Електроніка', 8000, 15),
('Навушники', 'Аудіотехніка', 2000, 25),
('Принтер', 'Офісна техніка', 7000, 10),
('Флеш-накопичувач', 'Накопичувачі', 600, 40),
('Веб-камера', 'Комп`ютерні аксесуари', 1500, 20),
('Геймпад', 'Комп`ютерні аксесуари', 2500, 15),
('Мікрофон', 'Аудіотехніка', 3000, 12),
('Зовнішній жорсткий диск', 'Накопичувачі', 5000, 18),
('Маршрутизатор', 'Мережеве обладнання', 3500, 22),
('Смарт-годинник', 'Електроніка', 9000, 8);

INSERT INTO Customer (Name, Contact) VALUES
('Іван Іванов', 'ivan@example.com'),
('Марія Петренко', 'maria@example.com'),
('Олександр Коваленко', 'oleksandr@example.com'),
('Наталія Сидоренко', 'natalia@example.com'),
('Дмитро Мельник', 'dmytro@example.com'),
('Олена Ткаченко', 'olena@example.com'),
('Сергій Бондар', 'serhiy@example.com');

INSERT INTO Orders (CustomerID, OrderDate, TotalAmount, order_status) VALUES
(8, '2024-02-01', 25500, 'pending'),
(9, '2024-02-02', 15000, 'processed'),
(5, '2024-02-03', 8000, 'shipped'),
(4, '2024-02-04', 5000, 'pending'),
(5, '2024-02-05', 12000, 'processed'),
(6, '2024-02-06', 3500, 'shipped'),
(7, '2024-02-07', 9000, 'pending');


INSERT INTO OrderDetails (OrderID, ProductID, Quantity, Price) VALUES
(38, 4, 1, 25000),  -- Ноутбук
(39, 5, 1, 500),    -- Мишка
(40, 6, 1, 15000),  -- Смартфон
(41, 13, 2, 2500),  -- Геймпад
(42, 14, 1, 3000),  -- Мікрофон
(43, 15, 1, 5000),  -- Зовнішній жорсткий диск
(44, 16, 1, 3500),  -- Маршрутизатор
(38, 17, 1, 9000),  -- Смарт-годинник
(38, 5, 2, 500),    -- Мишка
(40, 6, 1, 15000);  -- Смартфон

-- Вибірка всіх товарів
SELECT * FROM Product;
SELECT * FROM orders;
select * from Customer;
select * from orderdetails;
DELETE FROM orderdetails;


-- Створення користувацького типу ENUM
CREATE TYPE order_status AS ENUM ('pending', 'shipped', 'delivered', 'canceled');

-- Додавання нового стовпця в таблицю Orders
ALTER TABLE Orders ADD COLUMN status order_status DEFAULT 'pending';



-- Створення функції для обчислення середньої суми замовлення
CREATE OR REPLACE FUNCTION calculate_average_order_amount() 
RETURNS NUMERIC AS 
'
    SELECT AVG(TotalAmount) FROM Orders;
'
LANGUAGE SQL;

SELECT calculate_average_order_amount();



-- Створення таблиці для логування змін у замовленнях (змінений тип operation)
CREATE TABLE Order_Log (
    log_id SERIAL PRIMARY KEY,
    order_id INT,
    operation VARCHAR(10), -- Тепер зберігає 'INSERT', 'UPDATE' або 'DELETE'
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Створення тригерної функції для логування змін у Orders
CREATE OR REPLACE FUNCTION log_order_changes() RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO Order_Log (order_id, operation)
    VALUES (NEW.OrderID, TG_OP);  -- TG_OP містить 'INSERT', 'UPDATE' або 'DELETE'
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Створення тригера для відстеження змін у Orders
CREATE TRIGGER track_order_changes
AFTER INSERT OR UPDATE OR DELETE ON Orders
FOR EACH ROW
EXECUTE FUNCTION log_order_changes();

-- Перевірка результату
INSERT INTO Orders (CustomerID, OrderDate, TotalAmount) 
VALUES (9, '2024-03-12', 5000);

SELECT * FROM Order_Log;



-- Створення тригерної функції для оновлення залишку товарів
CREATE OR REPLACE FUNCTION update_stock_quantity() RETURNS TRIGGER AS $$
BEGIN
    UPDATE Product
    SET stockquantity = stockquantity - NEW.Quantity
    WHERE ProductID = NEW.ProductID;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Створення тригера, що зменшує залишок товару після додавання запису в OrderDetails
CREATE TRIGGER update_stock
AFTER INSERT ON OrderDetails
FOR EACH ROW
EXECUTE FUNCTION update_stock_quantity();

--Перевірка чи працює тригер
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, Price) 
VALUES (41, 5, 2, 1500); -- Купили 2 одиниці товару з ProductID = 5

-- перевірка чи оновилася кількість товару
SELECT * FROM Product WHERE ProductID = 5;


--Перевірка статусів замовлень:
SELECT OrderID, status FROM Orders;

--Перевірка лог змін у Order_Log:
SELECT * FROM Order_Log;

--Перевірка залишку продукту товарів:
SELECT * FROM Product;

