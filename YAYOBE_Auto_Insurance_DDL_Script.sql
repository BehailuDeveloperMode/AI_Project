/********************************************************************************************
-- Author:        Behailu Tessema
-- Created On:    2025-08-02
-- Project:       YAYOBE AUTO INSURANCE Management System
-- Procedure:     BuildYayobeDatabase
-- Description:   Creates the full database schema, including tables, relationships,
--                constraints, and other core objects for the YAYOBE AUTO INSURANCE system.
-- Revision:      1.0
-- Change Log: NA
--   2025-06-02 - Initial version created by Behailu Tessema to set up the entire database.
********************************************************************************************/
-- This section verifies the database environment and performs cleanup.
-- If the target database or related objects already exist, they are safely dropped.
-- This ensures a clean setup by removing any conflicting definitions before creating new ones.
--===============================
IF EXISTS (SELECT name FROM sys.databases WHERE name = 'YAYOBE_AUTO_INSURANCE')
BEGIN
    EXEC('USE YAYOBE_AUTO_INSURANCE');
END
GO
--=======
IF EXISTS (
    SELECT 1 FROM sys.foreign_keys WHERE name = 'claim_accident_report_FK'
)
BEGIN
    ALTER TABLE claim 
	DROP CONSTRAINT claim_accident_report_FK;
    PRINT 'Dropped constraint claim_accident_report_FK';
END
GO
--=======================
IF EXISTS (
    SELECT 1 FROM sys.foreign_keys WHERE name = 'policy_agent_FK'
)
BEGIN
    ALTER TABLE policy 
	DROP CONSTRAINT policy_agent_FK;
    PRINT 'Dropped constraint policy_agent_FK';
END
GO
--=======================
IF EXISTS (
    SELECT 1 FROM sys.foreign_keys WHERE name = 'payment_claim_FK'
)
BEGIN
    ALTER TABLE payment 
	DROP CONSTRAINT payment_claim_FK;
    PRINT 'Dropped constraint payment_claim_FK';
END
GO
--=======================
IF EXISTS (
    SELECT 1 FROM sys.foreign_keys WHERE name = 'coverage_coverage_type_FK'
)
BEGIN
    ALTER TABLE coverage 
	DROP CONSTRAINT coverage_coverage_type_FK;
    PRINT 'Dropped constraint coverage_coverage_type_FK';
END
GO
--=======================
IF EXISTS (
    SELECT 1 FROM sys.foreign_keys WHERE name = 'policy_customer_FK'
)
BEGIN
    ALTER TABLE policy 
        DROP CONSTRAINT policy_vehicle_FK;
    PRINT 'Dropped constraint: policy_vehicle_FK';

    ALTER TABLE policy 
        DROP CONSTRAINT policy_customer_FK;
    PRINT 'Dropped constraint: policy_customer_FK';
END
GO

--=======================
IF EXISTS (
    SELECT 1 FROM sys.foreign_keys WHERE name = 'vehicle_customer_FK'
)
BEGIN
    ALTER TABLE vehicle 
	DROP CONSTRAINT vehicle_customer_FK;
    PRINT 'Dropped constraint vehicle_customer_FK';
END
GO
--=======================
IF EXISTS (
    SELECT 1 FROM sys.foreign_keys WHERE name = 'accident_report_policy_FK'
)
BEGIN
    ALTER TABLE accident_report 
	DROP CONSTRAINT accident_report_policy_FK;
    PRINT 'Dropped constraint accident_report_policy_FK';
END
GO
--=======================
IF EXISTS (
    SELECT 1 FROM sys.foreign_keys WHERE name = 'coverage_policy_FK'
)
BEGIN
    ALTER TABLE coverage 
	DROP CONSTRAINT coverage_policy_FK;
    PRINT 'Dropped constraint coverage_policy_FK';
END
GO
--=======================
IF OBJECT_ID('accident_report', 'U') IS NOT NULL
BEGIN
    DROP TABLE accident_report;
    PRINT 'Dropped table accident_report';
END
GO
--=======================
IF OBJECT_ID('agent', 'U') IS NOT NULL
BEGIN
    DROP TABLE agent;
    PRINT 'Dropped table agent';
END
GO
--=======================
IF OBJECT_ID('claim', 'U') IS NOT NULL
BEGIN
    DROP TABLE claim;
    PRINT 'Dropped table claim';
END
GO
--=======================
IF OBJECT_ID('coverage', 'U') IS NOT NULL
BEGIN
    DROP TABLE coverage;
    PRINT 'Dropped table coverage';
END
GO
--=======================
IF OBJECT_ID('coverage_type', 'U') IS NOT NULL
BEGIN
    DROP TABLE coverage_type;
    PRINT 'Dropped table coverage_type';
END
GO
--=======================
IF OBJECT_ID('customer', 'U') IS NOT NULL
BEGIN
    DROP TABLE customer;
    PRINT 'Dropped table customer';
END
GO
--=======================
IF OBJECT_ID('payment', 'U') IS NOT NULL
BEGIN
    DROP TABLE payment;
    PRINT 'Dropped table payment';
