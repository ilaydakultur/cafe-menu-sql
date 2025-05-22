

-- 1. Veritabani olusturma
CREATE DATABASE cafe_management;
USE cafe_management;

-- 1. SUBE YONETIM MODULU --

CREATE TABLE BRANCHES (
    branch_id INT PRIMARY KEY,
    name VARCHAR(50),
    address VARCHAR(100),
    phone VARCHAR(15),
    email VARCHAR(50),
    opening_date DATE,
    manager_id INT,
    qr_code_url VARCHAR(255)
);

CREATE TABLE BRANCH_CONTACTS (
    contact_id INT PRIMARY KEY,
    branch_id INT,
    contact_type VARCHAR(20), 
    value VARCHAR(100),
    is_primary BIT,
    FOREIGN KEY (branch_id) REFERENCES BRANCHES(branch_id)
);


CREATE TABLE BRANCH_HOURS (
    hours_id INT PRIMARY KEY,
    branch_id INT,
    day_of_week VARCHAR(10),
    open_time TIME,
    close_time TIME,
    is_closed BIT,
    FOREIGN KEY (branch_id) REFERENCES BRANCHES(branch_id)
);


CREATE TABLE BRANCH_ZONES (
    zone_id INT PRIMARY KEY,
    branch_id INT,
    zone_name VARCHAR(20), 
    capacity INT,
    smoking_status BIT,
    FOREIGN KEY (branch_id) REFERENCES BRANCHES(branch_id)
);


CREATE TABLE QR_CODES (
    qr_id INT PRIMARY KEY,
    table_id INT,
    code_value VARCHAR(255),
    generation_date DATE,
    is_active BIT
);


CREATE TABLE BRANCH_TABLES (
    table_id INT PRIMARY KEY,
    branch_id INT,
    zone_id INT,
    table_number VARCHAR(10),
    seats INT,
    qr_code_id INT,
    FOREIGN KEY (branch_id) REFERENCES BRANCHES(branch_id),
    FOREIGN KEY (zone_id) REFERENCES BRANCH_ZONES(zone_id),
    FOREIGN KEY (qr_code_id) REFERENCES QR_CODES(qr_id)
);

CREATE TABLE BRANCH_EQUIPMENT (
    equipment_id INT PRIMARY KEY,
    branch_id INT,
    name VARCHAR(50),
    serial_number VARCHAR(50),
    purchase_date DATE,
    maintenance_schedule VARCHAR(100),
    FOREIGN KEY (branch_id) REFERENCES BRANCHES(branch_id)
);

CREATE TABLE STAFF (
    staff_id INT PRIMARY KEY,
    branch_id INT,
    first_name VARCHAR(30),
    last_name VARCHAR(30),
    role VARCHAR(30),
    hire_date DATE,
    auth_credentials VARCHAR(255),
    FOREIGN KEY (branch_id) REFERENCES BRANCHES(branch_id)
);

CREATE TABLE STAFF_SCHEDULES (
    schedule_id INT PRIMARY KEY,
    staff_id INT,
    shift_date DATE,
    start_time TIME,
    end_time TIME,
    break_duration INT,
    FOREIGN KEY (staff_id) REFERENCES STAFF(staff_id)
);

-- INSERT INTO BRANCHES
INSERT INTO BRANCHES VALUES 
(1, 'Merkez', '�stanbul, Be�ikta�', '02123334455', 'merkez@kafe.com', '2022-01-01', 1, 'qr1.png'),
(2, '�ube 2', '�zmir, Konak', '02324567890', 'konak@kafe.com', '2023-05-10', 2, 'qr2.png'),
(3, '�ube 3', 'Ankara, �ankaya', '03121234567', 'cankaya@kafe.com', '2022-07-15', 3, 'qr3.png'),
(4, '�ube 4', 'Antalya, Lara', '02428889900', 'lara@kafe.com', '2023-03-20', 4, 'qr4.png'),
(5, '�ube 5', 'Bursa, Nil�fer', '02244556677', 'nilufer@kafe.com', '2023-11-05', 5, 'qr5.png');

-- INSERT INTO BRANCH_CONTACTS
INSERT INTO BRANCH_CONTACTS VALUES 
(1, 1, 'phone', '02123334455', TRUE),
(2, 1, 'email', 'iletisim@kafe.com', FALSE),
(3, 2, 'phone', '02324567890', TRUE),
(4, 3, 'social', '@kafecankaya', TRUE),
(5, 4, 'email', 'lara@kafe.com', TRUE);

