/*
Caso 01 - Preliminar #1
Esteban Guzmán Ramírez - 2015095861
*/
USE master

GO

CREATE DATABASE caso01

GO 

USE caso01

GO

CREATE TABLE StorageTypes(
  id_Storage_type INT IDENTITY(1,1) PRIMARY KEY,
  type_name NVARCHAR(255) NOT NULL
);

CREATE TABLE CollaboratorsTypes(
  id_type INT IDENTITY(1,1) PRIMARY KEY,
  type_name NVARCHAR(255) NOT NULL
);

CREATE TABLE TrucksTypes(
  id_type INT IDENTITY(1,1) PRIMARY KEY,
  type_name NVARCHAR(255) NOT NULL
);

CREATE TABLE PreparationsTypes(
  id_type INT IDENTITY(1,1) PRIMARY KEY,
  type_name NVARCHAR(255) NOT NULL
);

CREATE TABLE ContactTypes(
  id_type INT IDENTITY(1,1) PRIMARY KEY,
  type_name NVARCHAR(255) NOT NULL
);
--
CREATE TABLE CommentTypes(
  id_type INT IDENTITY(1,1) PRIMARY KEY,
  type_name NVARCHAR(255) NOT NULL
);

CREATE TABLE DeliveryStatus(
  id_status INT IDENTITY(1,1) PRIMARY KEY,
  status_name NVARCHAR(255) NOT NULL
);

CREATE TABLE OrderStatus(
  id_status INT IDENTITY(1,1) PRIMARY KEY,
  status_name NVARCHAR(255) NOT NULL
);

CREATE TABLE PreparationsStatus(
  id_status INT IDENTITY(1,1) PRIMARY KEY,
  status_name NVARCHAR(255) NOT NULL
);

CREATE TABLE RefillsStatus(
  id_status INT IDENTITY(1,1) PRIMARY KEY,
  status_name NVARCHAR(255) NOT NULL
);

CREATE TABLE ProductsStatus(
  id_status INT IDENTITY(1,1) PRIMARY KEY,
  status_name NVARCHAR(255) NOT NULL
);

CREATE TABLE TrucksStatus(
  id_status INT IDENTITY(1,1) PRIMARY KEY,
  status_name NVARCHAR(255) NOT NULL
);

CREATE TABLE StorageStatus(
  id_status INT IDENTITY(1,1) PRIMARY KEY,
  status_name NVARCHAR(255) NOT NULL
);

CREATE TABLE RoutesStatus(
  id_status INT IDENTITY(1,1) PRIMARY KEY,
  status_name NVARCHAR(255) NOT NULL
);
--
CREATE TABLE PaymenMethods(
  id_payment_method INT IDENTITY(1,1) PRIMARY KEY,
  payment_name NVARCHAR(255) NOT NULL,
  [enabled] BIT NOT NULL DEFAULT 1,
  deleted BIT NOT NULL DEFAULT 0
);

CREATE TABLE Units(
  id_unit INT IDENTITY(1,1) PRIMARY KEY,
  unit_name NVARCHAR(255) NOT NULL,
  [enabled] BIT NOT NULL DEFAULT 1,
  deleted BIT NOT NULL DEFAULT 0
);

CREATE TABLE Countries(
  id_country INT IDENTITY(1, 1) PRIMARY KEY,
  country_name NVARCHAR(255) NOT NULL,
  [enabled] BIT NOT NULL DEFAULT 1,
  deleted BIT NOT NULL DEFAULT 0
);

CREATE TABLE States(
  id_state INT IDENTITY(1, 1) PRIMARY KEY,
  state_name NVARCHAR(255) NOT NULL,
  id_country INT FOREIGN KEY REFERENCES Countries(id_country),
  [enabled] BIT NOT NULL DEFAULT 1,
  deleted BIT NOT NULL DEFAULT 0
);

CREATE TABLE Districts(
  id_district INT IDENTITY(1, 1) PRIMARY KEY,
  district_name NVARCHAR(255) NOT NULL,
  id_state INT FOREIGN KEY REFERENCES States(id_state),
  [enabled] BIT NOT NULL DEFAULT 1,
  deleted BIT NOT NULL DEFAULT 0
);

CREATE TABLE Addresses(
  id_address INT IDENTITY(1, 1) PRIMARY KEY,
  id_district INT FOREIGN KEY REFERENCES Districts(id_district),
  address_1 NVARCHAR(255) NOT NULL,
  address_2 NVARCHAR(255),
  delivery_geo GEOGRAPHY,
  [enabled] BIT NOT NULL DEFAULT 1,
  deleted BIT NOT NULL DEFAULT 0
);
--
CREATE TABLE Persons(
  id_person INT IDENTITY(1, 1) PRIMARY KEY,
  person_name NVARCHAR(255) NOT NULL,
  last_name NVARCHAR(255) NOT NULL,
  username NVARCHAR(100) NOT NULL UNIQUE,
  person_password NVARCHAR(100) NOT NULL
);

CREATE TABLE Producers(
  id_producer INT IDENTITY(1, 1) PRIMARY KEY,
  producer_name NVARCHAR(255) NOT NULL,
  [enabled] BIT NOT NULL DEFAULT 1,
  deleted BIT NOT NULL DEFAULT 0
);

CREATE TABLE Collaborators(
  id_collaborator INT IDENTITY(1, 1) PRIMARY KEY,
  id_boss INT FOREIGN KEY REFERENCES Collaborators(id_collaborator),
  id_person INT FOREIGN KEY REFERENCES Persons(id_person),
  id_type INT FOREIGN KEY REFERENCES CollaboratorsTypes(id_type),
  post_time DATETIME NOT NULL DEFAULT GETDATE(),
  [enabled] BIT NOT NULL DEFAULT 1,
  deleted BIT NOT NULL DEFAULT 0
);

CREATE TABLE Clients(
  id_client INT IDENTITY(1, 1) PRIMARY KEY,
  id_person INT FOREIGN KEY REFERENCES Persons(id_person),
  post_time DATETIME NOT NULL DEFAULT GETDATE(),
  [enabled] BIT NOT NULL DEFAULT 1,
  deleted BIT NOT NULL DEFAULT 0
);
--
CREATE TABLE Producers_Addresses(
  id_pxa INT IDENTITY(1, 1) PRIMARY KEY,
  id_producer INT FOREIGN KEY REFERENCES Producers(id_producer),
  id_address INT FOREIGN KEY REFERENCES Addresses(id_address),
  [enabled] BIT NOT NULL DEFAULT 1,
  deleted BIT NOT NULL DEFAULT 0
);

