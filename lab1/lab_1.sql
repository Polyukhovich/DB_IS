
insert into clients (name, surname, email,phone)
values 
('James', 'Ure', 'MidgeUre8195@gmail.com', '+44 7512 345678'),
('Michael', 'Smith', 'MichaelSmith4821@gmail.com', '+1 917 456 7890'),
('Sophie', 'Taylor', 'SophieTaylor7143@gmail.com', '+49 172 1234567'),  
('Daniel', 'Wilson', 'DanielWilson9032@gmail.com', '+33 6 01 23 45 67'),  
('Emma', 'Harris', 'EmmaHarris5284@gmail.com', '+39 320 876 5432'),  
('Liam', 'Anderson', 'LiamAnderson7592@gmail.com', '+61 412 345 678'),
('Olivia', 'Martinez', 'OliviaMartinez6348@gmail.com', '+34 612 987 654'); 

insert into rooms (room_number, price_per_night)
values 
('101', '950'),  
('203', '1200'),  
('305', '850'),  
('408', '1500'),  
('512', '1100'),  
('609', '1750'),  
('710', '2000'),  
('802', '1350'),  
('911', '1600'),  
('1204', '1800');

insert into bookings(clients_id,rooms_id, booking_date)
values
(281, 682, '2024-04-20'),
(282, 683, '2024-05-01'),
(283, 684, '2024-05-13'),
(284, 685, '2024-06-05'),
(285, 686, '2024-06-15'),
(286, 687, '2024-07-02'),
(287, 688, '2024-07-10'),
(283, 689, '2024-07-21'),
(282, 690, '2024-08-05'),
(284, 683, '2024-08-12');

select * from clients;
select * from rooms;
select * from bookings;



update rooms
set price_per_night = 2500 
where rooms_id = 687;

DELETE FROM clients
where clients_id = 287;

DELETE FROM clients;
DELETE FROM rooms;
DELETE FROM bookings;