-- INSERT INTO BRANCH_HOURS
INSERT INTO BRANCH_HOURS VALUES 
(1, 1, 'Monday', '08:00:00', '22:00:00', FALSE),
(2, 1, 'Sunday', NULL, NULL, TRUE),
(3, 2, 'Monday', '09:00:00', '23:00:00', FALSE),
(4, 2, 'Saturday', '10:00:00', '00:00:00', FALSE),
(5, 3, 'Friday', '08:30:00', '22:30:00', FALSE);

-- INSERT INTO BRANCH_ZONES
INSERT INTO BRANCH_ZONES VALUES 
(1, 1, 'Teras', 20, TRUE),
(2, 1, '�� Mekan', 30, FALSE),
(3, 2, 'VIP', 10, FALSE),
(4, 3, 'Teras', 25, TRUE),
(5, 4, '�� Mekan', 40, FALSE);

-- INSERT INTO QR_CODES
INSERT INTO QR_CODES VALUES 
(1, NULL, 'QR1001', '2024-01-01', TRUE),
(2, NULL, 'QR1002', '2024-01-02', TRUE),
(3, NULL, 'QR1003', '2024-01-03', TRUE),
(4, NULL, 'QR1004', '2024-01-04', TRUE),
(5, NULL, 'QR1005', '2024-01-05', TRUE);

-- INSERT INTO BRANCH_TABLES
INSERT INTO BRANCH_TABLES VALUES 
(1, 1, 1, 'T1', 4, 1),
(2, 1, 2, 'I1', 2, 2),
(3, 2, 3, 'V1', 6, 3),
(4, 3, 4, 'T2', 4, 4),
(5, 4, 5, 'I2', 4, 5);

-- INSERT INTO BRANCH_EQUIPMENT
INSERT INTO BRANCH_EQUIPMENT VALUES 
(1, 1, 'Espresso Makinesi', 'EX12345', '2022-01-10', '3 ayda bir'),
(2, 1, 'Buzdolab�', 'FR99887', '2022-02-05', '6 ayda bir'),
(3, 2, 'Pos Cihaz�', 'POS55888', '2023-01-01', 'Y�lda bir'),
(4, 3, 'F�r�n', 'OV12398', '2022-11-15', '4 ayda bir'),
(5, 4, 'Blender', 'BL19283', '2023-03-20', '6 ayda bir');

-- INSERT INTO STAFF
INSERT INTO STAFF VALUES 
(1, 1, 'Ahmet', 'Y�lmaz', 'M�d�r', '2022-01-01', 'ahmet123'),
(2, 2, 'Ay�e', 'Demir', 'Barista', '2023-05-10', 'ayse456'),
(3, 3, 'Mehmet', 'Kaya', 'Garson', '2022-07-15', 'mehmet789'),
(4, 4, 'Elif', '�elik', 'M�d�r', '2023-03-20', 'elif321'),
(5, 5, 'Ali', 'Ko�', '�ef', '2023-11-05', 'ali654');

-- INSERT INTO STAFF_SCHEDULES
INSERT INTO STAFF_SCHEDULES VALUES 
(1, 1, '2025-05-10', '08:00:00', '16:00:00', 30),
(2, 2, '2025-05-10', '10:00:00', '18:00:00', 45),
(3, 3, '2025-05-10', '09:00:00', '17:00:00', 30),
(4, 4, '2025-05-10', '08:00:00', '16:00:00', 60),
(5, 5, '2025-05-10', '14:00:00', '22:00:00', 30);



-- 2. MENU YONETIM MODULU --

CREATE TABLE MENU_CATEGORIES (
    category_id INT PRIMARY KEY,
    name VARCHAR(50),
    description TEXT,
    display_order INT,
    image_url VARCHAR(255)
);

CREATE TABLE MENU_ITEMS (
    item_id INT PRIMARY KEY,
    category_id INT,
    name VARCHAR(50),
    description TEXT,
    base_price DECIMAL(6,2),
    preparation_time INT,
    is_active BIT, 
    FOREIGN KEY (category_id) REFERENCES MENU_CATEGORIES(category_id)
);

CREATE TABLE ITEM_MODIFIERS (
    modifier_id INT PRIMARY KEY,
    item_id INT,
    name VARCHAR(50),
    additional_price DECIMAL(5,2),
    is_required BIT,
    FOREIGN KEY (item_id) REFERENCES MENU_ITEMS(item_id)
);


