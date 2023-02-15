CREATE DATABASE caso01

GO 

USE caso01

GO

CREATE TABLE StorageTypes(
  id_Storage_type INT IDENTITY(1,1) PRIMARY KEY,
  type_name NVARCHAR(255) NOT NULL
);

CREATE TABLE DeliveryTypes(
  id_type INT IDENTITY(1,1) PRIMARY KEY,
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

CREATE TABLE ActionTypes(
  id_type INT IDENTITY(1,1) PRIMARY KEY,
  type_name NVARCHAR(255) NOT NULL
);

CREATE TABLE ContactTypes(
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









