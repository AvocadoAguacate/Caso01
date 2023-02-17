/*
Caso 01 - Preliminar #1
Esteban Guzmán Ramírez - 2015095861
*/

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

CREATE TABLE ProductStatus(
  id_status INT IDENTITY(1,1) PRIMARY KEY,
  status_name NVARCHAR(255) NOT NULL
);

CREATE TABLE PaymenMethods(
  id_payment_method INT IDENTITY(1,1) PRIMARY KEY,
  payment_name NVARCHAR(255) NOT NULL
);

CREATE TABLE Units(
  id_unit INT IDENTITY(1,1) PRIMARY KEY,
  unit_name NVARCHAR(255) NOT NULL
);

CREATE TABLE Countries(
  id_country INT IDENTITY(1, 1) PRIMARY KEY,
  country_name NVARCHAR(255) NOT NULL
);

CREATE TABLE States(
  id_state INT IDENTITY(1, 1) PRIMARY KEY,
  state_name NVARCHAR(255) NOT NULL,
  id_country INT FOREIGN KEY REFERENCES Countries(id_country)
);

CREATE TABLE Districts(
  id_district INT IDENTITY(1, 1) PRIMARY KEY,
  district_name NVARCHAR(255) NOT NULL,
  id_state INT FOREIGN KEY REFERENCES States(id_state)
);

CREATE TABLE Addresses(
  id_address INT IDENTITY(1, 1) PRIMARY KEY,
  id_district INT FOREIGN KEY REFERENCES Districts(id_district),
  address_1 NVARCHAR(255) NOT NULL,
  address_2 NVARCHAR(255),
);

CREATE TABLE Persons(
  id_person INT IDENTITY(1, 1) PRIMARY KEY,
  person_name NVARCHAR(255) NOT NULL,
  last_name NVARCHAR(255) NOT NULL,
  email NVARCHAR(255) NOT NULL,
  phone INT NOT NULL
);

CREATE TABLE Producers(
  id_producer INT IDENTITY(1, 1) PRIMARY KEY,
  producer_name NVARCHAR(255) NOT NULL,
);

CREATE TABLE ProducerContacs(
  id_producer_contact INT IDENTITY(1, 1) PRIMARY KEY,
  id_producer INT FOREIGN KEY REFERENCES Producers(id_producer),
  id_contact_type INT FOREIGN KEY REFERENCES ContactTypes(id_type),
  contact NVARCHAR(255) NOT NULL,
  contact_procedure NVARCHAR(255)
);

CREATE TABLE Products(
  id_product INT IDENTITY(1, 1) PRIMARY KEY,
  product_name NVARCHAR(255) NOT NULL,
  id_unit INT FOREIGN KEY REFERENCES Units(id_unit),
  min INT NOT NULL,
  max INT NOT NULL
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
  level_number INT NOT NULL
);

CREATE TABLE InventaryLogs(
  id_inventary_logs INT IDENTITY(1, 1) PRIMARY KEY,
  id_product INT FOREIGN KEY REFERENCES Products(id_product),
  post_time DATETIME DEFAULT GETDATE(),
  quantity INT NOT NULL,
  buy_price INT NOT NULL,
  sell_price INT NOT NULL,
  id_status INT FOREIGN KEY REFERENCES ProductStatus(id_status),
  id_producer INT FOREIGN KEY REFERENCES Producers(id_producer),
  id_storage_space INT FOREIGN KEY REFERENCES StorageSpaces(id_storage_space)
);

CREATE TABLE Collaborators(
  id_collaborator INT IDENTITY(1, 1) PRIMARY KEY,
  id_boss INT FOREIGN KEY REFERENCES Collaborators(id_collaborator),
  id_person INT FOREIGN KEY REFERENCES Persons(id_person),
  id_type INT FOREIGN KEY REFERENCES CollaboratorsTypes(id_type),
  salary INT NOT NULL,
  post_time DATETIME NOT NULL DEFAULT GETDATE()
);

CREATE TABLE Clients(
  id_client INT IDENTITY(1, 1) PRIMARY KEY,
  id_person INT FOREIGN KEY REFERENCES Persons(id_person),
  post_time DATETIME NOT NULL DEFAULT GETDATE()
);