CREATE TABLE MODIFIER_OPTIONS (
    option_id INT PRIMARY KEY,
    modifier_id INT,
    name VARCHAR(50),
    price_adjustment DECIMAL(5,2),
    FOREIGN KEY (modifier_id) REFERENCES ITEM_MODIFIERS(modifier_id)
);

CREATE TABLE ITEM_ALLERGENS (
    allergen_id INT PRIMARY KEY,
    item_id INT,
    allergen_type VARCHAR(30),
    severity VARCHAR(20),
    FOREIGN KEY (item_id) REFERENCES MENU_ITEMS(item_id)
);

CREATE TABLE ITEM_NUTRITION (
    nutrition_id INT PRIMARY KEY,
    item_id INT,
    calories INT,
    protein DECIMAL(5,2),
    carbs DECIMAL(5,2),
    fat DECIMAL(5,2),
    FOREIGN KEY (item_id) REFERENCES MENU_ITEMS(item_id)
);

CREATE TABLE ITEM_IMAGES (
    image_id INT PRIMARY KEY,
    item_id INT,
    image_url VARCHAR(255),
    is_primary BIT, 
    display_order INT,
    FOREIGN KEY (item_id) REFERENCES MENU_ITEMS(item_id)
);


CREATE TABLE MENU_PROMOTIONS (
    promotion_id INT PRIMARY KEY,
    name VARCHAR(100),
    discount_type ENUM('percentage', 'fixed'),
    value DECIMAL(5,2),
    start_date DATE,
    end_date DATE
);

CREATE TABLE PROMOTION_ITEMS (
    promotion_item_id INT PRIMARY KEY,
    promotion_id INT,
    item_id INT,
    FOREIGN KEY (promotion_id) REFERENCES MENU_PROMOTIONS(promotion_id),
    FOREIGN KEY (item_id) REFERENCES MENU_ITEMS(item_id)
);

CREATE TABLE SEASONAL_MENUS (
    seasonal_id INT PRIMARY KEY,
    name VARCHAR(100),
    start_date DATE,
    end_date DATE,
    is_active BIT
);


-- INSERT INTO MENU_CATEGORIES
INSERT INTO MENU_ITEMS VALUES
(1, 1, 'Espresso', 'Sade kahve', 70.00, 5, TRUE),
(2, 1, 'Cappuccino', 'S�tl� kahve', 120.00, 4, TRUE),
(3, 1, 'Latte', 'S�tl� kahve', 120.00, 5, TRUE),
(4, 1, 'Americano', 'Sade kahve', 100.00, 4, TRUE),
(5, 1, 'Cold Brew', 'So�uk kahve', 95.00, 6, TRUE),
(6, 1, 'T�rk Kahvesi', 'T�rk usul� kahve', 85.00, 7, TRUE),
(7, 2, 'San Sebastian Cheesecake', 'San Sebastian cheesecake', 210.00, 3, TRUE),
(8, 2, 'Havu�lu Kek', 'Havu�lu kek', 180.00, 5, TRUE),
(9, 2, 'Muzlu Magnolia', 'Muzlu magnolia tatl�s�', 195.00, 4, TRUE),
(10, 2, '�ikolatal� Sufle', '�ikolatal� sufle', 200.00, 3, TRUE),
(11, 2, 'Frambuazl� Tart', 'Frambuazl� tart', 160.00, 6, TRUE),
(12, 3, '�ikolatal� Kurabiye', '�ikolatal� kurabiye', 100.00, 8, TRUE),
(13, 3, 'F�nd�kl� Kurabiye', 'F�nd�kl� kurabiye', 110.00, 7, TRUE),
(14, 3, 'Tereya�l� Kurabiye', 'Tereya�l� kurabiye', 80.00, 9, TRUE),
(15, 3, 'Red Velvet Cookie', 'Red velvet kurabiye', 110.00, 6, TRUE),
(16, 3, 'Antep F�st�kl� Kurabiye', 'Antep f�st�kl� kurabiye', 130.00, 4, TRUE),
(17, 4, 'Sade Kruvasan', 'Klasik sade kruvasan', 125.00, 5, TRUE),
(18, 4, 'Mini Sandvi�', 'Mini sandvi�', 150.00, 4, TRUE),
(19, 4, 'Tavuklu Wrap', 'Tavuklu wrap', 210.00, 8, TRUE),
(20, 4, 'Zeytinli A�ma', 'Zeytinli a�ma', 80.00, 6, TRUE),
(21, 4, 'Tuzlu Kurabiye', 'Tuzlu kurabiye', 95.00, 7, TRUE);

