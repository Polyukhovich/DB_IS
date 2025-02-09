INSERT INTO Product (name, category, price, stockquantity) VALUES
('Ноутбук', 'Електроніка', 25000, 10),
('Мишка', 'Комп`ютерні аксесуари', 500, 50),
('Смартфон', 'Електроніка', 15000, 20);

INSERT INTO Customer (Name, Contact) VALUES
('Іван Іванов', 'ivan@example.com'),
('Марія Петренко', 'maria@example.com');

INSERT INTO Orders (CustomerID, OrderDate, TotalAmount) VALUES
(1, '2024-02-01', 25500),
(2, '2024-02-02', 15000);

INSERT INTO OrderDetails (OrderID, ProductID, Quantity, Price) VALUES
(1, 1, 1, 25000),
(1, 2, 1, 500),
(2, 3, 1, 15000);

-- Вибірка всіх товарів
SELECT * FROM Product;

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