CREATE TABLE Clients_Addresses(
  id_cxa INT IDENTITY(1, 1) PRIMARY KEY,
  id_client INT FOREIGN KEY REFERENCES Clients(id_client),
  id_address INT FOREIGN KEY REFERENCES Addresses(id_address),
  [enabled] BIT NOT NULL DEFAULT 1,
  deleted BIT NOT NULL DEFAULT 0
);
--
CREATE TABLE Contacts(
  id_contact INT IDENTITY(1, 1) PRIMARY KEY,
  id_contact_type INT FOREIGN KEY REFERENCES ContactTypes(id_type),
  contact NVARCHAR(255) NOT NULL,
  [enabled] BIT NOT NULL DEFAULT 1,
  deleted BIT NOT NULL DEFAULT 0
);

CREATE TABLE Producers_Contacs(
  id_pxc INT IDENTITY(1, 1) PRIMARY KEY,
  id_producer INT FOREIGN KEY REFERENCES Producers(id_producer),
  contact_procedure NVARCHAR(255),
  id_contact INT FOREIGN KEY REFERENCES Contacts(id_contact)
);

CREATE TABLE Clients_Contacts(
  id_cxc INT IDENTITY(1, 1) PRIMARY KEY,
  id_client INT FOREIGN KEY REFERENCES Clients(id_client),
  id_contact INT FOREIGN KEY REFERENCES Contacts(id_contact),
  [enabled] BIT NOT NULL DEFAULT 1,
  deleted BIT NOT NULL DEFAULT 0
);

CREATE TABLE Collaborators_Contacts(
  id_cxc INT IDENTITY(1, 1) PRIMARY KEY,
  id_collaborator INT FOREIGN KEY REFERENCES Collaborators(id_collaborator),
  id_contact INT FOREIGN KEY REFERENCES Contacts(id_contact),
  [enabled] BIT NOT NULL DEFAULT 1,
  deleted BIT NOT NULL DEFAULT 0
);
--
CREATE TABLE Products(
  id_product INT IDENTITY(1, 1) PRIMARY KEY,
  product_name NVARCHAR(255) NOT NULL,
  id_unit INT FOREIGN KEY REFERENCES Units(id_unit),
  estimated_weight FLOAT NOT NULL DEFAULT 1,
  min_quantity INT NOT NULL,
  max_quantity INT NOT NULL,
  photo_url VARCHAR(255) NOT NULL,
  sell_price MONEY NOT NULL,
  total_quantity INT NOT NULL,
  [enabled] BIT NOT NULL DEFAULT 1,
  deleted BIT NOT NULL DEFAULT 0,
  checksum VARBINARY(250) NOT NULL
);

CREATE TABLE Refills(
  id_refill INT IDENTITY(1, 1) PRIMARY KEY,
  contact INT FOREIGN KEY REFERENCES Producers_Contacs(id_pxc),
  collection_place INT FOREIGN KEY REFERENCES Producers_Addresses(id_pxa),
  id_product INT FOREIGN KEY REFERENCES Products(id_product),
  quantity_estimated INT NOT NULL,
  buy_price MONEY NOT NULL,
  id_status INT FOREIGN KEY REFERENCES RefillsStatus(id_status),
  weight INT NOT NULL,
  height INT NOT NULL,
  deep INT NOT NULL
);

CREATE TABLE StorageSpaces(
  id_storage_space INT IDENTITY(1, 1) PRIMARY KEY,
  storage_name NVARCHAR(255) NOT NULL,
  code NVARCHAR(255) NOT NULL,
  storage_location GEOGRAPHY NOT NULL,
  weight INT NOT NULL,
  height INT NOT NULL,
  deep INT NOT NULL,
  id_storage_type INT FOREIGN KEY REFERENCES StorageTypes(id_Storage_type),
  level_parent INT FOREIGN KEY REFERENCES StorageSpaces(id_storage_space),
  level_number INT NOT NULL,
  [enabled] BIT NOT NULL DEFAULT 1,
  deleted BIT NOT NULL DEFAULT 0
);
--
CREATE TABLE StorageLogs(
  id_storage_log INT IDENTITY(1, 1) PRIMARY KEY,
  id_storage_space INT FOREIGN KEY REFERENCES StorageSpaces(id_storage_space),
  id_storage_status INT FOREIGN KEY REFERENCES StorageStatus(id_status),
  post_date DATETIME NOT NULL DEFAULT GETDATE(),
  responsible INT FOREIGN KEY REFERENCES Collaborators(id_collaborator)
);

CREATE TABLE InventaryLogs(
  id_inventary_logs INT IDENTITY(1, 1) PRIMARY KEY,
  id_product INT FOREIGN KEY REFERENCES Products(id_product),
  post_time DATETIME DEFAULT GETDATE(),
  quantity INT NOT NULL,
  buy_price MONEY NOT NULL,
  id_status INT FOREIGN KEY REFERENCES ProductsStatus(id_status),
  id_producer INT FOREIGN KEY REFERENCES Producers(id_producer),
  id_storage_space INT FOREIGN KEY REFERENCES StorageSpaces(id_storage_space),
  [enabled] BIT NOT NULL DEFAULT 1,
  deleted BIT NOT NULL DEFAULT 0
);

CREATE TABLE Cards(
  id_card INT IDENTITY(1, 1) PRIMARY KEY,
  id_client INT FOREIGN KEY REFERENCES Clients(id_client),
  post_time DATETIME NOT NULL DEFAULT GETDATE(),
  card_number BIGINT NOT NULL UNIQUE,
  expiration_date DATETIME NOT NULL,
  cvv SMALLINT NOT NULL,
  [enabled] BIT NOT NULL DEFAULT 1,
  deleted BIT NOT NULL DEFAULT 0
);
--
CREATE TABLE Orders(
  id_order INT IDENTITY(1, 1) PRIMARY KEY,
  id_client INT FOREIGN KEY REFERENCES Clients(id_client),
  post_time DATETIME NOT NULL DEFAULT GETDATE(),
  discount INT NOT NULL DEFAULT 0,
  dispatch_place INT FOREIGN KEY REFERENCES StorageSpaces(id_storage_space),
  deadline DATETIME NOT NULL,
  id_status INT FOREIGN KEY REFERENCES OrderStatus(id_status),
  [weight] FLOAT NOT NULL,
  total MONEY NOT NULL,
  id_client_address INT FOREIGN KEY REFERENCES Clients_Addresses(id_cxa),
  payment_method INT FOREIGN KEY REFERENCES PaymenMethods(id_payment_method),
  checksum VARBINARY(250) NOT NULL
);