-- INSERT INTO MENU_ITEMS
INSERT INTO MENU_ITEMS VALUES 
(1, 1, 'Latte', 'S�tl� kahve', 45.00, 5, TRUE),
(2, 1, 'Americano', 'Sade kahve', 40.00, 4, TRUE),
(3, 2, 'Cheesecake', 'Frambuazl� cheesecake', 60.00, 10, TRUE),
(4, 3, 'Kola', 'So�uk kola', 20.00, 1, TRUE),
(5, 5, 'Tavuk Sandvi�', 'Izgara tavuklu sandvi�', 55.00, 8, TRUE);

-- INSERT INTO ITEM_MODIFIERS
INSERT INTO ITEM_MODIFIERS VALUES 
(1, 1, 'S�t Se�imi', 5.00, TRUE),
(2, 2, 'Boyut', 3.00, FALSE),
(3, 3, 'Sos Se�imi', 2.00, FALSE),
(4, 4, 'Buz Miktar�', 0.00, FALSE),
(5, 5, 'Ekmek T�r�', 0.00, TRUE);

-- INSERT INTO MODIFIER_OPTIONS
INSERT INTO MODIFIER_OPTIONS VALUES 
(1, 1, 'Laktozsuz', 3.00),
(2, 1, 'Badem S�t�', 5.00),
(3, 2, 'B�y�k', 3.00),
(4, 2, 'Orta', 0.00),
(5, 5, '�avdar', 0.00);

-- INSERT INTO ITEM_ALLERGENS
INSERT INTO ITEM_ALLERGENS VALUES 
(1, 1, 'Laktoz', 'Orta'),
(2, 3, 'Gluten', 'Y�ksek'),
(3, 5, 'Hardal', 'D���k'),
(4, 2, 'Kafein', 'D���k'),
(5, 4, 'Karbondioksit', 'D���k');

-- INSERT INTO ITEM_NUTRITION
INSERT INTO ITEM_NUTRITION VALUES 
(1, 1, 150, 4.5, 12.0, 6.0),
(2, 2, 10, 0.0, 2.0, 0.0),
(3, 3, 320, 5.0, 35.0, 20.0),
(4, 4, 110, 0.0, 27.0, 0.0),
(5, 5, 250, 15.0, 28.0, 12.0);

-- INSERT INTO ITEM_IMAGES
INSERT INTO ITEM_IMAGES VALUES 
(1, 1, 'latte.jpg', TRUE, 1),
(2, 2, 'americano.jpg', TRUE, 1),
(3, 3, 'cheesecake.jpg', TRUE, 1),
(4, 4, 'cola.jpg', TRUE, 1),
(5, 5, 'sandwich.jpg', TRUE, 1);

-- INSERT INTO MENU_PROMOTIONS
INSERT INTO MENU_PROMOTIONS VALUES 
(1, 'Tatl� + Kahve', 'percentage', 20.00, '2025-05-01', '2025-05-31'),
(2, '�kili ��ecek', 'fixed', 5.00, '2025-06-01', '2025-06-30'),
(3, 'Sandvi� Men�s�', 'percentage', 15.00, '2025-05-15', '2025-06-15'),
(4, 'Kahve Saati', 'fixed', 10.00, '2025-05-01', '2025-05-31'),
(5, 'Yaz Kampanyas�', 'percentage', 10.00, '2025-07-01', '2025-08-31');

-- INSERT INTO PROMOTION_ITEMS
INSERT INTO PROMOTION_ITEMS VALUES 
(1, 1, 1),
(2, 1, 3),
(3, 2, 4),
(4, 3, 5),
(5, 4, 2);

-- INSERT INTO SEASONAL_MENUS
INSERT INTO SEASONAL_MENUS VALUES 
(1, 'Yaz Men�s�', '2025-06-01', '2025-08-31', TRUE),
(2, 'K�� Men�s�', '2025-12-01', '2026-02-28', FALSE),
(3, 'Bahar Men�s�', '2025-03-01', '2025-05-31', TRUE),
(4, 'Sonbahar Men�s�', '2025-09-01', '2025-11-30', FALSE),
(5, 'Y�lba�� �zel', '2025-12-25', '2026-01-01', TRUE);



