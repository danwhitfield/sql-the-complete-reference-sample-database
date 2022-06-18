USE sample_database;

CREATE TABLE PRODUCTS
(
    MFR_ID      CHAR(3)       NOT NULL,
    PRODUCT_ID  CHAR(5)       NOT NULL,
    DESCRIPTION VARCHAR(20)   NOT NULL,
    PRICE       DECIMAL(9, 2) NOT NULL,
    QTY_ON_HAND INTEGER       NOT NULL,
    PRIMARY KEY (MFR_ID, PRODUCT_ID)
);


CREATE TABLE OFFICES
(
    OFFICE INTEGER       NOT NULL,
    CITY   VARCHAR(15)   NOT NULL,
    REGION VARCHAR(10)   NOT NULL,
    MGR    INTEGER,
    TARGET DECIMAL(9, 2),
    SALES  DECIMAL(9, 2) NOT NULL,
    PRIMARY KEY (OFFICE)
);


CREATE TABLE SALESREPS
(
    EMPL_NUM   INTEGER       NOT NULL,
    NAME       VARCHAR(15)   NOT NULL,
    AGE        INTEGER,
    REP_OFFICE INTEGER,
    TITLE      VARCHAR(10),
    HIRE_DATE  DATE          NOT NULL,
    MANAGER    INTEGER,
    QUOTA      DECIMAL(9, 2),
    SALES      DECIMAL(9, 2) NOT NULL,
    PRIMARY KEY (EMPL_NUM),
    FOREIGN KEY WORKSIN (REP_OFFICE) REFERENCES OFFICES (OFFICE) ON DELETE SET NULL
);


CREATE TABLE CUSTOMERS
(
    CUST_NUM     INTEGER     NOT NULL,
    COMPANY      VARCHAR(20) NOT NULL,
    CUST_REP     INTEGER,
    CREDIT_LIMIT DECIMAL(9, 2),
    PRIMARY KEY (CUST_NUM),
    FOREIGN KEY HASREP (CUST_REP) REFERENCES SALESREPS (EMPL_NUM) ON DELETE SET NULL
);


CREATE TABLE ORDERS
(
    ORDER_NUM  INTEGER       NOT NULL,
    ORDER_DATE DATE          NOT NULL,
    CUST       INTEGER       NOT NULL,
    REP        INTEGER,
    MFR        CHAR(3)       NOT NULL,
    PRODUCT    CHAR(5)       NOT NULL,
    QTY        INTEGER       NOT NULL,
    AMOUNT     DECIMAL(9, 2) NOT NULL,
    PRIMARY KEY (ORDER_NUM),
    FOREIGN KEY PLACEDBY (CUST) REFERENCES CUSTOMERS (CUST_NUM) ON DELETE CASCADE,
    FOREIGN KEY TAKENBY (REP) REFERENCES SALESREPS (EMPL_NUM) ON DELETE SET NULL
);


INSERT INTO OFFICES
    (OFFICE, CITY, REGION, MGR, TARGET, SALES)
VALUES (22, 'Denver', 'Western', 108, 300000.00, 186042.00),
       (11, 'New York', 'Eastern', 106, 575000.00, 692637.00),
       (12, 'Chicago', 'Eastern', 104, 800000.00, 735042.00),
       (13, 'Atlanta', 'Eastern', 105, 350000.00, 367911.00),
       (21, 'Los Angeles', 'Western', 108, 725000.00, 835915.00);


INSERT INTO SALESREPS
    (EMPL_NUM, NAME, AGE, REP_OFFICE, TITLE, HIRE_DATE, MANAGER, QUOTA, SALES)
