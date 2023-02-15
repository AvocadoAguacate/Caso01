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