-- 3. SIPARIS YONETIM MODULU --

CREATE TABLE ORDERS (
    order_id INT PRIMARY KEY,
    table_id INT,
    staff_id INT,
    order_time DATETIME,
    status VARCHAR(20),
    total_amount DECIMAL(8,2),
    FOREIGN KEY (table_id) REFERENCES BRANCH_TABLES(table_id),
    FOREIGN KEY (staff_id) REFERENCES STAFF(staff_id)
);

CREATE TABLE ORDER_ITEMS (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    item_id INT,
    quantity INT,
    special_instructions TEXT,
    FOREIGN KEY (order_id) REFERENCES ORDERS(order_id),
    FOREIGN KEY (item_id) REFERENCES MENU_ITEMS(item_id)
);

CREATE TABLE ORDER_ITEM_MODIFIERS (
    order_modifier_id INT PRIMARY KEY,
    order_item_id INT,
    modifier_id INT,
    option_id INT,
    FOREIGN KEY (order_item_id) REFERENCES ORDER_ITEMS(order_item_id),
    FOREIGN KEY (modifier_id) REFERENCES ITEM_MODIFIERS(modifier_id),
    FOREIGN KEY (option_id) REFERENCES MODIFIER_OPTIONS(option_id)
);

CREATE TABLE ORDER_STATUS_HISTORY (
    status_id INT PRIMARY KEY,
    order_id INT,
    status VARCHAR(20),
    timestamp DATETIME,
    staff_id INT,
    FOREIGN KEY (order_id) REFERENCES ORDERS(order_id),
    FOREIGN KEY (staff_id) REFERENCES STAFF(staff_id)
);

CREATE TABLE PAYMENTS (
    payment_id INT PRIMARY KEY,
    order_id INT,
    amount DECIMAL(8,2),
    payment_method VARCHAR(20),
    payment_status VARCHAR(20),
    transaction_time DATETIME,
    FOREIGN KEY (order_id) REFERENCES ORDERS(order_id)
);

CREATE TABLE INVOICES (
    invoice_id INT PRIMARY KEY,
    order_id INT,
    invoice_number VARCHAR(20),
    issue_date DATE,
    tax_amount DECIMAL(6,2),
    discount_amount DECIMAL(6,2),
    FOREIGN KEY (order_id) REFERENCES ORDERS(order_id)
);

CREATE TABLE KITCHEN_DISPLAY (
    display_id INT PRIMARY KEY,
    order_item_id INT,
    preparation_status VARCHAR(20),
    priority_level INT,
    FOREIGN KEY (order_item_id) REFERENCES ORDER_ITEMS(order_item_id)
);

CREATE TABLE WASTE_TRACKING (
    waste_id INT PRIMARY KEY,
    item_id INT,
    quantity INT,
    reason TEXT,
    staff_id INT,
    timestamp DATETIME,
    FOREIGN KEY (item_id) REFERENCES MENU_ITEMS(item_id),
    FOREIGN KEY (staff_id) REFERENCES STAFF(staff_id)
);

CREATE TABLE INVENTORY_ADJUSTMENTS (
    adjustment_id INT PRIMARY KEY,
    item_id INT,
    quantity INT,
    reason TEXT,
    staff_id INT,
    adjustment_date DATE,
    FOREIGN KEY (item_id) REFERENCES MENU_ITEMS(item_id),
    FOREIGN KEY (staff_id) REFERENCES STAFF(staff_id)
);

-- INSERT INTO ORDERS
INSERT INTO ORDERS VALUES 
(1, 1, 1, '2025-05-12 09:00:00', 'received', 105.00),
(2, 2, 2, '2025-05-12 10:30:00', 'preparing', 85.00),
(3, 3, 3, '2025-05-12 11:45:00', 'ready', 120.00),
(4, 4, 4, '2025-05-12 13:00:00', 'delivered', 60.00),
(5, 5, 5, '2025-05-12 14:15:00', 'received', 75.00);

-- INSERT INTO ORDER_ITEMS
INSERT INTO ORDER_ITEMS VALUES 
(1, 1, 1, 1, 'S�t laktozsuz olsun'),
(2, 2, 3, 1, ''),
(3, 3, 5, 1, 'Ekmek �avdar'),
(4, 4, 2, 2, ''),
(5, 5, 4, 1, 'Buzsuz');