CREATE TABLE OrdersDetails(
  id_order_detail INT IDENTITY(1, 1) PRIMARY KEY,
  id_order INT FOREIGN KEY REFERENCES Orders(id_order),
  id_product INT FOREIGN KEY REFERENCES Products(id_product),
  quantity INT NOT NULL,
  sell_price MONEY NOT NULL,
  checksum VARBINARY(250) NOT NULL
);
--
CREATE TABLE Orders_Cards(
  id_oxc INT IDENTITY(1, 1) PRIMARY KEY,
  id_card INT FOREIGN KEY REFERENCES Cards(id_card),
  id_order INT FOREIGN KEY REFERENCES Orders(id_order),
  post_time DATETIME NOT NULL DEFAULT GETDATE()
);

CREATE TABLE Reviews(
  id_review INT IDENTITY(1, 1) PRIMARY KEY,
  id_order INT FOREIGN KEY REFERENCES Orders(id_order),
  post_time DATETIME NOT NULL DEFAULT GETDATE(),
  qualification TINYINT CHECK(qualification < 101 AND qualification > -1),
  comment NVARCHAR(500),
  id_comment_type INT FOREIGN KEY REFERENCES CommentTypes(id_type)
);
--
CREATE TABLE Trucks(
  id_truck INT IDENTITY(1, 1) PRIMARY KEY,
  id_type INT FOREIGN KEY REFERENCES TrucksTypes(id_type),
  license_plate NVARCHAR(20) NOT NULL UNIQUE,
  garage INT FOREIGN KEY REFERENCES StorageSpaces(id_storage_space),
  id_status INT FOREIGN KEY REFERENCES TrucksStatus(id_status),
  max_weight INT NOT NULL,
  weight INT NOT NULL,
  height INT NOT NULL,
  deep INT NOT NULL,
);

CREATE TABLE Routes(
  id_route INT IDENTITY(1, 1) PRIMARY KEY,
  init_time DATETIME NOT NULL,
  finish_time DATETIME,
  id_collaborator INT FOREIGN KEY REFERENCES Collaborators(id_collaborator),
  id_status INT FOREIGN KEY REFERENCES RoutesStatus(id_status),
  id_truck INT FOREIGN KEY REFERENCES Trucks(id_truck)
);

CREATE TABLE Orders_Routes(
  id_oxr INT IDENTITY(1, 1) PRIMARY KEY,
  id_order INT FOREIGN KEY REFERENCES Orders(id_order),
  id_route INT FOREIGN KEY REFERENCES Routes(id_route),
  delivery_time DATETIME,
  photo_url VARCHAR(255),
  delivery_geo GEOGRAPHY,
  delivery_status INT FOREIGN KEY REFERENCES DeliveryStatus (id_status),
);

CREATE TABLE Refills_Routes(
  id_rxr INT IDENTITY(1, 1) PRIMARY KEY,
  id_refill INT FOREIGN KEY REFERENCES Refills(id_refill),
  id_route INT FOREIGN KEY REFERENCES Routes(id_route),
  recieved_time DATETIME,
  recieved_geo GEOGRAPHY,
  refill_status INT FOREIGN KEY REFERENCES RefillsStatus(id_status),
);

CREATE TABLE OrdersPreparations(
  id_order_preparation INT IDENTITY(1, 1) PRIMARY KEY,
  id_order INT FOREIGN KEY REFERENCES Orders(id_order),
  init_time DATETIME NOT NULL DEFAULT GETDATE(),
  finish_time DATETIME,
  preparation_status INT FOREIGN KEY REFERENCES OrderStatus(id_status),
);

CREATE TABLE OrdersPreparations_Collaborators(
  id_opxc INT IDENTITY(1, 1) PRIMARY KEY,
  id_order_preparation INT FOREIGN KEY REFERENCES OrdersPreparations(id_order_preparation),
  id_collaborator INT FOREIGN KEY REFERENCES Collaborators(id_collaborator),
  preparation_type INT FOREIGN KEY REFERENCES PreparationsTypes(id_type)
);

CREATE TABLE ProductsPreparations(
  id_product_preparation INT IDENTITY(1, 1) PRIMARY KEY,
  id_inventary INT FOREIGN KEY REFERENCES InventaryLogs(id_inventary_logs),
  quantity INT NOT NULL,
  init_time DATETIME NOT NULL DEFAULT GETDATE(),
  finish_time DATETIME,
  preparation_status INT FOREIGN KEY REFERENCES PreparationsStatus(id_status)
);

CREATE TABLE ProductsPreparations_Collaborators(
  id_ppxc INT IDENTITY(1, 1) PRIMARY KEY,
  id_product_preparation INT FOREIGN KEY REFERENCES ProductsPreparations(id_product_preparation),
  id_collaborator INT FOREIGN KEY REFERENCES Collaborators(id_collaborator),
  preparation_type INT FOREIGN KEY REFERENCES PreparationsTypes(id_type)
);

GO
/*
Dummy data
*/
INSERT INTO StorageTypes (type_name)
VALUES ('Cold storage'), ('Dry storage'), ('Frozen storage');

INSERT INTO CollaboratorsTypes (type_name)
VALUES ('Manager'), ('Supervisor'), ('Operator'), ('Driver'), ('Security guard');

INSERT INTO TrucksTypes (type_name)
VALUES ('Refrigerated truck'), ('Flatbed truck'), ('Dump truck'), ('Tanker truck');

INSERT INTO PreparationsTypes (type_name)
VALUES ('Baking'), ('Grilling'), ('Frying'), ('Sautéing');

INSERT INTO ContactTypes (type_name)
VALUES ('Email'), ('Phone'), ('Fax'), ('Social media');

INSERT INTO CommentTypes (type_name)
VALUES ('Complaint'), ('Suggestion'), ('Praise'), ('Question');

INSERT INTO DeliveryStatus (status_name)
VALUES ('In Transit'), ('Delivered'), ('Delayed'), ('Cancelled');

INSERT INTO OrderStatus (status_name)
VALUES ('Pending'), ('Confirmed'), ('In Process'), ('Shipped'), ('Delivered'), ('Cancelled');