END
GO
--=======================
IF OBJECT_ID('policy', 'U') IS NOT NULL
BEGIN
    DROP TABLE policy;
    PRINT 'Dropped table policy';
END
GO
--=======================
IF OBJECT_ID('vehicle', 'U') IS NOT NULL
BEGIN
    DROP TABLE vehicle;
    PRINT 'Dropped table vehicle';
END
GO
--==============================
USE master;
GO
--==============================
IF EXISTS (SELECT name FROM sys.databases WHERE name = 'YAYOBE_AUTO_INSURANCE')
BEGIN
    ALTER DATABASE YAYOBE_AUTO_INSURANCE 
	SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE YAYOBE_AUTO_INSURANCE;
    PRINT 'Existing database dropped.';
END
GO
--==============================

CREATE DATABASE YAYOBE_AUTO_INSURANCE;
PRINT 'New database created.';
ALTER DATABASE YAYOBE_AUTO_INSURANCE SET MULTI_USER;
PRINT 'Database set to MULTI_USER mode.';
GO
--==============================
USE YAYOBE_AUTO_INSURANCE;
GO
--==============================
CREATE TABLE accident_report 
(
 report_id INTEGER NOT NULL , 
 accident_date DATE NOT NULL , 
 accident_time TIME , 
 location VARCHAR (120) , 
 number_of_accident INTEGER , 
 fault_determination VARCHAR (120) , 
 policy_policy_id INTEGER NOT NULL 
);
GO
PRINT 'Created table accident_report';
GO

ALTER TABLE accident_report 
ADD CONSTRAINT accident_report_PK PRIMARY KEY CLUSTERED (report_id)
 WITH (ALLOW_PAGE_LOCKS = ON , ALLOW_ROW_LOCKS = ON);
GO

CREATE TABLE agent 
(
 agent_id INTEGER NOT NULL , 
 agent_name VARCHAR (120) NOT NULL , 
 agent_address VARCHAR (120) , 
 city VARCHAR (120) , 
 state VARCHAR (120) , 
 zip_code VARCHAR (120) , 
 agent_email NVARCHAR (120) , 
 agent_phone NVARCHAR (120) , 
 agent_website NVARCHAR (120) , 
 commission_rate INTEGER 
);
GO
PRINT 'Created table agent';
GO

ALTER TABLE agent 
ADD CONSTRAINT agent_PK PRIMARY KEY CLUSTERED (agent_id)
 WITH (ALLOW_PAGE_LOCKS = ON , ALLOW_ROW_LOCKS = ON);
GO

CREATE TABLE claim 
(
 claim_id INTEGER NOT NULL , 
 claim_date DATE NOT NULL , 
 claim_status VARCHAR (120) , 
 claim_amount DECIMAL(16,2) , 
 accident_report_report_id INTEGER NOT NULL 
);
GO
PRINT 'Created table claim';
GO

ALTER TABLE claim 
ADD CONSTRAINT claim_PK PRIMARY KEY CLUSTERED (claim_id)
 WITH (ALLOW_PAGE_LOCKS = ON , ALLOW_ROW_LOCKS = ON);
GO

CREATE TABLE coverage 
(
 coverage_id INTEGER NOT NULL , 
 coverage_type VARCHAR (120) NOT NULL , 
 coverage_limit DECIMAL(16,2) NOT NULL , 
 deductible DECIMAL(16,2) NOT NULL , 
 coverage_type_coverage_type_id INTEGER NOT NULL , 
 policy_policy_id INTEGER NOT NULL 
);
GO
PRINT 'Created table coverage';
GO

ALTER TABLE coverage 
ADD CONSTRAINT coverage_PK PRIMARY KEY CLUSTERED (coverage_id)
 WITH (ALLOW_PAGE_LOCKS = ON , ALLOW_ROW_LOCKS = ON);
GO

CREATE TABLE coverage_type 
(
 coverage_type_id INTEGER NOT NULL , 
 coverage_name VARCHAR (120) NOT NULL 
);
GO
PRINT 'Created table coverage_type';
GO

ALTER TABLE coverage_type 
ADD CONSTRAINT coverage_type_PK PRIMARY KEY CLUSTERED (coverage_type_id)
 WITH (ALLOW_PAGE_LOCKS = ON , ALLOW_ROW_LOCKS = ON);
GO

CREATE TABLE customer 
(
 customer_id INTEGER NOT NULL , 
 first_name VARCHAR (120) NOT NULL , 
 last_name VARCHAR (120) NOT NULL , 
 date_of_birth DATE , 
 cust_address VARCHAR (120) , 
 city VARCHAR (120) , 
 sate VARCHAR (120) , 
 zip_code VARCHAR (120) , 
 cust_phone NVARCHAR (120) , 
 cust_email NVARCHAR (120) , 
 driver_license_number NVARCHAR (120) NOT NULL , 
 marital_status VARCHAR (120) , 
 occupation VARCHAR (120) , 
 gender VARCHAR (120) , 
 education_level VARCHAR (120) , 
 ssn NVARCHAR (120) 
);
GO
PRINT 'Created table customer';
GO