-- INSERT INTO ORDER_ITEM_MODIFIERS
INSERT INTO ORDER_ITEM_MODIFIERS VALUES 
(1, 1, 1, 1),
(2, 3, 5, 5),
(3, 4, 2, 4),
(4, 2, 3, 3),
(5, 5, 4, 4);

-- INSERT INTO ORDER_STATUS_HISTORY
INSERT INTO ORDER_STATUS_HISTORY VALUES 
(1, 1, 'received', '2025-05-12 09:00:00', 1),
(2, 2, 'preparing', '2025-05-12 10:40:00', 2),
(3, 3, 'ready', '2025-05-12 12:00:00', 3),
(4, 4, 'delivered', '2025-05-12 13:15:00', 4),
(5, 5, 'received', '2025-05-12 14:20:00', 5);

-- INSERT INTO PAYMENTS
INSERT INTO PAYMENTS VALUES 
(1, 1, 105.00, 'credit_card', 'paid', '2025-05-12 09:10:00'),
(2, 2, 85.00, 'cash', 'paid', '2025-05-12 10:45:00'),
(3, 3, 120.00, 'mobile_pay', 'pending', '2025-05-12 12:00:00'),
(4, 4, 60.00, 'credit_card', 'paid', '2025-05-12 13:20:00'),
(5, 5, 75.00, 'cash', 'paid', '2025-05-12 14:30:00');

-- INSERT INTO INVOICES
INSERT INTO INVOICES VALUES 
(1, 1, 'INV001', '2025-05-12', 8.00, 5.00),
(2, 2, 'INV002', '2025-05-12', 6.50, 4.00),
(3, 3, 'INV003', '2025-05-12', 9.00, 6.00),
(4, 4, 'INV004', '2025-05-12', 4.00, 3.00),
(5, 5, 'INV005', '2025-05-12', 5.00, 2.50);

-- INSERT INTO KITCHEN_DISPLAY
INSERT INTO KITCHEN_DISPLAY VALUES 
(1, 1, 'in_progress', 1),
(2, 2, 'queued', 2),
(3, 3, 'ready', 1),
(4, 4, 'in_progress', 3),
(5, 5, 'queued', 2);

-- INSERT INTO WASTE_TRACKING
INSERT INTO WASTE_TRACKING VALUES 
(1, 3, 1, 'Yanm�� tatl�', 3, '2025-05-12 12:05:00'),
(2, 4, 2, 'Gaz ka�t�', 4, '2025-05-12 13:25:00'),
(3, 2, 1, 'Yanl�� sipari�', 2, '2025-05-12 10:50:00'),
(4, 1, 1, 'So�udu', 1, '2025-05-12 09:20:00'),
(5, 5, 1, 'Ekmek bayat', 5, '2025-05-12 14:40:00');

-- INSERT INTO INVENTORY_ADJUSTMENTS
INSERT INTO INVENTORY_ADJUSTMENTS VALUES 
(1, 1, -1, 'Kullan�m sonras� stok d���r�ld�', 1, '2025-05-12'),
(2, 2, -1, 'Hatal� giri�', 2, '2025-05-12'),
(3, 3, -1, '�ade edildi', 3, '2025-05-12'),
(4, 4, -1, 'K�r�k �i�e', 4, '2025-05-12'),
(5, 5, -1, 'G�n sonu d���m�', 5, '2025-05-12');


-- 4. MUSTERI YONETIM MODULU --

CREATE TABLE CUSTOMERS (
    customer_id INT PRIMARY KEY,
    phone VARCHAR(15),
    email VARCHAR(50),
    registration_date DATE,
    last_visit_date DATE
);

CREATE TABLE CUSTOMER_PREFERENCES (
    preference_id INT PRIMARY KEY,
    customer_id INT,
    favorite_items TEXT,
    dietary_restrictions TEXT,
    FOREIGN KEY (customer_id) REFERENCES CUSTOMERS(customer_id)
);

CREATE TABLE CUSTOMER_ORDERS (
    customer_order_id INT PRIMARY KEY,
    customer_id INT,
    order_id INT,
    visit_purpose TEXT,
    FOREIGN KEY (customer_id) REFERENCES CUSTOMERS(customer_id),
    FOREIGN KEY (order_id) REFERENCES ORDERS(order_id)
);