INSERT INTO PreparationsStatus (status_name)
VALUES ('Not Started'), ('In Progress'), ('Complete'), ('Cancelled');

INSERT INTO RefillsStatus (status_name)
VALUES ('Low'), ('Medium'), ('High'), ('Full');

INSERT INTO ProductsStatus (status_name)
VALUES ('In Stock'), ('Out of Stock'), ('Discontinued');

INSERT INTO TrucksStatus (status_name)
VALUES ('Available'), ('In Use'), ('In Maintenance'), ('Out of Service');

INSERT INTO StorageStatus (status_name)
VALUES ('Available'), ('In Use'), ('Under Maintenance'), ('Out of Service');

INSERT INTO RoutesStatus (status_name)
VALUES ('Planned'), ('In Progress'), ('Complete'), ('Cancelled');

-- Datos de prueba para PaymenMethods
INSERT INTO PaymenMethods(payment_name, enabled, deleted)
VALUES 
    ('Credit Card', 1, 0),
    ('Paypal', 1, 0),
    ('Cash', 1, 0),
    ('Bank transfer', 1, 0);

-- Datos de prueba para Units
INSERT INTO Units(unit_name, enabled, deleted)
VALUES 
    ('Kilogram', 1, 0),
    ('Liter', 1, 0),
    ('Pound', 1, 0),
    ('Gallon', 1, 0);

-- Datos de prueba para Countries
--Insertar datos de prueba en la tabla Countries
INSERT INTO Countries (country_name) VALUES ('Costa Rica');

--Insertar datos de prueba en la tabla States
INSERT INTO States (state_name, id_country)
VALUES
('San Jose', 1),
('Alajuela', 1),
('Cartago', 1),
('Heredia', 1),
('Guanacaste', 1),
('Puntarenas', 1),
('Limon', 1);

--Insertar datos de prueba en la tabla Districts
INSERT INTO Districts (district_name, id_state)
VALUES
('San José', 1),
('Escazú', 1),
('Alajuela', 2),
('Atenas', 2),
('Oreamuno', 3),
('El Guarco', 3),
('Heredia', 4),
('Barva', 4),
('Liberia', 5),
('Santa Cruz', 5),
('Garabito', 6),
('Osa', 6),
('Limón', 7),
('Matina', 7);

--Insertar datos de prueba en la tabla Addresses
INSERT INTO Addresses (id_district, address_1, address_2, delivery_geo)
VALUES
(1, 'Avenida 2, Calle 1', 'Edificio Torres del Parque, Piso 3', geography::Point(9.934025, -84.086579, 4326)),
(2, 'Avenida Escazú', 'Centro Comercial, Local 17', geography::Point(9.926310, -84.144162, 4326)),
(3, 'Alajuela', 'Pista Panamericana', geography::Point(10.023242, -84.220931, 4326)),
(4, 'Atenas', 'Carretera vieja', geography::Point(9.987163, -84.374238, 4326)),
(5, 'Cartago', 'Frente a la Municipalidad', geography::Point(9.858528, -83.913240, 4326)),
(6, 'Calle 3', 'Atrás del supermercado', geography::Point(9.855515, -83.910068, 4326)),
(7, 'Heredia', 'Costado Este del Mall Paseo de las Flores', geography::Point(10.010604, -84.111812, 4326)),
(8, 'Barva', '200 m sur de la iglesia', geography::Point(10.017077, -84.116026, 4326)),
(9, 'Liberia', 'Entrada principal de la Universidad de Costa Rica', geography::Point(10.635511, -85.437581, 4326)),
(10, 'Santa Cruz', '200 m norte del Banco Nacional', geography::Point(10.263618, -85.592522, 4326)),
(11, 'Jaco', 'Costado Oeste del Supermercado Maxi Palí', geography::Point(9.617266, -84.628064, 4326))

-- Persons
INSERT INTO Persons (person_name, last_name, username, person_password)
VALUES 
  ('John', 'Doe', 'johndoe', 'pass123'),
  ('Jane', 'Doe', 'janedoe', 'pass123'),
  ('Alice', 'Smith', 'alicesmith', 'pass123'),
  ('Bob', 'Smith', 'bobsmith', 'pass123'),
  ('Peter', 'Garcia', 'petergarcia', 'pass123'),
  ('Mary', 'Garcia', 'marygarcia', 'pass123'),
  ('David', 'Lee', 'davidlee', 'pass123'),
  ('Eva', 'Lee', 'evalee', 'pass123'),
  ('Michael', 'Kim', 'michaelkim', 'pass123'),
  ('Jasmine', 'Kim', 'jasminekim', 'pass123'),
  ('Mark', 'Williams', 'markwilliams', 'pass123'),
  ('Olivia', 'Williams', 'oliviawilliams', 'pass123'),
  ('Daniel', 'Brown', 'danielbrown', 'pass123'),
  ('Sophia', 'Brown', 'sophiabrown', 'pass123'),
  ('Eric', 'Rodriguez', 'ericrodriguez', 'pass123'),
  ('Linda', 'Rodriguez', 'lindarodriguez', 'pass123'),
  ('Chris', 'Davis', 'chrisdavis', 'pass123'),
  ('Karen', 'Davis', 'karendavis', 'pass123'),
  ('Tom', 'Wilson', 'tomwilson', 'pass123'),
  ('Grace', 'Wilson', 'gracewilson', 'pass123');

-- Producers
INSERT INTO Producers (producer_name)
VALUES 
  ('Zopotillo'),
  ('TEC'),
  ('PepsiCo'),
  ('Perez'),
  ('Mars');

-- Collaborators
INSERT INTO Collaborators (id_boss, id_person, id_type)
VALUES 
  (NULL, 1, 1),
  (NULL, 2, 2),
  (1, 3, 2),
  (1, 4, 2),
  (2, 5, 2),
  (2, 6, 2),
  (4, 7, 2),
  (4, 8, 2),
  (5, 9, 2),
  (5, 10, 2);

-- Clients
INSERT INTO Clients (id_person)
VALUES 
  (11),
  (12),
  (13),
  (14),
  (15),
  (16),
  (17),
  (18),
  (19),
  (20);

INSERT INTO Producers_Addresses(id_producer, id_address)
VALUES
  (1, 1),
  (2, 3),
  (3, 2),
  (4, 4),
  (5, 5),
  (5, 6);