VALUES (108, 'Larry Pitch', 62, 21, 'Sales Mgr', '2007-10-12', 106, 350000.00, 361865.00),
       (104, 'Bob Smith', 33, 12, 'Sales Mgr', '2005-05-19', 106, 200000.00, 142594.00),
       (101, 'Dan Roberts', 45, 12, 'Sales Rep', '2004-10-20', 104, 300000.00, 305673.00),
       (105, 'Bill Adams', 37, 13, 'Sales Rep', '2006-02-12', 104, 350000.00, 367911.00),
       (109, 'Mary Jones', 31, 11, 'Sales Rep', '2007-10-12', 106, 300000.00, 392725.00),
       (102, 'Sue Smith', 48, 21, 'Sales Rep', '2004-12-10', 108, 350000.00, 474050.00),
       (106, 'Sam Clark', 52, 11, 'VP Sales', '2006-06-14', NULL, 275000.00, 299912.00),
       (110, 'Tom Snyder', 41, NULL, 'Sales Rep', '2008-01-13', 101, NULL, 75985.00),
       (103, 'Paul Cruz', 29, 12, 'Sales Rep', '2005-03-01', 104, 275000.00, 286775.00),
       (107, 'Nancy Angelli', 49, 22, 'Sales Rep', '2006-11-14', 108, 300000.00, 186042.00);


ALTER TABLE OFFICES
    ADD CONSTRAINT HASMGR FOREIGN KEY (MGR) REFERENCES SALESREPS (EMPL_NUM) ON DELETE SET NULL;

ALTER TABLE SALESREPS
    ADD CONSTRAINT REPORTSTO FOREIGN KEY (MANAGER) REFERENCES SALESREPS (EMPL_NUM) ON DELETE SET NULL;


INSERT INTO CUSTOMERS
    (CUST_NUM, COMPANY, CUST_REP, CREDIT_LIMIT)
VALUES (2111, 'JCP Inc.', 103, 50000.00),
       (2102, 'First Corp.', 101, 65000.00),
       (2103, 'Acme Mfg.', 105, 50000.00),
       (2123, 'Carter & Sons', 102, 40000.00),
       (2107, 'Ace International', 110, 35000.00),
       (2115, 'Smithson Corp.', 101, 20000.00),
       (2101, 'Jones Mfg.', 106, 65000.00),
       (2112, 'Zetacorp', 108, 50000.00),
       (2121, 'OMA Assoc.', 103, 45000.00),
       (2114, 'Orion Corp.', 102, 20000.00),
       (2124, 'Peter Brothers', 107, 40000.00),
       (2108, 'Holm & Landis', 109, 55000.00),
       (2117, 'J.P. Sinclair', 106, 35000.00),
       (2122, 'Three-Way Lines', 105, 30000.00),
       (2120, 'Rico Enterprises', 102, 50000.00),
       (2106, 'Fred Lewis Corp.', 102, 65000.00),
       (2119, 'Solomon Inc.', 109, 25000.00),
       (2118, 'Midwest Systems', 108, 60000.00),
       (2113, 'Ian & Schmidt', 104, 20000.00),
       (2109, 'Chen Associates', 103, 25000.00),
       (2105, 'AAA Investments', 101, 45000.00);


INSERT INTO PRODUCTS
    (MFR_ID, PRODUCT_ID, DESCRIPTION, PRICE, QTY_ON_HAND)
VALUES ('REI', '2A45C', 'Ratchet Link', 79.00, 210),
       ('ACI', '4100Y', 'Widget Remover', 2750.00, 25),
       ('QSA', 'Xk47', 'Reducer', 355.00, 38),
       ('BIC', '41672', 'Plate', 180.00, 0),
       ('IMM', '779C', '900-lb Brace', 1875.00, 9),
       ('ACI', '41003', 'Size 3 Widget', 107.00, 207),
       ('ACI', '41004', 'Size 4 Widget', 117.00, 139),
       ('BIC', '41003', 'Handle', 652.00, 3),
       ('IMM', '887P', 'Brace Pin', 250.00, 24),
       ('QSA', 'Xk48', 'Reducer', 134.00, 203),
       ('REI', '2A44L', 'Left Hinge', 4500.00, 12),
       ('FEA', '112', 'Housing', 148.00, 115),
       ('IMM', '887H', 'Brace Holder', 54.00, 223),
       ('BIC', '41089', 'Retainer', 225.00, 78),
       ('ACI', '41001', 'Size 1 widget', 55.00, 277),
       ('IMM', '775C', '500-lb Brace', 1425.00, 5),
       ('ACI', '4100z', 'Widget Installer', 2500.00, 28),
       ('QSA', 'XK48A', 'Reducer', 177.00, 37),
       ('ACI', '41002', 'Size 2 Widget', 76.00, 167),
       ('REI', '2A44R', 'Right Hinge', 4500.00, 12),
       ('IMM', '773C', '300-lb Brace', 975.00, 28),
       ('ACI', '4100X', 'Widget Adjuster', 25.00, 37),
       ('FEA', '114', 'Motor Mount', 243.00, 15),
       ('IMM', '887X', 'Brace Retainer', 475.00, 32),
       ('REI', '2A44G', 'Hinge Pin', 350.00, 14);


