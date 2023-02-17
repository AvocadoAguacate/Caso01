/*
Quiz #1
Esteban Guzmán Ramírez - 2015095861
*/
CREATE TYPE dbo.TVP_OrderProducts AS TABLE(
  product_name NVARCHAR(255),
  quantity INT
)
GO
-----------------------------------------------------------
-- Autor: EGuzmán
-- Fecha: 02/17/2023
-- Descripcion: procedimiento para registrar un pedido de un consumidor
-----------------------------------------------------------
CREATE PROCEDURE [dbo].[FeriaSP_PlaceOrder]
	@clientId INT,
	@products TVP_OrderProducts READONLY
AS 
BEGIN
	
	SET NOCOUNT ON -- no retorne metadatos
	
	DECLARE @ErrorNumber INT, @ErrorSeverity INT, @ErrorState INT, @CustomError INT
	DECLARE @Message VARCHAR(200)
	DECLARE @InicieTransaccion BIT

	DECLARE @direccionId INT
	DECLARE @productCount INT
	DECLARE @orderStatusId INT
	DECLARE @orderId INT
	DECLARE @Total MONEY

	SELECT @direccionId=ISNULL(idDireccion,0) FROM dbo.ReceptionPlaces WHERE idCliente = @clientId

	SELECT @orderStatusId = idEstadoOrden FROM dbo.OrderStatus WHERE status_name = 'Por entregar'
	
	SELECT @productCount = COUNT(*) FROM @products

	IF (@direccionId>0 AND @productCount>0) BEGIN

		SET @InicieTransaccion = 0
		IF @@TRANCOUNT=0 BEGIN
			SET @InicieTransaccion = 1
			SET TRANSACTION ISOLATION LEVEL READ COMMITTED
			BEGIN TRANSACTION		
		END
	
		BEGIN TRY
			SET @CustomError = 2001

			INSERT INTO dbo.Orders (total, id_client, id_status, dispatch_place)
			VALUES
			(0.0,  @clientId, @orderStatusId, @direccionId)

			SELECT @orderId = SCOPE_IDENTITY()

			INSERT INTO dbo.OrdersDetails (id_product, id_order, quantity, sell_price)
			SELECT idProducto, @orderId, prodOrders.quantity, sell_price  FROM dbo.Products prods 
			INNER JOIN @products prodOrders ON prodOrders.Name = prods.product_name

			SELECT @Total = SUM(quantity*quantity) FROM dbo.OrdersDetails WHERE id_order = @orderId

			UPDATE dbo.Orders SET total = @Total WHERE id_order = @orderId
			
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

/*Caso ok*/
DECLARE @myProducts TVP_OrderProducts
INSERT @myProducts VALUES 
('Aguacate', 5),
('Mango', 10),
('Pipa', 2)


exec dbo.[FeriaSP_PlaceOrder] 3, @myProducts
select * from Ordenes where clienteId = 3
select * from ProductoXOrden

/*Error porque no puede insertar el null*/
DECLARE @myProducts TVP_OrderProducts
INSERT @myProducts VALUES 
('AguacateX', 5),
('MangoX', 10),
('PipaX', 2)


exec dbo.[FeriaSP_PlaceOrder] 3, @myProducts
select * from Ordenes where clienteId = 3