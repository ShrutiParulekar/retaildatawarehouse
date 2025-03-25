
-- Script Purpose
-- This script creates three separate databases (bronze, silver, and gold) to implement a structured Medallion Architecture for data warehousing. 
-- These databases will store raw, cleansed, and business-ready data in a structured format to support analytical processing.


-- How It Works
-- Checks if the bronze, silver, and gold databases exist.

-- Drops them if they exist to ensure a fresh start.

-- Creates the three databases again.

-- Schemas are structured to maintain the Medallion Architecture workflow.

-- WARNING
-- Running this script will delete all existing data in the bronze, silver, and gold databases.

-- Ensure you have a backup before executing this script.

-- Proceed only if you intend to reset the entire structure.


CREATE SCHEMA IF NOT EXISTS bronze;
CREATE SCHEMA IF NOT EXISTS silver;
CREATE SCHEMA IF NOT EXISTS gold;