INSERT INTO ORDERS
    (ORDER_NUM, ORDER_DATE, CUST, REP, MFR, PRODUCT, QTY, AMOUNT)
VALUES (112961, '2007-12-17', 2117, 106, 'REI', '2A44L', 7, 31500.00),
       (113012, '2008-01-11', 2111, 105, 'ACI', '41003', 35, 3745.00),
       (112989, '2008-01-03', 2101, 106, 'FEA', '114X', 6, 1458.00),
       (113051, '2008-02-10', 2118, 108, 'QSA', 'Xk47', 2, 1420.00),
       (112968, '2007-10-12', 2102, 101, 'ACI', '41004', 34, 3978.00),
       (113036, '2008-01-30', 2107, 110, 'ACI', '4100z', 9, 22500.00),
       (113045, '2008-02-02', 2112, 108, 'REI', '2A44R', 10, 45000.00),
       (112963, '2007-12-17', 2103, 105, 'ACI', '41004', 28, 3276.00),
       (113013, '2008-01-14', 2118, 108, 'BIC', '41003', 1, 652.00),
       (113058, '2008-02-23', 2108, 109, 'FEA', '112', 10, 1480.00),
       (112997, '2008-01-08', 2124, 107, 'BIC', '41003', 1, 652.00),
       (112983, '2007-12-27', 2103, 105, 'ACI', '41004', 6, 702.00),
       (113024, '2008-01-20', 2114, 108, 'QSA', 'Xk47', 20, 7100.00),
       (113062, '2008-02-24', 2124, 107, 'FEA', '114', 10, 2430.00),
       (112979, '2007-10-12', 2114, 102, 'ACI', '4100z', 6, 15000.00),
       (113027, '2008-01-22', 2103, 105, 'ACI', '41002', 54, 4104.00),
       (113007, '2008-01-08', 2112, 108, 'IMM', '773C', 3, 2925.00),
       (113069, '2008-03-02', 2109, 107, 'IMM', '775C', 22, 31350.00),
       (113034, '2008-01-29', 2107, 110, 'REI', '2A45C', 8, 632.00),
       (112992, '2007-11-04', 2118, 108, 'ACI', '41002', 10, 760.00),
       (112975, '2007-10-12', 2111, 103, 'REI', '2A44G', 6, 2100.00),
       (113055, '2008-02-15', 2108, 101, 'ACI', '4100X', 6, 150.00),
       (113048, '2008-02-10', 2120, 102, 'IMM', '779C', 2, 3750.00),
       (112993, '2007-01-04', 2106, 102, 'REI', '2A45C', 24, 1896.00),
       (113065, '2008-02-27', 2106, 102, 'QSA', 'Xk47', 6, 2130.00),
       (113003, '2008-01-25', 2108, 109, 'IMM', '779C', 3, 5625.00),
       (113049, '2008-02-10', 2118, 108, 'QSA', 'Xk47', 2, 776.00),
       (112987, '2007-12-31', 2103, 105, 'ACI', '4100Y', 11, 27500.00),
       (113057, '2008-02-18', 2111, 103, 'ACI', '4100X', 24, 600.00),
       (113042, '2008-02-02', 2113, 101, 'REI', '2A44R', 5, 22500.00);