INSERT INTO Clients_Addresses(id_client, id_address)
VALUES
  (1, 2),
  (2, 3),
  (3, 4),
  (4, 5),
  (5, 6),
  (6, 1),
  (7, 2),
  (8, 3),
  (9, 4),
  (10, 5);

-- Datos para Contacts
INSERT INTO Contacts (id_contact_type, contact) VALUES
  (1, 'producer1@example.com'),
  (2, 'producer2@example.com'),
  (3, 'producer3@example.com'),
  (4, 'producer4@example.com'),
  (1, 'client1@example.com'),
  (2, 'client2@example.com'),
  (3, 'client3@example.com'),
  (4, 'client4@example.com'),
  (5, 'collaborator1@example.com'),
  (6, 'collaborator2@example.com'),
  (7, 'collaborator3@example.com'),
  (8, 'collaborator4@example.com');

-- Datos para Producers_Contacts
INSERT INTO Producers_Contacs (id_producer, contact_procedure, id_contact) VALUES
  (1, 'Email', 1),
  (2, 'Email', 2),
  (2, 'Phone', 3),
  (3, 'Email', 4),
  (3, 'Phone', 3),
  (4, 'Email', 4),
  (4, 'Phone', 2);

-- Datos para Clients_Contacts
INSERT INTO Clients_Contacts (id_client, id_contact) VALUES
  (1, 5),
  (2, 6),
  (2, 7),
  (3, 8),
  (4, 8);

-- Datos para Collaborators_Contacts
INSERT INTO Collaborators_Contacts (id_collaborator, id_contact) VALUES
  (1, 5),
  (2, 6),
  (2, 7),
  (3, 8),
  (4, 8);

INSERT INTO Products (product_name, id_unit, estimated_weight, min_quantity, max_quantity, photo_url, sell_price, total_quantity, [enabled], deleted, checksum)
VALUES
('Manzana', 1, 0.3, 5, 20, 'https://picsum.photos/200/300', 5.5, 100, 1, 0, 0x0),
('Plátano', 1, 0.25, 5, 20, 'https://picsum.photos/200/300', 4.5, 80, 1, 0, 0x0),
('Fresa', 2, 0.1, 2, 10, 'https://picsum.photos/200/300', 10, 50, 1, 0, 0x0),
('Zanahoria', 3, 0.2, 3, 15, 'https://picsum.photos/200/300', 3.5, 120, 1, 0, 0x0),
('Papa', 3, 0.3, 5, 25, 'https://picsum.photos/200/300', 2.5, 150, 1, 0, 0x0),
('Cebolla', 3, 0.15, 3, 12, 'https://picsum.photos/200/300', 4, 90, 1, 0, 0x0),
('Tomate', 1, 0.2, 4, 18, 'https://picsum.photos/200/300', 3, 110, 1, 0, 0x0),
('Pepino', 1, 0.2, 4, 18, 'https://picsum.photos/200/300', 3.5, 80, 1, 0, 0x0),
('Lechuga', 2, 0.1, 2, 10, 'https://picsum.photos/200/300', 7.5, 70, 1, 0, 0x0),
('Espinaca', 2, 0.1, 2, 10, 'https://picsum.photos/200/300', 6.5, 60, 1, 0, 0x0),
('Brocoli', 3, 0.2, 3, 15, 'https://picsum.photos/200/300', 5.5, 80, 1, 0, 0x0),
('Pimiento', 1, 0.15, 3, 12, 'https://picsum.photos/200/300', 4.5, 90, 1, 0, 0x0),
('Calabaza', 3, 0.3, 5, 25, 'https://picsum.photos/200/300', 2, 130, 1, 0, 0x0),
('Esparrago', 2, 0.1, 2, 10, 'https://picsum.photos/200/300', 11, 30, 1, 0, 0x0),
('Champiñones', 4, 0.1, 2, 10, 'https://picsum.photos/200/300', 8.5, 40, 1, 0, 0x0);

INSERT INTO Refills (contact, collection_place, id_product, quantity_estimated, buy_price, id_status, weight, height, deep)
VALUES 
  (1, 1, 2, 500, 5.5, 1, 10, 20, 30),
  (2, 2, 5, 200, 3.5, 1, 12, 24, 36),
  (3, 3, 7, 100, 2.75, 2, 8, 16, 24),
  (4, 4, 4, 300, 4.0, 1, 15, 30, 45),
  (5, 5, 9, 150, 3.0, 2, 6, 12, 18),
  (1, 2, 10, 400, 4.5, 1, 18, 36, 54),
  (2, 3, 11, 50, 1.5, 2, 5, 10, 15),
  (3, 4, 12, 800, 9.0, 1, 20, 40, 60),
  (4, 5, 3, 200, 2.5, 2, 10, 20, 30),
  (5, 1, 6, 1000, 12.5, 1, 25, 50, 75);

INSERT INTO StorageSpaces (storage_name, code, storage_location, weight, height, deep, id_storage_type, level_parent, level_number) VALUES 
  ('The', 'FRG001', 'POINT(-99.183635 19.404869)', 1000, 2000, 1500, 1, NULL, 1),
  ('Fridge', 'FRG002', 'POINT(-99.183635 19.404869)', 1000, 2000, 1500, 1, 1, 2),
  ('Freezer', 'FZR001', 'POINT(-99.183635 19.404869)', 1500, 1500, 1000, 1, 1, 1),
  ('Freezer', 'FZR002', 'POINT(-99.183635 19.404869)', 1500, 1500, 1000, 1, 2, 2),
  ('Pantry', 'PNY001', 'POINT(-99.183635 19.404869)', 3000, 2000, 2000, 2, 2, 1),
  ('Pantry', 'PNY002', 'POINT(-99.183635 19.404869)', 3000, 2000, 2000, 2, 2, 2),
  ('Shelf', 'SHF001', 'POINT(-99.183635 19.404869)', 200, 200, 200, 3, 3, 1),
  ('Shelf', 'SHF002', 'POINT(-99.183635 19.404869)', 200, 200, 200, 3, 3, 2),
  ('Shelf', 'SHF003', 'POINT(-99.183635 19.404869)', 200, 200, 200, 3, 3, 3),
  ('Shelf', 'SHF004', 'POINT(-99.183635 19.404869)', 200, 200, 200, 3, 3, 4);

INSERT INTO StorageLogs (id_storage_space, id_storage_status, post_date, responsible)
VALUES
  (1, 1, '2023-02-01 08:00:00', 1),
  (1, 2, '2023-02-03 12:30:00', 2),
  (2, 3, '2023-02-05 16:15:00', 3),
  (3, 1, '2023-02-07 09:45:00', 4),
  (4, 2, '2023-02-09 14:00:00', 5);