CREATE TABLE REVIEWS (
    review_id INT PRIMARY KEY,
    customer_id INT,
    item_id INT,
    rating INT,
    comment TEXT,
    review_date DATE,
    FOREIGN KEY (customer_id) REFERENCES CUSTOMERS(customer_id),
    FOREIGN KEY (item_id) REFERENCES MENU_ITEMS(item_id)
);

CREATE TABLE LOYALTY_PROGRAM (
    loyalty_id INT PRIMARY KEY,
    customer_id INT,
    points_balance INT,
    membership_level VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES CUSTOMERS(customer_id)
);

CREATE TABLE LOYALTY_TRANSACTIONS (
    transaction_id INT PRIMARY KEY,
    loyalty_id INT,
    order_id INT,
    points_earned INT,
    points_redeemed INT,
    FOREIGN KEY (loyalty_id) REFERENCES LOYALTY_PROGRAM(loyalty_id),
    FOREIGN KEY (order_id) REFERENCES ORDERS(order_id)
);

CREATE TABLE RESERVATIONS (
    reservation_id INT PRIMARY KEY,
    customer_id INT,
    branch_id INT,
    table_id INT,
    reservation_time DATETIME,
    FOREIGN KEY (customer_id) REFERENCES CUSTOMERS(customer_id),
    FOREIGN KEY (branch_id) REFERENCES BRANCHES(branch_id),
    FOREIGN KEY (table_id) REFERENCES BRANCH_TABLES(table_id)
);

-- CUSTOMERS INSERT
INSERT INTO CUSTOMERS VALUES 
(1, '05330001111', 'ali@example.com', '2024-01-10', '2025-05-12'),
(2, '05330002222', 'ayse@example.com', '2023-12-05', '2025-05-11'),
(3, '05330003333', 'mehmet@example.com', '2024-02-20', '2025-05-10'),
(4, '05330004444', 'fatma@example.com', '2024-04-15', '2025-05-09'),
(5, '05330005555', 'ahmet@example.com', '2024-03-30', '2025-05-08');

-- CUSTOMER_PREFERENCES INSERT
INSERT INTO CUSTOMER_PREFERENCES VALUES 
(1, 1, 'Latte,Cheesecake', 'Laktozsuz'),
(2, 2, 'Tavuk Sandvi�', 'Glutensiz'),
(3, 3, 'Americano', NULL),
(4, 4, 'Kola', '�ekersiz'),
(5, 5, 'Cheesecake,Latte', 'Laktozsuz,Glutensiz');

-- CUSTOMER_ORDERS INSERT
INSERT INTO CUSTOMER_ORDERS VALUES 
(1, 1, 1, '�� G�r��mesi'),
(2, 2, 2, '��le Yeme�i'),
(3, 3, 3, 'Dostlarla Bulu�ma'),
(4, 4, 4, 'Yaln�z Kahve Molas�'),
(5, 5, 5, 'Ders �al��ma');

-- REVIEWS INSERT
INSERT INTO REVIEWS VALUES 
(1, 1, 1, 5, 'M�kemmel latte!', '2025-05-12'),
(2, 2, 3, 4, 'Cheesecake biraz sertti', '2025-05-11'),
(3, 3, 2, 3, 'Americano �ok yo�undu', '2025-05-10'),
(4, 4, 4, 4, '�yi ama buzsuz istemi�tim', '2025-05-09'),
(5, 5, 5, 5, 'Sandvi� efsaneydi!', '2025-05-08');

-- LOYALTY_PROGRAM INSERT
INSERT INTO LOYALTY_PROGRAM VALUES 
(1, 1, 100, 'Silver'),
(2, 2, 200, 'Gold'),
(3, 3, 50, 'Bronze'),
(4, 4, 300, 'Gold'),
(5, 5, 400, 'Platinum');

-- LOYALTY_TRANSACTIONS INSERT
INSERT INTO LOYALTY_TRANSACTIONS VALUES 
(1, 1, 1, 10, 0),
(2, 2, 2, 15, 5),
(3, 3, 3, 5, 0),
(4, 4, 4, 20, 10),
(5, 5, 5, 25, 15);

-- RESERVATIONS INSERT
INSERT INTO RESERVATIONS VALUES 
(1, 1, 1, 1, '2025-05-13 10:00:00'),
(2, 2, 2, 2, '2025-05-13 12:00:00'),
(3, 3, 3, 3, '2025-05-13 14:00:00'),
(4, 4, 4, 4, '2025-05-13 16:00:00'),
(5, 5, 5, 5, '2025-05-13 18:00:00');
