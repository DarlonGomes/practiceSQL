-- Create Database:

    CREATE DATABASE "practiceDriven";

-- Table "states":

CREATE TABLE "states"(
	"id" SERIAL PRIMARY KEY,
	"name" TEXT NOT NULL
);

-- Table "cities":

CREATE TABLE "cities"(
	"id" SERIAL PRIMARY KEY,
	"name" TEXT NOT NULL,
	"stateId" INTEGER NOT NULL REFERENCES "states"("id")
);

-- Table "customers":

CREATE TABLE "customers"(
	"id" SERIAL PRIMARY KEY,
	"fullName" TEXT NOT NULL,
	"cpf" varchar(11) NOT NULL UNIQUE,
	"email" TEXT NOT NULL UNIQUE,
	"password" TEXT NOT NULL
);

-- Table "customerAddresses":

CREATE TABLE "customerAddresses"(
	"id" SERIAL PRIMARY KEY,
	"customerId" INTEGER NOT NULL REFERENCES "customers"("id"),
	"street" TEXT NOT NULL,
	"number" INTEGER NOT NULL,
	"complement" TEXT NOT NULL,
	"postalCode" TEXT NOT NULL,
	"cityId" INTEGER NOT NULL REFERENCES "cities"("id")
);

-- Table "customerPhones":
CREATE TYPE type AS ENUM('landline','mobile');

CREATE TABLE "customerPhones"(
	"id" SERIAL PRIMARY KEY,
	"customerId" INTEGER NOT NULL REFERENCES "customers"("id"),
	"number" TEXT NOT NULL UNIQUE,
	"type" TYPE
);

-- Table "bankAccount":

CREATE TABLE "bankAccount"(
	"id" SERIAL PRIMARY KEY,
	"customerId" INTEGER NOT NULL REFERENCES "customers"("id"),
	"accountNumber" varchar(7) NOT NULL UNIQUE,
	"agency" TEXT NOT NULL,
	"openDate" DATE NOT NULL DEFAULT NOW(),
	"endDate" DATE DEFAULT NULL
);

-- Table "transactions":
CREATE TYPE transaction AS ENUM('deposit','withdraw');

CREATE TABLE "transactions"(
	"id" SERIAL PRIMARY KEY,
	"bankAccountId" INTEGER NOT NULL REFERENCES "bankAccount"("id"),
	"amount" INTEGER NOT NULL DOUBLE PRECISION,
	"type" TRANSACTION ,
	"time" TIMESTAMP NOT NULL DEFAULT NOW(),
	"description" TEXT,
	"cancelled" BOOLEAN NOT NULL DEFAULT FALSE
);

-- Table "creditCards":

CREATE TABLE "creditCards"(
	"id" SERIAL PRIMARY KEY,
	"bankAccountId" INTEGER NOT NULL REFERENCES "bankAccount"("id"),
	"name" TEXT NOT NULL,
    "number" varchar(16) NOT NULL UNIQUE,
	"securityCode" varchar(3) NOT NULL ,
	"expirationMont" varchar(2) NOT NULL,
	"expirationYear" varchar(4) NOT NULL,
	"password" varchar(4) NOT NULL,
	"limit" INTEGER NOT NULL
);