INSERT INTO InventaryLogs(id_product, post_time, quantity, buy_price, id_status, id_producer, id_storage_space)
VALUES 
  (1, '2023-02-01 10:00:00', 100, 2.50, 1, 1, 1),
  (2, '2023-02-02 11:00:00', 200, 1.75, 1, 2, 2),
  (3, '2023-02-03 12:00:00', 150, 3.00, 1, 3, 3),
  (4, '2023-02-04 13:00:00', 250, 4.00, 1, 4, 4),
  (5, '2023-02-05 14:00:00', 50, 1.50, 1, 5, 5),
  (6, '2023-02-06 15:00:00', 75, 2.25, 1, 1, 6),
  (7, '2023-02-07 16:00:00', 100, 1.90, 1, 2, 7),
  (8, '2023-02-08 17:00:00', 150, 2.75, 1, 3, 8),
  (9, '2023-02-09 18:00:00', 200, 3.50, 1, 4, 9),
  (10, '2023-02-10 19:00:00', 75, 1.25, 1, 5, 10),
  (11, '2023-02-11 20:00:00', 125, 2.00, 1, 1, 11),
  (12, '2023-02-12 21:00:00', 300, 2.50, 1, 2, 12),
  (13, '2023-02-13 22:00:00', 50, 3.75, 1, 3, 13),
  (14, '2023-02-14 23:00:00', 175, 4.25, 1, 4, 14),
  (15, '2023-02-15 10:00:00', 225, 2.00, 1, 5, 15),
  (1, '2023-02-16 11:00:00', 100, 1.50, 1, 1, 16),
  (2, '2023-02-17 12:00:00', 125, 2.25, 1, 2, 17),
  (5, '2023-02-18 13:00:00', 150, 3.00, 1, 3, 18),
  (6, '2023-02-19 14:00:00', 250, 4.50, 1, 4, 19),
  (2, '2023-02-20 15:00:00', 75, 1.75, 1, 5, 20);

INSERT INTO Cards (id_client, post_time, card_number, expiration_date, cvv)
VALUES 
(1, '2023-02-19 14:32:11', 5246787521640545, '2025-01-01', 123),
(2, '2023-02-20 08:45:20', 4532467541631468, '2024-02-01', 456),
(3, '2023-02-20 15:23:00', 5378931758420591, '2026-03-01', 789),
(4, '2023-02-21 11:10:35', 4790802235971494, '2023-11-01', 234),
(5, '2023-02-21 16:15:22', 4223633434238384, '2024-05-01', 567),
(6, '2023-02-22 10:35:19', 5352128415540327, '2023-12-01', 890),
(7, '2023-02-22 12:54:55', 4241544447292885, '2025-08-01', 123),
(8, '2023-02-23 14:20:47', 5234147965517719, '2026-06-01', 456),
(9, '2023-02-23 16:42:38', 4122129254297866, '2024-10-01', 789),
(10, '2023-02-24 09:55:41', 5192745133198282, '2025-02-01', 234),
(1, '2023-02-24 13:00:15', 5285436357978265, '2023-10-01', 567),
(2, '2023-02-24 15:37:45', 4979219620851714, '2024-06-01', 890),
(3, '2023-02-25 10:05:33', 5115062139486928, '2025-04-01', 123),
(4, '2023-02-25 12:14:19', 5456024327516595, '2023-07-01', 456),
(5, '2023-02-25 14:59:32', 4134156118833619, '2024-03-01', 789);

-- Orders
INSERT INTO Orders(id_client, post_time, discount, dispatch_place, deadline, id_status, [weight], total, id_client_address, payment_method, checksum)
VALUES 
(1, '2023-02-18 09:00:00', 0, 1, '2023-02-28 23:59:59', 1, 25, 300, 1, 1, 0x0),
(2, '2023-02-18 11:00:00', 10, 2, '2023-03-01 12:00:00', 1, 15, 200, 2, 2, 0x0),
(3, '2023-02-18 12:00:00', 5, 1, '2023-02-28 23:59:59', 2, 20, 250, 3, 3, 0x0),
(4, '2023-02-18 15:00:00', 20, 2, '2023-02-28 23:59:59', 1, 30, 350, 4, 1, 0x0),
(5, '2023-02-19 10:00:00', 5, 1, '2023-02-28 23:59:59', 3, 10, 150, 5, 2, 0x0),
(6, '2023-02-19 13:00:00', 0, 2, '2023-03-01 12:00:00', 1, 45, 500, 6, 3, 0x0),
(7, '2023-02-20 08:00:00', 15, 1, '2023-03-01 12:00:00', 2, 20, 300, 7, 1, 0x0),
(8, '2023-02-20 09:00:00', 5, 2, '2023-03-01 12:00:00', 1, 35, 400, 8, 2, 0x0),
(9, '2023-02-21 14:00:00', 0, 1, '2023-03-01 12:00:00', 1, 25, 300, 9, 3, 0x0),
(10, '2023-02-21 15:00:00', 10, 2, '2023-03-01 12:00:00', 3, 15, 200, 10, 1, 0x0)

INSERT INTO OrdersDetails (id_order, id_product, quantity, sell_price, checksum)
VALUES 
(1, 1, 2, 10.99, 0x0),
(1, 5, 1, 5.99, 0x0),
(1, 8, 3, 2.99, 0x0),
(2, 3, 2, 7.99, 0x0),
(2, 6, 1, 3.99, 0x0),
(2, 9, 2, 6.99, 0x0),
(2, 13, 1, 4.99, 0x0),
(3, 2, 4, 8.99, 0x0),
(3, 7, 2, 4.99, 0x0),
(3, 11, 3, 3.99, 0x0),
(4, 4, 1, 12.99, 0x0),
(4, 10, 1, 7.99, 0x0),
(4, 14, 2, 6.99, 0x0),
(4, 15, 1, 4.99, 0x0),
(5, 1, 2, 10.99, 0x0),
(5, 5, 1, 5.99, 0x0),
(5, 8, 3, 2.99, 0x0),
(6, 3, 2, 7.99, 0x0),
(6, 6, 1, 3.99, 0x0),
(6, 9, 2, 6.99, 0x0),
(6, 13, 1, 4.99, 0x0),
(7, 2, 4, 8.99, 0x0),
(7, 7, 2, 4.99, 0x0),
(7, 11, 3, 3.99, 0x0),
(8, 4, 1, 12.99, 0x0),
(8, 10, 1, 7.99, 0x0),
(8, 14, 2, 6.99, 0x0),
(8, 15, 1, 4.99, 0x0),
(9, 1, 2, 10.99, 0x0),
(9, 5, 1, 5.99, 0x0),
(9, 8, 3, 2.99, 0x0),
(10, 3, 2, 7.99, 0x0),
(10, 6, 1, 3.99, 0x0),
(10, 9, 2, 6.99, 0x0),
(10, 13, 1, 4.99, 0x0);

