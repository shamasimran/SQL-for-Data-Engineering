USE [DataPurBatch01]
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Sales' and xtype='U')
BEGIN
		CREATE TABLE Sales 
		(
			SaleID INT IDENTITY,
			Region VARCHAR(50),
			Product VARCHAR(50),
			Quantity INT,
			UnitPrice DECIMAL(10, 2),
			SaleDate DATE
		)

		INSERT INTO Sales (Region, Product, Quantity, UnitPrice, SaleDate)
		VALUES 
		('North', 'Laptop', 2, 1000.00, '2025-07-01'),
		('North', 'Laptop', 1, 1000.00, '2025-07-02'),
		('South', 'Phone', 3, 500.00, '2025-07-01'),
		('South', 'Tablet', 1, 300.00, '2025-07-02'),
		('East', 'Phone', 4, 500.00, '2025-07-03'),
		('East', 'Laptop', 1, 1000.00, '2025-07-04');

		INSERT INTO Sales (Region, Product, Quantity, UnitPrice, SaleDate)
		VALUES 
		(NULL, 'Monitor', 2, 200.00, '2025-07-05'),
		(NULL, 'Keyboard', 1, 50.00, '2025-07-06');
END
GO
