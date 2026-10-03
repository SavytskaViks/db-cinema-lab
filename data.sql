\c cinema_db

INSERT INTO cinema_category (name, price_coefficient) VALUES
('Преміум',  1.50),
('Стандарт', 1.00),
('Економ',   0.75);

INSERT INTO cinema (name, district, address, category_id, status) VALUES
('Multiplex',                 'Франківський',   'вул. Кульпарківська, 226А',     1, 'Active'),
('Multiplex',                 'Шевченківський', 'вул. Гетьмана Мазепи, 1Б',      1, 'Active'),
('Планета Кіно',              'Галицький',      'вул. Під Дубом, 7Б',            2, 'Active'),
('Планета Кіно',              'Сихівський',     'вул. Стрийська, 30',            2, 'Active'),
('Кінопалац ім. О. Довженка', 'Сихівський',     'просп. Червоної Калини, 81',    3, 'Under Repair'),
('Lviv Film Center',          'Франківський',   'вул. Володимира Великого, 14А', 1, 'Active'),
('Коперник',                  'Галицький',      'вул. Коперника, 9',             2, 'Active'),
('Київ',                      'Галицький',      'просп. Шевченка, 8',            3, 'Closed');

INSERT INTO hall (name, capacity, cinema_id) VALUES
('Зал 1',       150, 1),  
('VIP-зал',      80, 1), 
('Зал 1',       200, 2),  
('Зал 1',       120, 3), 
('Зал 2',        60, 3), 
('Зал 1',       180, 4),  
('Зал 1',       100, 5),  
('Зал 1',        90, 6),  
('Зал 2',        50, 6),  
('Зал 1',        70, 7),  
('Зал 1',       110, 8);  

INSERT INTO film (title, director, cinematographer, duration, has_awards, rental_status, promo_image) VALUES
('Людина-павук: Абсолютно новий день', 'Дестін Деніел Креттон', 'Бретт Павлак', 145, TRUE,  TRUE, 'https://images.unsplash.com/photo-1635863138275-d9b33299680b'),
('Над безоднею 2',                     'Майкл Спіріґ',          'Ендрю Стрехорн', 100, FALSE, TRUE, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTUgMaw1cp0iIIGRttHOUDve2lswTLTSzwrw22NFC-5Qw&s=10'),
('Потяг Червона Рута',                 'Олексій Єсаков',        'Юрій Король',   90, TRUE,  TRUE, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRQOXgka1WspfHDgSeQ5ua1k0k-6KHyD3F595jJnXthEw&s=10'),
('Форсаж',                             'Роб Коен',              'Еріксон Кор',   106, TRUE,  TRUE, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSzGP_q9T1cL_vI-oY-MVvenYjarNgs6weYFP-eoxSZcw&s=10'),
('Практична магія 2',                  'Сюзанна Бір',           'Саймон Дагган', 120, FALSE, TRUE, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ3Phy8xKk5Ba2Yi-yaHQbU43fRI9zZ75pFZfhFD3M_lg&s=10'),
('Одіссея',                            'Крістофер Нолан',       'Хойте ван Хойтем', 192, TRUE, TRUE, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTTiinfSx3QES1NbEF9AXsZTVE1uU9pCt-3Zr_iMatjOg&s=10');

INSERT INTO genre (name) VALUES
('Фантастика'),
('Пригоди'),
('Драма'),
('Комедія'),
('Екшн'),
('Трилер'),
('Анімація'),
('Романтика'),
('Історичний');

INSERT INTO country (name) VALUES
('США'),
('Україна'),
('Велика Британія'),
('Франція'),
('Німеччина'),
('Японія');

INSERT INTO actor (full_name) VALUES
('Том Голланд'),
('Том Бріттні'),
('Вірджинія Ґарднер'),
('Юрій Горбунов'),
('Станіслав Боклан'),
('Він Дізель'),
('Ніколь Кідман'),
('Сандра Буллок'),
('Метт Деймон');

INSERT INTO film_genre (film_id, genre_id) VALUES
(1, 1), (1, 2), (1, 5),
(2, 2), (2, 6),
(3, 4), (3, 8),
(4, 5), (4, 6),
(5, 1), (5, 4), (5, 8),
(6, 1), (6, 3);

INSERT INTO film_country (film_id, country_id) VALUES
(1, 1),
(2, 1), (2, 3),
(3, 2),
(4, 1),
(5, 1),
(6, 1);

INSERT INTO film_actor (film_id, actor_id, is_lead) VALUES
(1, 1, TRUE),
(2, 2, TRUE), (2, 3, FALSE),
(3, 4, TRUE), (3, 5, TRUE),
(4, 6, TRUE),
(5, 7, TRUE), (5, 8, TRUE),
(6, 1, FALSE), (6, 9, TRUE);

INSERT INTO repertoire (cinema_id, film_id, rental_cost, show_start, show_end, status) VALUES
(1, 1, 12000.00, '2026-09-01', '2026-10-31', 'Active'),  
(2, 1, 12500.00, '2026-09-01', '2026-10-31', 'Active'),  
(3, 3, 14000.00, '2026-09-01', '2026-10-31', 'Active'), 
(4, 3, 12000.00, '2026-09-01', '2026-10-31', 'Active'), 
(7, 3, 11000.00, '2026-09-01', '2026-10-31', 'Active'), 
(6, 4, 10000.00, '2026-09-01', '2026-10-31', 'Active'), 
(1, 6, 15000.00, '2026-09-01', '2026-10-31', 'Active'), 
(2, 6, 12000.00, '2026-09-01', '2026-10-31', 'Active'), 
(3, 5, 13000.00, '2026-09-01', '2026-10-31', 'Active'), 
(6, 2,  7000.00, '2026-09-01', '2026-10-31', 'Active'),  
(7, 6, 20000.00, '2026-09-01', '2026-10-31', 'Active'),  
(3, 2, 11000.00, '2026-09-01', '2026-10-31', 'Active'),  
(6, 5,  8500.00, '2026-09-01', '2026-10-31', 'Active'),  
(1, 4,  9000.00, '2026-10-01', '2026-10-31', 'Active');  

INSERT INTO session (repertoire_id, hall_id, start_time, time_coefficient) VALUES
(1,  1,  '2026-09-25 14:00', 1.00),
(2,  3,  '2026-09-25 17:00', 1.00),
(3,  4,  '2026-09-25 16:00', 1.00),
(4,  6,  '2026-09-25 19:00', 1.20),
(5,  10, '2026-09-25 20:30', 1.20),
(6,  8,  '2026-09-25 21:00', 1.20),
(7,  1,  '2026-09-26 15:00', 1.00),
(8,  3,  '2026-09-26 18:00', 1.20),
(9,  4,  '2026-09-26 13:00', 1.00),
(10, 9,  '2026-09-26 20:00', 1.20),
(1,  2,  '2026-09-26 21:30', 1.20),
(3,  5,  '2026-09-27 15:00', 1.00),
(11, 10, '2026-09-27 17:00', 1.00),
(12, 4,  '2026-09-27 19:00', 1.20),
(13, 8,  '2026-09-27 21:00', 1.20);

INSERT INTO ticket (session_id, seat_number, status) VALUES
(1, 1,  'Sold'),
(1, 2,  'Sold'),
(1, 3,  'Booked'),
(1, 4,  'Available'),
(2, 1,  'Sold'),
(3, 5,  'Sold'),
(3, 6,  'Available'),
(4, 10, 'Booked'),
(6, 2,  'Sold'),
(7, 1,  'Available');




