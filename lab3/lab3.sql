-- Лабораторна робота №3
-- З дисципліни: Бази даних та інформаційні системи
-- Студента групи МІТ-31 Полюховича Андрія

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

INSERT INTO Orders (CustomerID, OrderDate, TotalAmount) VALUES
(8, '2024-02-01', 25500),
(9, '2024-02-02', 15000),
(5, '2024-02-03', 8000),
(4, '2024-02-04', 5000),
(5, '2024-02-05', 12000),
(6, '2024-02-06', 3500),
(7, '2024-02-07', 9000);

INSERT INTO OrderDetails (OrderID, ProductID, Quantity, Price) VALUES
(1, 1, 1, 25000),
(1, 2, 1, 500),
(2, 3, 1, 15000),
(3, 4, 2, 2500),  -- Геймпад
(3, 5, 1, 3000),  -- Мікрофон
(4, 6, 1, 5000),  -- Зовнішній жорсткий диск
(5, 7, 1, 3500),  -- Маршрутизатор
(5, 8, 1, 9000),  -- Смарт-годинник
(6, 2, 2, 500),   -- Мишка
(7, 3, 1, 15000); -- Смартфон

-- Вибірка всіх товарів
SELECT * FROM Product;
SELECT * FROM orders;
select * from Customer;
-- Унікальні категорії товарів
SELECT DISTINCT Category FROM Product;

-- Максимальна та мінімальна ціна товарів
SELECT MAX(Price) AS MaxPrice, MIN(Price) AS MinPrice FROM Product;

-- Середня кількість замовлень на клієнта
SELECT CustomerID, COUNT(OrderID) AS OrderCount FROM Orders GROUP BY CustomerID;

-- Скільки записів відповідає певній умові (продажу понад 10 000 грн)
SELECT COUNT(*) FROM Orders WHERE TotalAmount > 10000;

-- Загальна сума всіх транзакцій
SELECT SUM(TotalAmount) AS TotalSales FROM Orders;

-- Логічні оператори
-- Всі товари дорожчі за 1000 грн
SELECT * FROM Product WHERE Price > 1000;

-- Товари, які не належать до категорії 'Електроніка'
SELECT * FROM Product WHERE Category != 'Електроніка';

-- Замовлення, зроблені після 1 лютого 2024 року
SELECT * FROM Orders WHERE OrderDate > '2024-02-01';

-- Товари з ціною між 1000 і 20000 грн
SELECT * FROM Product WHERE Price BETWEEN 1000 AND 20000;

-- Клієнти з email, що містять 'example'
SELECT * FROM Customer WHERE Contact LIKE '%example%';

-- Агрегатні функції
-- Середня вартість товару
SELECT AVG(Price) AS AvgPrice FROM Product;

-- Мінімальна і максимальна кількість товарів на складі
SELECT MIN(StockQuantity) AS MinStock, MAX(StockQuantity) AS MaxStock FROM Product;

-- Загальна кількість проданих товарів
SELECT SUM(Quantity) AS TotalProductsSold FROM OrderDetails;

-- Усі типи JOIN
-- INNER JOIN: Отримати список замовлень з деталями товарів
SELECT Orders.OrderID, Customer.Name, Product.Name, OrderDetails.Quantity, OrderDetails.Price
FROM Orders
INNER JOIN Customer ON Orders.CustomerID = Customer.CustomerID
INNER JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
INNER JOIN Product ON OrderDetails.ProductID = Product.ProductID;

-- LEFT JOIN: Отримати всіх клієнтів і їхні замовлення (навіть якщо немає замовлень)
SELECT Customer.Name, Orders.OrderID, Orders.TotalAmount
FROM Customer
LEFT JOIN Orders ON Customer.CustomerID = Orders.CustomerID;

-- RIGHT JOIN: Всі замовлення з інформацією про клієнта (навіть якщо клієнт видалений)
SELECT Orders.OrderID, Orders.TotalAmount, Customer.Name
FROM Orders
RIGHT JOIN Customer ON Orders.CustomerID = Customer.CustomerID;

-- FULL JOIN (емуляція через UNION): Всі клієнти та їхні замовлення
SELECT Customer.Name, Orders.OrderID, Orders.TotalAmount
FROM Customer
LEFT JOIN Orders ON Customer.CustomerID = Orders.CustomerID
UNION
SELECT Customer.Name, Orders.OrderID, Orders.TotalAmount
FROM Customer
RIGHT JOIN Orders ON Customer.CustomerID = Orders.CustomerID;

-- CROSS JOIN: Всі можливі комбінації товарів та клієнтів
SELECT Customer.Name, Product.Name
FROM Customer
CROSS JOIN Product;

-- SELF JOIN: Клієнти, у яких email-адреси збігаються за доменом
SELECT c1.Name AS Customer1, c2.Name AS Customer2, c1.Contact AS Email
FROM Customer c1
JOIN Customer c2 ON SUBSTRING(c1.Contact FROM POSITION('@' IN c1.Contact) FOR LENGTH(c1.Contact)) = SUBSTRING(c2.Contact FROM POSITION('@' IN c2.Contact) FOR LENGTH(c2.Contact))
WHERE c1.CustomerID <> c2.CustomerID
ORDER BY c1.Contact;

-- Складні запити
-- Підзапит: Знайти клієнтів, які робили замовлення на суму понад 15 000 грн
SELECT Name FROM Customer WHERE CustomerID IN (SELECT CustomerID FROM Orders WHERE TotalAmount > 14999);

-- EXISTS: Клієнти, які зробили хоча б одне замовлення
SELECT Name FROM Customer WHERE EXISTS (SELECT 1 FROM Orders WHERE Orders.CustomerID = Customer.CustomerID);

-- NOT EXISTS: Клієнти без замовлень
SELECT Name FROM Customer WHERE NOT EXISTS (SELECT 1 FROM Orders WHERE Orders.CustomerID = Customer.CustomerID);

-- Операції над множинами: Всі унікальні імена клієнтів та категорії товарів
SELECT Name FROM Customer
UNION
SELECT Category FROM Product;

-- INTERSECT (емуляція через INNER JOIN): Клієнти, які купували хоча б один товар
SELECT DISTINCT Customer.Name
FROM Customer
INNER JOIN Orders ON Customer.CustomerID = Orders.CustomerID;

-- EXCEPT (емуляція через LEFT JOIN): Клієнти, які не робили замовлень
SELECT Name FROM Customer
LEFT JOIN Orders ON Customer.CustomerID = Orders.CustomerID
WHERE Orders.OrderID IS NULL;

-- Common Table Expressions (CTE) 
WITH ExpensiveProducts AS (
    SELECT * FROM Product WHERE Price > 10000
)
SELECT * FROM ExpensiveProducts;

-- Віконні функції
-- Нумерація замовлень для кожного клієнта
SELECT OrderID, CustomerID, TotalAmount, ROW_NUMBER() OVER(PARTITION BY CustomerID ORDER BY OrderDate) AS OrderNum
FROM Orders;

-- Середня сума замовлення по всіх клієнтах
SELECT CustomerID, TotalAmount, AVG(TotalAmount) OVER() AS AvgTotal
FROM Orders;

-- Кількість замовлень кожного клієнта з кумулятивним підсумком
SELECT CustomerID, OrderID, COUNT(OrderID) OVER(PARTITION BY CustomerID ORDER BY OrderDate) AS CumulativeOrders
FROM Orders;