-- Orders_Cards data
INSERT INTO Orders_Cards (id_card, id_order, post_time) VALUES 
  (1, 1, '2023-02-20 10:30:00'),
  (2, 2, '2023-02-21 12:45:00'),
  (3, 3, '2023-02-23 16:20:00'),
  (4, 4, '2023-02-24 18:15:00'),
  (5, 5, '2023-02-25 20:00:00');

-- Reviews data
INSERT INTO Reviews (id_order, post_time, qualification, comment, id_comment_type) VALUES 
  (1, '2023-02-20 11:00:00', 80, 'Muy buen servicio, todo llegó en excelentes condiciones', 1),
  (2, '2023-02-20 11:00:00', 90, 'Excelente atención al cliente, muy satisfecho con la compra', 2),
  (3, '2023-02-21 13:00:00', 60, 'La entrega se retrasó un poco, pero en general bien', 3),
  (4, '2023-02-23 16:30:00', 75, 'Los productos son buenos, pero podrían mejorar el empaque', 1),
  (5, '2023-02-24 18:30:00', 30, 'No recibí todos los productos que pedí, muy decepcionado', 2),
  (6, '2023-02-25 20:30:00', 40, 'El pedido llegó incompleto y dañado, no volvería a comprar aquí', 3),
  (7, '2023-02-25 20:30:00', 20, 'El servicio al cliente es pésimo, no recomendaría esta tienda', 1),
  (8, '2023-02-25 20:30:00', 10, 'Pesadilla total, no puedo creer que existan negocios tan malos', 2),
  (9, '2023-02-26 14:00:00', 95, 'Los productos son de alta calidad y llegaron en perfectas condiciones', 3),
  (10, '2023-02-26 14:00:00', 100, 'La atención al cliente es impecable, sin duda volvería a comprar aquí', 1);

INSERT INTO Trucks (id_type, license_plate, garage, id_status, max_weight, weight, height, deep)
VALUES 
  (1, 'ABC123', 1, 1, 2000, 1000, 2, 2),
  (2, 'XYZ987', 1, 1, 3000, 2000, 3, 3),
  (3, 'DEF456', 1, 1, 2500, 1500, 2, 3),
  (1, 'GHI789', 1, 2, 1800, 900, 2, 2),
  (2, 'JKL012', 1, 2, 2800, 1800, 3, 3),
  (3, 'MNO345', 1, 2, 2200, 1400, 2, 3),
  (1, 'PQR678', 1, 3, 1900, 950, 2, 2),
  (2, 'STU901', 1, 3, 2900, 1900, 3, 3),
  (3, 'VWX234', 1, 3, 2300, 1300, 2, 3),
  (1, 'YZA567', 1, 1, 2100, 1100, 2, 2)

INSERT INTO Routes (init_time, finish_time, id_collaborator, id_status, id_truck)
VALUES 
('2023-02-28 09:00:00', '2023-02-28 20:00:00', 1, 1, 1),
('2023-03-01 07:00:00', '2023-03-01 20:00:00', 2, 1, 2);

INSERT INTO Orders_Routes (id_order, id_route, delivery_time, photo_url, delivery_geo, delivery_status)
VALUES 
(1, 1, '2023-02-28T11:30:00', 'https://example.com/photo1', CAST('POINT(-72.123456 45.678901)' AS GEOGRAPHY), 1),
(2, 1, '2023-02-28T14:45:00', 'https://example.com/photo2', CAST('POINT(-72.234567 45.789012)' AS GEOGRAPHY), 2),
(3, 2, '2023-02-28T16:15:00', 'https://example.com/photo3', CAST('POINT(-72.345678 45.890123)' AS GEOGRAPHY), 1),
(4, 2, '2023-02-28T17:30:00', 'https://example.com/photo4', CAST('POINT(-72.456789 45.901234)' AS GEOGRAPHY), 3),
(5, 2, '2023-02-28T18:45:00', 'https://example.com/photo5', CAST('POINT(-72.567890 45.012345)' AS GEOGRAPHY), 2);

-- OrdersPreparations
INSERT INTO OrdersPreparations (id_order, finish_time, preparation_status) VALUES (2, '2023-02-12 13:00:00', 1), 
(4, '2023-02-10 14:30:00', 1), (6, '2023-02-09 11:00:00', 2), (8, '2023-02-08 15:45:00', 2);

-- OrdersPreparations_Collaborators
INSERT INTO OrdersPreparations_Collaborators (id_order_preparation, id_collaborator, preparation_type) VALUES (1, 3, 1), 
(1, 4, 2), (2, 2, 1), (2, 5, 2), (3, 1, 1), (3, 4, 2), (4, 3, 1), (4, 2, 2);

-- ProductsPreparations
INSERT INTO ProductsPreparations (id_inventary, quantity, finish_time, preparation_status) VALUES (1, 100, '2023-02-11 12:00:00', 1), 
(2, 50, '2023-02-10 14:00:00', 2), (3, 75, '2023-02-09 11:30:00', 2), (4, 150, '2023-02-08 16:00:00', 1);

-- ProductsPreparations_Collaborators
INSERT INTO ProductsPreparations_Collaborators (id_product_preparation, id_collaborator, preparation_type) VALUES (1, 2, 1), (1, 4, 2), (2, 5, 1);

GO
/*
            Entrega preliminar #2
*/
-----------------------------------------------------------
-- Punto 1: determinar si existe al menos una diferencia de carga de trabajo del 20% entre los dos días de entrega
-- Autor: EGuzmán
-- Fecha: 02/22/2023
-----------------------------------------------------------
SELECT CAST(deadline AS date) AS Día_entrega, COUNT(id_order) AS TotalPedidos, SUM([weight]) AS PesoTotal
FROM Orders
GROUP BY CAST(deadline AS date)
ORDER BY deadline