CREATE TABLE Cards(
  id_card INT IDENTITY(1, 1) PRIMARY KEY,
  id_client INT FOREIGN KEY REFERENCES Clients(id_client),
  post_time DATETIME NOT NULL DEFAULT GETDATE(),
  card_number BIGINT NOT NULL UNIQUE,
  expiration_date DATETIME NOT NULL,
  cvv SMALLINT NOT NULL
);

CREATE TABLE ReceptionPlaces(
  id_place INT IDENTITY(1, 1) PRIMARY KEY,
  id_client INT FOREIGN KEY REFERENCES Clients(id_client),
  place INT FOREIGN KEY REFERENCES Addresses(id_address)
);

CREATE TABLE Orders(
  id_order INT IDENTITY(1, 1) PRIMARY KEY,
  id_client INT FOREIGN KEY REFERENCES Clients(id_client),
  post_time DATETIME NOT NULL DEFAULT GETDATE(),
  discount INT NOT NULL DEFAULT 0,
  dispatch_place INT FOREIGN KEY REFERENCES StorageSpaces(id_storage_space),
  deadline DATETIME NOT NULL,
  id_status INT FOREIGN KEY REFERENCES OrderStatus(id_status),
  total INT NOT NULL,
  id_reception_place INT FOREIGN KEY REFERENCES ReceptionPlaces(id_place),
  payment_method INT FOREIGN KEY REFERENCES PaymenMethods(id_payment_method)
);