ALTER TABLE customer 
ADD CONSTRAINT customer_PK PRIMARY KEY CLUSTERED (customer_id)
 WITH (ALLOW_PAGE_LOCKS = ON , ALLOW_ROW_LOCKS = ON);
GO

CREATE TABLE payment 
(
 payment_id INTEGER NOT NULL , 
 payment_date DATE , 
 [payment-amount] DECIMAL(16,2) , 
 [payment-method] VARCHAR (120) , 
 payment_status VARCHAR (120) , 
 policy_id INTEGER NOT NULL , 
 claim_claim_id INTEGER NOT NULL 
);
GO
PRINT 'Created table payment';
GO

ALTER TABLE payment 
ADD CONSTRAINT payment_PK PRIMARY KEY CLUSTERED (payment_id)
 WITH (ALLOW_PAGE_LOCKS = ON , ALLOW_ROW_LOCKS = ON);
GO

CREATE TABLE policy 
(
 policy_id INTEGER NOT NULL , 
 policy_number VARCHAR (120) NOT NULL , 
 start_date DATE , 
 end_date DATE , 
 policy_status VARCHAR (120) , 
 premium_amount DECIMAL(16,2) , 
 customer_customer_id INTEGER NOT NULL , 
 agent_agent_id INTEGER NOT NULL , 
 vehicle_vehicle_id INTEGER NOT NULL 
);
GO
PRINT 'Created table policy';
GO

ALTER TABLE policy 
ADD CONSTRAINT policy_PK PRIMARY KEY CLUSTERED (policy_id)
 WITH (ALLOW_PAGE_LOCKS = ON , ALLOW_ROW_LOCKS = ON);
GO

CREATE TABLE vehicle 
(
 vehicle_id INTEGER NOT NULL , 
 make VARCHAR (120) , 
 model VARCHAR (120) , 
 color VARCHAR (120) , 
 vehicle_year INTEGER NOT NULL , 
 vin NVARCHAR (120) NOT NULL , 
 license_plate NVARCHAR (120) , 
 state_regester VARCHAR (120) , 
 customer_customer_id INTEGER NOT NULL 
);
GO
PRINT 'Created table vehicle';
GO
--========================
ALTER TABLE vehicle 
ADD CONSTRAINT vehicle_PK PRIMARY KEY CLUSTERED (vehicle_id)
 WITH (ALLOW_PAGE_LOCKS = ON , ALLOW_ROW_LOCKS = ON);
GO

-- Adding Foreign Key Constraints

ALTER TABLE accident_report 
ADD CONSTRAINT accident_report_policy_FK FOREIGN KEY (policy_policy_id) 
REFERENCES policy (policy_id) 
ON DELETE NO ACTION 
ON UPDATE NO ACTION;
GO
--========================
ALTER TABLE claim 
ADD CONSTRAINT claim_accident_report_FK FOREIGN KEY (accident_report_report_id) 
REFERENCES accident_report (report_id) 
ON DELETE NO ACTION 
ON UPDATE NO ACTION;
GO
--========================
ALTER TABLE coverage 
ADD CONSTRAINT coverage_coverage_type_FK FOREIGN KEY (coverage_type_coverage_type_id) 
REFERENCES coverage_type (coverage_type_id) 
ON DELETE NO ACTION 
ON UPDATE NO ACTION;
GO
--========================
ALTER TABLE coverage 
ADD CONSTRAINT coverage_policy_FK FOREIGN KEY (policy_policy_id) 
REFERENCES policy (policy_id) 
ON DELETE NO ACTION 
ON UPDATE NO ACTION;
GO
--========================
ALTER TABLE payment 
ADD CONSTRAINT payment_claim_FK FOREIGN KEY (claim_claim_id) 
REFERENCES claim (claim_id) 
ON DELETE NO ACTION 
ON UPDATE NO ACTION;
GO
--========================
ALTER TABLE policy 
ADD CONSTRAINT policy_agent_FK FOREIGN KEY (agent_agent_id) 
REFERENCES agent (agent_id) 
ON DELETE NO ACTION 
ON UPDATE NO ACTION;
GO
--========================
ALTER TABLE policy 
ADD CONSTRAINT policy_customer_FK FOREIGN KEY (customer_customer_id) 
REFERENCES customer (customer_id) 
ON DELETE NO ACTION 
ON UPDATE NO ACTION;
GO
--========================
ALTER TABLE policy 
ADD CONSTRAINT policy_vehicle_FK FOREIGN KEY (vehicle_vehicle_id) 
REFERENCES vehicle (vehicle_id) 
ON DELETE NO ACTION 
ON UPDATE NO ACTION;
GO
--========================
ALTER TABLE vehicle 
ADD CONSTRAINT vehicle_customer_FK FOREIGN KEY (customer_customer_id) 
REFERENCES customer (customer_id) 
ON DELETE NO ACTION 
ON UPDATE NO ACTION;
GO
--========================
PRINT 'All objects created successfully.';
GO

/********************************************************************************************
-- End of Procedure: BuildYayobeDatabase
********************************************************************************************/