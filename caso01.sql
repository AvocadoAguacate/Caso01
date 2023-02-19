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



/*Conultas de la primera entrega*/

-- /*cuál es el top 5 de compradores estrella*/
-- SELECT TOP 5 
--   Orders.id_client AS cliente_estrella, SUM(Orders.total) AS total_compras
--   FROM Orders
--   GROUP BY Orders.id_client
--   ORDER BY total_compras DESC

-- /*cuál es el top 5 de productos más vendidos en los últimos 15 días*/ 
-- SELECT TOP 5 
--   InventaryLogs.id_product as Producto_más_vendido, SUM(OrdersDetails.quantity * OrdersDetails.sell_price) AS total_vendido
--   FROM Orders
--   INNER JOIN OrdersDetails
--   ON OrdersDetails.id_order = Orders.id_order
--   INNER JOIN InventaryLogs
--   ON InventaryLogs.id_inventary_logs = OrdersDetails.id_inventary
--   WHERE DATEDIFF(DAY, Orders.post_time, GETDATE()) < 16
--   GROUP BY InventaryLogs.id_product
--   ORDER BY total_vendido DESC
-- /*cuál es el total de compras por persona*/
-- SELECT 
--   Orders.id_client AS cliente, SUM(Orders.total) AS total_compras
--   FROM Orders
--   GROUP BY Orders.id_client

-- /*cuál es el total vendido por producto*/
-- SELECT 
-- 	InventaryLogs.id_product as Producto, SUM(OrdersDetails.quantity * OrdersDetails.sell_price) AS total_vendido
--   FROM OrdersDetails
--   INNER JOIN InventaryLogs
--   ON InventaryLogs.id_inventary_logs = OrdersDetails.id_inventary
--   GROUP BY InventaryLogs.id_product

-- /*insert con checksum*/
-- insert into persona (nombre, checksum) values ('adolfo', HASHBYTES('SHA2_512', CONCAT('adolfo','pura vida maes', @numero)))