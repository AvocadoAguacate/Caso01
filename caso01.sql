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
  place GEOGRAPHY
  /*quiero cambiar de patrón y sustutir*/
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