GO
-----------------------------------------------------------
-- Punto 2: cuáles son las principales razones por las que el consumidor devuelve producto
-- Autor: EGuzmán
-- Fecha: 02/22/2023
-----------------------------------------------------------
SELECT comment
FROM Reviews
INNER JOIN CommentTypes
ON CommentTypes.id_type = Reviews.id_comment_type
WHERE type_name = 'Devolución'
GO

-----------------------------------------------------------
-- Punto 3: demostrar que las operaciones de ordenar productos y agregar productos a bodega pueden ser transaccionales
-----------------------------------------------------------


CREATE TYPE dbo.TVP_OrderProducts AS TABLE(
  product_name NVARCHAR(255),
  quantity INT
)
GO

-----------------------------------------------------------
-- Autor: EGuzmán
-- Fecha: 02/22/2023
-- Descripcion: procedimiento para registrar un pedido de un consumidor
-----------------------------------------------------------
CREATE PROCEDURE [dbo].[FeriaSP_PlaceOrder]
	@id_client INT,
  @dispatch_place INT,
  @deadline DATETIME,
  -- asumí que el cliente puede tener varias dirreciones, pensando en clientes grandes
  @client_addresses INT,
  @payment_method INT,
  @discount INT = 0,
	@products TVP_OrderProducts READONLY
AS 
BEGIN
	
	SET NOCOUNT ON -- no retorne metadatos
	
	DECLARE @ErrorNumber INT, @ErrorSeverity INT, @ErrorState INT, @CustomError INT
	DECLARE @Message VARCHAR(200)
	DECLARE @InicieTransaccion BIT

	DECLARE @productCount INT
	DECLARE @id_status INT 
	DECLARE @id_order INT
  DECLARE @checksum VARBINARY(250)
	DECLARE @total MONEY
  DECLARE @weight FLOAT


	SELECT @id_status = id_status FROM dbo.OrderStatus WHERE status_name = 'Por entregar'
	SELECT @productCount = COUNT(*) FROM @products
  SELECT @weight = SUM(Products.estimated_weight * @products.quantity)
  FROM Products
  INNER JOIN products ON Products.product_name = products.product_name

	IF (@productCount>0) BEGIN

		SET @InicieTransaccion = 0
		IF @@TRANCOUNT=0 BEGIN
			SET @InicieTransaccion = 1
			SET TRANSACTION ISOLATION LEVEL READ COMMITTED
			BEGIN TRANSACTION		
		END
	
		BEGIN TRY
			SET @CustomError = 2001

			INSERT INTO dbo.Orders (id_client, discount, dispatch_place, deadline, id_status, [weight], total, id_client_address, payment_method, checksum)
			VALUES
			(@clientId, @discount, @dispatch_place, @deadline, @id_status, @weight, 0.0 ,@client_addresses, @payment_method, 0x0)

			SELECT @id_order= SCOPE_IDENTITY()

			INSERT INTO dbo.OrdersDetails (id_order, id_product, quantity, sell_price, checksum)
			SELECT  @orderId, idProducto, @products.quantity, sell_price, HASHBYTES('SHA2_512', CONCAT(@products.quantity,'pura vida maes', @id_order, @id_client, sell_price))  
      FROM dbo.Products 
			INNER JOIN @products ON @products.product_name = Products.product_name

			SELECT @total = SUM(sell_price * quantity) FROM dbo.OrdersDetails WHERE id_order = @orderId
      SET @checksum = HASHBYTES('SHA2_512', CONCAT(@total,'pura vida maes', @id_client, @client_addresses))
			UPDATE dbo.Orders 
      SET total = @Total, checksum = @checksum
      WHERE id_order = @orderId
			
			IF @InicieTransaccion=1 BEGIN
				COMMIT
			END
		END TRY
		BEGIN CATCH
			SET @ErrorNumber = ERROR_NUMBER()
			SET @ErrorSeverity = ERROR_SEVERITY()
			SET @ErrorState = ERROR_STATE()
			SET @Message = ERROR_MESSAGE()
		
			IF @InicieTransaccion=1 BEGIN
				ROLLBACK
			END
			RAISERROR('%s - Error Number: %i', 
				@ErrorSeverity, @ErrorState, @Message, @CustomError)
		END CATCH	
	END
END
RETURN 0
GO

--Caso ok
DECLARE @myProducts TVP_OrderProducts
INSERT @myProducts VALUES 
('Aguacate', 5),
('Mango', 10),
('Pipa', 2)

exec dbo.[FeriaSP_PlaceOrder] 3, 1,'2023-02-25 20:30:00', 1, 1, 0, @myProducts
select * from Orders where id_client = 3
select * from OrdersDetails

-- Error porque no puede insertar el null
DECLARE @myProducts TVP_OrderProducts
INSERT @myProducts VALUES 
('AguacateX', 5),
('MangoX', 10),
('PipaX', 2)

exec dbo.[FeriaSP_PlaceOrder] 3, 1,'2023-02-25 20:30:00', 1, 1, 0, @myProducts
select * from Orders where id_client = 3

GO
-----------------------------------------------------------
-- Punto 4: demostrar si va a ser posible crear vistas que ayuden a la implementación del sistema
-- Autor: EGuzmán
-- Fecha: 02/22/2023
-----------------------------------------------------------

-- Aqui voy a crear una vista de producto x proveedor para evitar los joins cada vez que se busque un provedor por un producto especifico
CREATE VIEW View_Productors_Products AS
SELECT DISTINCT
  id_product, product_name, id_producer, producer_name, buy_price
FROM Products
Inner JOIN InventaryLogs
ON InventaryLogs.id_product = Products.id_product
INNER JOIN Producers
ON Producers.id_producer = InventaryLogs.id_producer
GO
--Aqui voy a crear una vista para tener los clientes (que si han comprado) y donde compran, ignorando direcciones que no tengan compras
CREATE VIEW View_RealClients_States AS
SELECT DISTINCT
  id_client, person_name, last_name, post_time, delivery_geo, district_name, state_name
FROM Orders
INNER JOIN Clients
ON Orders.id_client = Clients.id_client
INNER JOIN Persons
ON Persons.id_person = Client.id_person
INNER JOIN Clients_Addresses
ON Clients_Addresses.id_cxa = Orders.id_cxa
INNER JOIN Addresses
ON Addresses.id_address = client_addresses.id_address
INNER JOIN Districts
ON Districts.id_district = Addresses.id_district
INNER JOIN States
ON States.id_state = Districts.id_state