CREATE TABLE OrdersDetails(
  id_order_detail INT IDENTITY(1, 1) PRIMARY KEY,
  id_order INT FOREIGN KEY REFERENCES Orders(id_order),
  id_inventary INT FOREIGN KEY REFERENCES InventaryLogs(id_inventary_logs),
  quantity INT NOT NULL,
  sell_price INT NOT NULL
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


CREATE TABLE Routes(
  id_route INT IDENTITY(1, 1) PRIMARY KEY,
  init_time DATETIME NOT NULL,
  finish_time DATETIME,
  id_collaborator INT FOREIGN KEY REFERENCES Collaborators(id_collaborator)
);

CREATE TABLE Order_Routes(
  id_oxr INT IDENTITY(1, 1) PRIMARY KEY,
  id_order INT FOREIGN KEY REFERENCES Orders(id_order),
  id_route INT FOREIGN KEY REFERENCES Routes(id_route),
  delivery_time DATETIME,
  delivery_status INT FOREIGN KEY REFERENCES DeliveryStatus (id_status),
);

CREATE TABLE OrdersPreparations(
  id_order_preparation INT IDENTITY(1, 1) PRIMARY KEY,
  id_order INT FOREIGN KEY REFERENCES Orders(id_order),
  id_collaborator INT FOREIGN KEY REFERENCES Collaborators(id_collaborator),
  init_time DATETIME NOT NULL DEFAULT GETDATE(),
  finish_time DATETIME,
  preparation_status INT FOREIGN KEY REFERENCES OrderStatus(id_status),
);

CREATE TABLE ProductsPreparations(
  id_product_preparation INT IDENTITY(1, 1) PRIMARY KEY,
  id_inventary INT FOREIGN KEY REFERENCES InventaryLogs(id_inventary_logs),
  quantity INT NOT NULL,
  id_collaborator INT FOREIGN KEY REFERENCES Collaborators(id_collaborator),
  init_time DATETIME NOT NULL DEFAULT GETDATE(),
  finish_time DATETIME,
  preparation_status INT FOREIGN KEY REFERENCES PreparationsStatus(id_status),
  preparation_type INT FOREIGN KEY REFERENCES PreparationsTypes(id_type),
);

GO
/*
Dummy data
*/

/*20 personas*/
insert into Persons (person_name, last_name, email, phone) values ('Leda', 'Paddemore', 'lpaddemore0@cam.ac.uk', '373086848');
insert into Persons (person_name, last_name, email, phone) values ('Dacey', 'Izacenko', 'dizacenko1@noaa.gov', '679121906');
insert into Persons (person_name, last_name, email, phone) values ('Armando', 'Pavie', 'apavie2@nba.com', '932940242');
insert into Persons (person_name, last_name, email, phone) values ('Gabbey', 'Theis', 'gtheis3@techcrunch.com', '655928297');
insert into Persons (person_name, last_name, email, phone) values ('Hasty', 'Fernie', 'hfernie4@walmart.com', '886962581');
insert into Persons (person_name, last_name, email, phone) values ('Nady', 'Maryet', 'nmaryet5@upenn.edu', '294668332');
insert into Persons (person_name, last_name, email, phone) values ('Cchaddie', 'Mallindine', 'cmallindine6@sogou.com', '595896946');
insert into Persons (person_name, last_name, email, phone) values ('Gerianna', 'Quadrio', 'gquadrio7@yahoo.com', '322531750');
insert into Persons (person_name, last_name, email, phone) values ('Erny', 'Ransley', 'eransley8@topsy.com', '719726165');
insert into Persons (person_name, last_name, email, phone) values ('Larry', 'MacKnight', 'lmacknight9@telegraph.co.uk', '516307622');
insert into Persons (person_name, last_name, email, phone) values ('Grantham', 'Oneal', 'goneala@ed.gov', '793215763');
insert into Persons (person_name, last_name, email, phone) values ('Valentijn', 'Varren', 'vvarrenb@skype.com', '863618582');
insert into Persons (person_name, last_name, email, phone) values ('Daile', 'Heaton', 'dheatonc@upenn.edu', '335959238');
insert into Persons (person_name, last_name, email, phone) values ('Abraham', 'Alliband', 'aallibandd@cisco.com', '542246764');
insert into Persons (person_name, last_name, email, phone) values ('Gael', 'Jude', 'gjudee@last.fm', '694856533');
insert into Persons (person_name, last_name, email, phone) values ('Lilith', 'Bryce', 'lbrycef@unesco.org', '729571768');
insert into Persons (person_name, last_name, email, phone) values ('Leonore', 'Menlow', 'lmenlowg@google.de', '954768325');
insert into Persons (person_name, last_name, email, phone) values ('Leon', 'Castanone', 'lcastanoneh@addtoany.com', '452723736');
insert into Persons (person_name, last_name, email, phone) values ('Stavros', 'Huchot', 'shuchoti@g.co', '836646704');
insert into Persons (person_name, last_name, email, phone) values ('Rabi', 'Bolle', 'rbollej@newsvine.com', '747269434');

/* Unidades */
insert into Units (unit_name) values ('kilos');
insert into Units (unit_name) values ('unidades');

/*15 productos*/
insert into Products (product_name, id_unit, min, max) values ('Mauna Kea Phyllostegia', 2, 18, 79);
insert into Products (product_name, id_unit, min, max) values ('Dirina Lichen', 1, 16, 88);
insert into Products (product_name, id_unit, min, max) values ('Carolina Wild Petunia', 2, 3, 62);
insert into Products (product_name, id_unit, min, max) values ('Clokey''s Milkvetch', 2, 7, 71);
insert into Products (product_name, id_unit, min, max) values ('Yellow Chiodecton Lichen', 2, 24, 73);
insert into Products (product_name, id_unit, min, max) values ('Rothrock''s Keckiella', 2, 2, 69);
insert into Products (product_name, id_unit, min, max) values ('Treelover', 2, 21, 82);
insert into Products (product_name, id_unit, min, max) values ('Noel''s Owl''s-clover', 2, 10, 72);
insert into Products (product_name, id_unit, min, max) values ('American Dwarf Mistletoe', 2, 10, 71);
insert into Products (product_name, id_unit, min, max) values ('Erect Brachymenium Moss', 2, 13, 87);
insert into Products (product_name, id_unit, min, max) values ('Fernald''s Northern Rockcress', 1, 14, 96);
insert into Products (product_name, id_unit, min, max) values ('Indian Pink', 2, 16, 92);
insert into Products (product_name, id_unit, min, max) values ('Balsamillo', 2, 8, 70);
insert into Products (product_name, id_unit, min, max) values ('Freckled Milkvetch', 2, 19, 84);
insert into Products (product_name, id_unit, min, max) values ('Alpine Bittercress', 2, 25, 97);


/* dummy para crear ordernes */
insert into InventaryLogs (id_product, quantity, buy_price, sell_price) values (10, 60, 14, 91);
insert into InventaryLogs (id_product, quantity, buy_price, sell_price) values (15, 43, 29, 99);
insert into InventaryLogs (id_product, quantity, buy_price, sell_price) values (15, 51, 8, 100);
insert into InventaryLogs (id_product, quantity, buy_price, sell_price) values (15, 64, 25, 75);
insert into InventaryLogs (id_product, quantity, buy_price, sell_price) values (9, 51, 22, 97);
insert into InventaryLogs (id_product, quantity, buy_price, sell_price) values (7, 34, 31, 70);
insert into InventaryLogs (id_product, quantity, buy_price, sell_price) values (8, 68, 13, 83);
insert into InventaryLogs (id_product, quantity, buy_price, sell_price) values (8, 30, 18, 62);
insert into InventaryLogs (id_product, quantity, buy_price, sell_price) values (6, 46, 35, 71);
insert into InventaryLogs (id_product, quantity, buy_price, sell_price) values (10, 40, 5, 78);
insert into InventaryLogs (id_product, quantity, buy_price, sell_price) values (9, 22, 1, 91);
insert into InventaryLogs (id_product, quantity, buy_price, sell_price) values (6, 38, 40, 75);
insert into InventaryLogs (id_product, quantity, buy_price, sell_price) values (3, 63, 36, 90);
insert into InventaryLogs (id_product, quantity, buy_price, sell_price) values (13, 23, 38, 77);
insert into InventaryLogs (id_product, quantity, buy_price, sell_price) values (14, 60, 20, 92);
insert into InventaryLogs (id_product, quantity, buy_price, sell_price) values (4, 67, 15, 95);
insert into InventaryLogs (id_product, quantity, buy_price, sell_price) values (2, 53, 25, 90);
insert into InventaryLogs (id_product, quantity, buy_price, sell_price) values (1, 26, 25, 84);
insert into InventaryLogs (id_product, quantity, buy_price, sell_price) values (6, 52, 25, 99);
insert into InventaryLogs (id_product, quantity, buy_price, sell_price) values (7, 70, 28, 96);
insert into InventaryLogs (id_product, quantity, buy_price, sell_price) values (8, 44, 34, 96);
insert into InventaryLogs (id_product, quantity, buy_price, sell_price) values (4, 20, 33, 73);
insert into InventaryLogs (id_product, quantity, buy_price, sell_price) values (4, 46, 7, 92);
insert into InventaryLogs (id_product, quantity, buy_price, sell_price) values (11, 24, 13, 63);
insert into InventaryLogs (id_product, quantity, buy_price, sell_price) values (8, 70, 6, 60);
insert into InventaryLogs (id_product, quantity, buy_price, sell_price) values (15, 22, 16, 80);
insert into InventaryLogs (id_product, quantity, buy_price, sell_price) values (6, 67, 20, 93);
insert into InventaryLogs (id_product, quantity, buy_price, sell_price) values (9, 26, 39, 81);
insert into InventaryLogs (id_product, quantity, buy_price, sell_price) values (8, 65, 37, 89);
insert into InventaryLogs (id_product, quantity, buy_price, sell_price) values (4, 21, 31, 91);

insert into Clients (id_person) values (1);
insert into Clients (id_person) values (2);
insert into Clients (id_person) values (3);
insert into Clients (id_person) values (4);
insert into Clients (id_person) values (5);
insert into Clients (id_person) values (6);
insert into Clients (id_person) values (7);
insert into Clients (id_person) values (8);
insert into Clients (id_person) values (9);
insert into Clients (id_person) values (10);
insert into Clients (id_person) values (11);
insert into Clients (id_person) values (12);
/*3 ordernes, inserto solo los datos necesarios para las consultas, 
el total en las ordenes sería el oficial pero en estos datos dummys 
no va a cuadrar*/
insert into Orders (id_client, deadline, total) values (5, '2023-01-01 02:05:28', 4000);
insert into Orders (id_client, deadline, total) values (10, '2022-11-16 09:16:45', 8150);
insert into Orders (id_client, deadline, total) values (1, '2022-04-02 05:24:49', 15900);

insert into OrdersDetails (id_order, id_inventary, quantity, sell_price) values (3, 10, 5, 54);
insert into OrdersDetails (id_order, id_inventary, quantity, sell_price) values (1, 27, 1, 54);
insert into OrdersDetails (id_order, id_inventary, quantity, sell_price) values (1, 9, 4, 77);
insert into OrdersDetails (id_order, id_inventary, quantity, sell_price) values (1, 15, 3, 54);
insert into OrdersDetails (id_order, id_inventary, quantity, sell_price) values (2, 28, 1, 55);
insert into OrdersDetails (id_order, id_inventary, quantity, sell_price) values (2, 7, 2, 54);
insert into OrdersDetails (id_order, id_inventary, quantity, sell_price) values (3, 23, 1, 79);
insert into OrdersDetails (id_order, id_inventary, quantity, sell_price) values (2, 5, 4, 58);
insert into OrdersDetails (id_order, id_inventary, quantity, sell_price) values (1, 17, 1, 60);
insert into OrdersDetails (id_order, id_inventary, quantity, sell_price) values (2, 23, 1, 57);
insert into OrdersDetails (id_order, id_inventary, quantity, sell_price) values (1, 7, 2, 53);
insert into OrdersDetails (id_order, id_inventary, quantity, sell_price) values (1, 27, 3, 74);
insert into OrdersDetails (id_order, id_inventary, quantity, sell_price) values (2, 24, 5, 57);
insert into OrdersDetails (id_order, id_inventary, quantity, sell_price) values (3, 9, 3, 70);
insert into OrdersDetails (id_order, id_inventary, quantity, sell_price) values (1, 13, 4, 54);
insert into OrdersDetails (id_order, id_inventary, quantity, sell_price) values (2, 23, 2, 77);
insert into OrdersDetails (id_order, id_inventary, quantity, sell_price) values (2, 30, 4, 73);
insert into OrdersDetails (id_order, id_inventary, quantity, sell_price) values (1, 9, 3, 72);
insert into OrdersDetails (id_order, id_inventary, quantity, sell_price) values (2, 4, 3, 75);
insert into OrdersDetails (id_order, id_inventary, quantity, sell_price) values (1, 9, 4, 75);
insert into OrdersDetails (id_order, id_inventary, quantity, sell_price) values (1, 30, 5, 77);
insert into OrdersDetails (id_order, id_inventary, quantity, sell_price) values (2, 30, 4, 74);
insert into OrdersDetails (id_order, id_inventary, quantity, sell_price) values (2, 4, 4, 55);
insert into OrdersDetails (id_order, id_inventary, quantity, sell_price) values (3, 30, 4, 75);
insert into OrdersDetails (id_order, id_inventary, quantity, sell_price) values (2, 8, 4, 65);
insert into OrdersDetails (id_order, id_inventary, quantity, sell_price) values (3, 19, 4, 72);
insert into OrdersDetails (id_order, id_inventary, quantity, sell_price) values (1, 27, 4, 76);
insert into OrdersDetails (id_order, id_inventary, quantity, sell_price) values (2, 5, 5, 64);
insert into OrdersDetails (id_order, id_inventary, quantity, sell_price) values (3, 21, 3, 71);
insert into OrdersDetails (id_order, id_inventary, quantity, sell_price) values (3, 1, 2, 61);

/*Conultas de la primera entrega*/

/*cuál es el top 5 de compradores estrella*/
SELECT TOP 5 
  Orders.id_client AS cliente_estrella, SUM(Orders.total) AS total_compras
  FROM Orders
  GROUP BY Orders.id_client
  ORDER BY total_compras DESC

/*cuál es el top 5 de productos más vendidos en los últimos 15 días*/ 
SELECT TOP 5 
  InventaryLogs.id_product as Producto_más_vendido, SUM(OrdersDetails.quantity * OrdersDetails.sell_price) AS total_vendido
  FROM Orders
  INNER JOIN OrdersDetails
  ON OrdersDetails.id_order = Orders.id_order
  INNER JOIN InventaryLogs
  ON InventaryLogs.id_inventary_logs = OrdersDetails.id_inventary
  WHERE DATEDIFF(DAY, Orders.post_time, GETDATE()) < 16
  GROUP BY InventaryLogs.id_product
  ORDER BY total_vendido DESC
/*cuál es el total de compras por persona*/
SELECT 
  Orders.id_client AS cliente, SUM(Orders.total) AS total_compras
  FROM Orders
  GROUP BY Orders.id_client

/*cuál es el total vendido por producto*/
SELECT 
	InventaryLogs.id_product as Producto, SUM(OrdersDetails.quantity * OrdersDetails.sell_price) AS total_vendido
  FROM OrdersDetails
  INNER JOIN InventaryLogs
  ON InventaryLogs.id_inventary_logs = OrdersDetails.id_inventary
  GROUP BY InventaryLogs.id_product