-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';


-- ---------------------------------------------------------------------------------------
--                                         SCHEMA                                       --
-- ---------------------------------------------------------------------------------------

-- -----------------------------------------------------
--                  Schema jogo bonito                --
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `jb` DEFAULT CHARACTER SET utf8mb4 ;

-- -----------------------------------------------------
--                  Select Schema jb                  --
-- -----------------------------------------------------
USE `jb` ;

-- ---------------------------------------------------------------------------------------
--                                   CREATE TABLES                                      --
-- ---------------------------------------------------------------------------------------

-- -----------------------------------------------------
--              Table `jb`.`Location`                 --
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jb`.`Location` (
  `ID_Location` INT NOT NULL UNIQUE,
  `District` VARCHAR(20) NULL,
  `City` VARCHAR(20) NULL,
  `ZIP_Store` INT NULL)
ENGINE = InnoDB;


-- -----------------------------------------------------
--                Table `jb`.`Stores`                 --
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jb`.`Stores` (
  `ID_Store` INT NOT NULL UNIQUE,
  `ID_Location` INT NOT NULL,
  PRIMARY KEY (`ID_Store`),
  CONSTRAINT `fk_store_location`
    FOREIGN KEY (`ID_Location`)
    REFERENCES `jb`.`Location` (`ID_Location`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
--               Table `jb`.`Employees`               --
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jb`.`Employees` (
  `ID_Employee` INT NOT NULL UNIQUE AUTO_INCREMENT,
  `First_Name` VARCHAR(15) NOT NULL,
  `Last_Name` VARCHAR(15) NOT NULL,
  `ID_Store` INT NOT NULL,
  `Seniority` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`ID_Employee`),
  CONSTRAINT `fk_employee_store`
    FOREIGN KEY (`ID_Store`)
    REFERENCES `jb`.`Stores` (`ID_Store`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
--                Table `jb`.`Customers`              --
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jb`.`Customers` (
  `ID_Customer` INT NOT NULL AUTO_INCREMENT UNIQUE,
  `First_Name` VARCHAR(15) NULL,
  `Last_Name` VARCHAR(15) NULL,
  `Address` VARCHAR(100) NULL,
  `City` VARCHAR(50) NULL,
  `ZIP_Customer` INT NULL,
  `Phone` INT NULL UNIQUE,
  `Email` VARCHAR(50) NULL UNIQUE,
   PRIMARY KEY (`ID_Customer`))
ENGINE = InnoDB;


-- -----------------------------------------------------
--               Table `jb`.`Payment`                 --
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jb`.`Payment` (
  `ID_Payment` INT NOT NULL UNIQUE,
  `Payment_Type` VARCHAR(20) NULL,
  PRIMARY KEY (`ID_Payment`))
ENGINE = InnoDB;


-- -----------------------------------------------------
--               Table `jb`.`Suppliers`               --
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jb`.`Suppliers` (
  `ID_Supplier` INT NOT NULL UNIQUE,
  `Name_Supplier` VARCHAR(50) NOT NULL,
  `Address_Supplier` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`ID_Supplier`))
ENGINE = InnoDB;


-- -----------------------------------------------------
--             Table `jb`.`Categories`                --
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jb`.`Categories` (
  `ID_Category` INT NOT NULL UNIQUE,
  `Category` VARCHAR(20) NULL,
  PRIMARY KEY (`ID_Category`))
ENGINE = InnoDB;


-- -----------------------------------------------------
--                 Table `jb`.`Products`              --
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jb`.`Products` (
  `ID_Product` INT NOT NULL UNIQUE AUTO_INCREMENT,
  `Product_Name` VARCHAR(60) NULL,
  `ID_Category` INT NULL,
  `ID_Supplier` INT NULL,
  `Price` DECIMAL(10,2) NULL,
  `Stock` INT NULL,
  PRIMARY KEY (`ID_Product`),
  CONSTRAINT `fk_product_category`
    FOREIGN KEY (`ID_Category`)
    REFERENCES `jb`.`Categories` (`ID_Category`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
CONSTRAINT `fk_product_supplier`
    FOREIGN KEY (`ID_Supplier`)
    REFERENCES `jb`.`Suppliers` (`ID_Supplier`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
--               Table `jb`.`Cart`               --
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jb`.`Cart` (
  `ID` INT NOT NULL UNIQUE,
  `ID_Cart` INT NOT NULL,
  `ID_Product` INT NOT NULL,
  `Product_Rating` INT NOT NULL,
  PRIMARY KEY (`ID`),
  CONSTRAINT `fk_product_cart`
    FOREIGN KEY (`ID_Product`)
    REFERENCES `jb`.`Products` (`ID_Product`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
--            Table `jb`.`Transactions`               --
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jb`.`Transactions` (
  `ID_Transaction` INT NOT NULL UNIQUE AUTO_INCREMENT,
  `ID_Cart` INT NOT NULL,
  `ID_Employee` INT NULL,
  `ID_Customer` INT NULL,
  `ID_Payment` INT NULL,
  `Date` DATE NULL,
PRIMARY KEY (`ID_Transaction`),
CONSTRAINT `fk_transaction_cart`
    FOREIGN KEY (`ID_Cart`)
    REFERENCES `jb`.`Cart` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
CONSTRAINT `fk_transaction_employee`
    FOREIGN KEY (`ID_Employee`)
    REFERENCES `jb`.`Employees` (`ID_Employee`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
CONSTRAINT `fk_transaction_customer`
    FOREIGN KEY (`ID_Customer`)
    REFERENCES `jb`.`Customers` (`ID_Customer`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
CONSTRAINT `fk_transaction_payment`
    FOREIGN KEY (`ID_Payment`)
    REFERENCES `jb`.`Payment` (`ID_Payment`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)   
ENGINE = InnoDB;


-- -----------------------------------------------------
--               Table `jb`.`log`                 --
-- -----------------------------------------------------
Create Table IF NOT EXISTS jb.log (
	`ID_LOG` integer unsigned auto_increment Primary Key, 	
    `USR` varchar(30),
	`TS` datetime,
	`OLD_PRICE` DECIMAL(4,2),
    `NEW_PRICE` DECIMAL(4,2),
	`ID_PRODUCT` INT NULL)
ENGINE = InnoDB;


-- ---------------------------------------------------------------------------------------
--                                     INSERT DATA                                      --
-- ---------------------------------------------------------------------------------------

INSERT INTO `location` (`ID_Location`,`District`,`City`,`ZIP_Store` ) values
(1, 'Lisboa', 'Lisboa', '1000'),
(2, 'Lisboa', 'Cascais', '2750'),
(3, 'Lisboa', 'Mafra', '2640'),
(4, 'Lisboa', 'Amadora', '1500'),
(5, 'Lisboa', 'Lisboa', '1001'),
(6, 'Porto', 'Porto', '1800'),
(7, 'Porto', 'Porto', '4000'),
(8, 'Porto', 'Vila Nova de Gaia', '4400'),
(9, 'Porto', 'Maia', '4470');

INSERT INTO `stores` (`ID_Store`,`ID_Location`) values
(1, 1),
(2, 1),
(3, 7),
(4, 4),
(5, 7),
(6, 2),
(7, 2),
(8, 1),
(9, 2);

INSERT INTO `Employees` (`ID_Employee`,`First_Name`,`Last_Name`,`ID_Store`, `Seniority`) values
(1,'Laura','Barbosa',5,'Senior'),
(2,'Neuza','Gonçalves',9,'Senior'),
(3,'Yasmin','Costa',7,'Mid Senior'),
(4,'Samuel','Vaz',8,'Mid Senior'),
(5,'Mélanie','Neto',3,'Senior'),
(6,'Martinho','Neves',8,'Mid Senior'),
(7,'Valentim','Sousa',6,'Senior'),
(8,'Xavier','Campos',4,'Senior'),
(9,'Wanda','Neves',3,'Mid Senior'),
(10,'Soraia','Matias',2,'Junior'),
(11,'Bernardo','Carneiro',2,'Junior'),
(12,'Joaquim','Barbosa',7,'Junior'),
(13,'Joel','Valente',8,'Mid Senior'),
(14,'Isabel','Simões',2,'Junior'),
(15,'Jorge','Sousa',8,'Junior'),
(16,'Ema','Antunes',1,'Junior'),
(17,'Mariana','Soares',7,'Junior'),
(18,'William','Cruz',9,'Junior'),
(19,'Andreia','Silva',8,'Junior');

INSERT INTO `customers` (`ID_Customer`,`First_Name`, `Last_Name`, `Address`,`City`,`Zip_Customer`,`Phone`, `Email`) values
(1,'Robert','Robinson','P.O. Box 846 990 Vel Avenue','Portimao',13843,830-8740-66,'r.robinson@raproductsndatmail.com'),
(2,'Haris','Mitchell','P.O. Box 324 7759 Morbi Road','Lisboa',2888,704-5869-08,'h.mitchell@randatmail.com'),
(3,'Carina','Fowler','8265 Tincidunt Ave','Portimao',10102,408-6509-55,'c.fowler@randatmail.com'),
(4,'Chloe','Edwards','434-2177 Nunc St.','Lisboa',14364,257-8872-10,'c.edwards@randatmail.com'),
(5,'Sam','Williams','757-8389 Aliquam Av.','Guimaraes',13846,965-9027-05,'s.williams@randatmail.com'),
(6,'Alina','Clark','Ap #756-6626 Ornare St.','Porto',7131,909-4172-41,'a.clark@randatmail.com'),
(7,'Edgar','Stevens','182-6354 At Av.','Lisboa',10205,515-8633-33,'e.stevens@randatmail.com'),
(8,'Albert','Miller','929-6010 Nunc Rd.','Viseu',14687,309-8218-87,'a.miller@randatmail.com'),
(9,'Tiana','Allen','Ap #385-5511 In Ave','Faro',7122,710-3672-08,'t.allen@randatmail.com'),
(10,'Lucas','Jones','Ap #942-841 Scelerisque Rd.','Portimao',8694,456-1199-98,'l.jones@randatmail.com'),
(11,'Maddie','Anderson','P.O. Box 683 5593 Elit St.','Lisboa',4699,284-7649-58,'m.anderson@randatmail.com'),
(12,'Spike','Thomas','Ap #404-7578 Urna Avenue','Guimaraes',6343,561-7653-33,'s.thomas@randatmail.com'),
(13,'Vincent','Hawkins','Ap #577-7017 Lacus. Street','Lisboa',5952,719-3261-39,'v.hawkins@randatmail.com'),
(14,'Bruce','Baker','Ap #591-677 Praesent Av.','Lisboa',3021,551-5338-60,'b.baker@randatmail.com'),
(15,'Dale','Parker','Ap #530-506 Justo St.','Faro',9769,920-4887-48,'d.parker@randatmail.com'),
(16,'Mary','Mitchell','P.O. Box 396 262 Tincidunt St.','Viseu',14365,300-3337-25,'m.mitchell@randatmail.com'),
(17,'Tyler','Evans','Ap #209-3490 Sapien St.','Aveiro',3578,990-8169-71,'t.evans@randatmail.com'),
(18,'Martin','Hunt','7000 Tempus Road','Viseu',11674,332-5050-08,'m.hunt@randatmail.com'),
(19,'Jack','Barrett','4226 Magna. St.','Lisboa',13724,203-2631-39,'j.barrett@randatmail.com'),
(20,'Richard','Moore','8197 Blandit St.','Porto',6062,584-6888-06,'r.moore@randatmail.com'),
(21,'Rosie','Ferguson','P.O. Box 562 4949 Dolor Rd.','Portimao',4963,426-1605-77,'r.ferguson@randatmail.com'),
(22,'Audrey','Montgomery','702-3045 Ac Av.','Faro',8111,373-4268-23,'a.montgomery@randatmail.com'),
(23,'Brianna','Stevens','8153 Cubilia Avenue','Lisboa',5575,355-1282-68,'b.stevens@randatmail.com'),
(24,'James','Dixon','Ap #944-2735 Non Road','Aveiro',3506,577-9393-70,'j.dixon@randatmail.com'),
(25,'Sawyer','Montgomery','Ap #385-607 Ullamcorper Av.','Coimbra',3663,496-2803-06,'s.montgomery@randatmail.com'),
(26,'Camila','Walker','Ap #571-5933 Elit Ave','Lisboa',6397,864-7901-15,'c.walker@randatmail.com'),
(27,'Kevin','Perkins','1258 Vulputate Street','Portimao',5874,897-2191-69,'k.perkins@randatmail.com'),
(28,'Sam','Alexander','Ap #508-9856 Dui St.','Aveiro',13281,915-0259-71,'s.alexander@randatmail.com'),
(29,'Rosie','Montgomery','973-5621 Nunc Ave','Braga',8864,348-0071-87,'r.montgomery@randatmail.com'),
(30,'Audrey','Cooper','Ap #381-7315 Lacus. St.','Guimaraes',5836,722-8981-03,'a.cooper@randatmail.com'),
(31,'John','Davis','626-9916 Erat Road','Porto',8912,120-4592-66,'j.davis@randatmail.com'),
(32,'Ada','Parker','P.O. Box 369 3524 Donec St.','Lisboa',14724,743-8249-64,'a.parkers@randatmail.com'),
(33,'Martin','Owens','P.O. Box 789 7437 Fames Av.','Coimbra',9879,634-3721-61,'m.owens@randatmail.com'),
(34,'Paige','Murphy','Ap #760-1790 Pede Road','Porto',14194,553-4942-08,'p.murphy@randatmail.com'),
(35,'Natalie','Turner','998-4435 Sagittis Av.','Viseu',14200,625-6651-67,'n.turner@randatmail.com'),
(36,'Alissa','Anderson','Ap #776-593 Massa St.','Portimao',7516,010-8523-94,'a.anderson@randatmail.com'),
(37,'Violet','Reed','P.O. Box 306 8211 Luctus St.','Porto',10509,891-8232-55,'v.reed@randatmail.com'),
(38,'Bruce','Grant','780-2163 Cras Avenue','Lisboa',13492,977-3089-74,'b.grant@randatmail.com'),
(39,'Abraham','Carroll','P.O. Box 895 4408 Euismod Rd.','Coimbra',4570,500-4381-83,'a.carroll@randatmail.com'),
(40,'Deanna','Miller','Ap #240-8313 Eu Road','Guimaraes',10664,308-9694-04,'d.miller@randatmail.com'),
(41,'Bruce','Johnston','Ap #990-2768 Nulla. Ave','Funchal',13268,656-6192-48,'b.johnston@randatmail.com'),
(42,'Edgar','Lloyd','Ap #944-2756 Ipsum Ave','Lisboa',7563,765-4971-00,'e.lloyd@randatmail.com'),
(43,'Richard','Phillips','6415 Est. Rd.','Lisboa',11332,802-7274-08,'r.phillips@randatmail.com'),
(44,'Arnold','Morrison','P.O. Box 137 4244 Sagittis St.','Porto',10328,990-9514-31,'a.morrison@randatmail.com'),
(45,'Camila','Bennett','P.O. Box 397 358 Tellus Rd.','Lisboa',6707,893-2229-21,'c.bennett@randatmail.com'),
(46,'Ellia','Cole','300-5608 Proin Road','Viseu',13815,976-1904-76,'e.cole@randatmail.com'),
(47,'Edward','Henderson','Ap #586-6925 Sollicitudin Rd.','Guimaraes',12279,626-3907-71,'e.henderson@randatmail.com'),
(48,'Wilson','Robinson','3499 Eleifend St.','Braga',10222,801-4777-37,'w.robinson@randatmail.com'),
(49,'Abigail','Wilson','Ap #676-9414 Ut Street','Braga',11506,871-1132-94,'a.wilson@randatmail.com'),
(50,'Stella','Barrett','P.O. Box 797 2318 Sociis St.','Viseu',4296,587-2320-40,'s.barrett@randatmail.com');


INSERT INTO `Payment` (`ID_Payment`,`Payment_Type`) values
(1,'Cash'),
(2,'Credit'),
(3,'Debit');

INSERT INTO `Suppliers` (`ID_Supplier`,`Name_Supplier`,`Address_Supplier`) values
(1, 'Nintendo Iberica', 'Av. D. João II 1.12.02, Edifício Adamastor, Torre B, Piso 5C, 1990-077 Lisboa'),
(2, 'Microsoft Games', 'R. do Fogo de Santelmo 2.07.02, 1990-110 Lisboa'),
(3, 'Video Color Yamin', 'Av. Dom João II 36, 1998-017 Lisboa'),
(4, 'Sony Portugal', 'Edifício Atlantis, Av. Dom João II 44C Piso 6.4, 1990-095 Lisboa');

INSERT INTO `Categories` (`ID_Category`,`Category`) values
(1, 'Action'),
(2, 'Fighting'),
(3, 'Sandbox'),
(4, 'Plattform'),
(5, 'Racing'),
(6, 'Role-Playing'),
(7, 'Shooter'),
(8, 'Sports');

INSERT INTO `products` (`ID_Product`, `Product_Name`,`ID_Supplier`, `ID_Category`,`Price`, `Stock`) values
(1,'Call of Duty: Black Ops 3',3,7,60,40),
(2,'Grand Theft Auto V',3,1,63,77),
(3,'FIFA 16',3,8,57,60),
(4,'Star Wars Battlefront (2015)',4,7,41,73),
(5,'Call of Duty: Advanced Warfare',3,7,47,51),
(6,'Call of Duty: Black Ops 3',2,7,70,44),
(7,'Mario Kart 8',1,5,46,67),
(8,'Fallout 4',3,6,61,105),
(9,'FIFA 15',4,8,60,34),
(10,'Destiny',3,7,61,105),
(11,'New Super Mario Bros. U',3,4,62,94),
(12,'Call of Duty: Advanced Warfare',2,7,70,117),
(13,'Grand Theft Auto V',3,1,68,59),
(14,'Super Smash Bros. for Wii U and 3DS',2,2,60,63),
(15,'FIFA 17',1,8,53,141),
(16,'Splatoon',3,7,60,148),
(17,'The Last of Us',3,1,53,38),
(18,'Uncharted: The Nathan Drake Collection',1,1,46,85),
(19,'Nintendo Land',1,3,68,70),
(20,'Halo 5: Guardians',3,7,61,58),
(21,'Super Mario 3D World',3,4,49,118),
(22,'Uncharted 4: A Thief\'s End',3,7,59,71),
(23,'Watch Dogs',1,1,61,78),
(24,'Fallout 4',4,6,60,74),
(25,'Far Cry 4',3,7,63,107),
(26,'Minecraft',4,3,50,31),
(27,'Assassin\'s Creed: Unity',1,1,52,71),
(28,'NBA 2K16',2,8,54,143),
(29,'Batman: Arkham Knight',1,1,49,65),
(30,'The Witcher 3: Wild Hunt',2,6,51,82),
(31,'Call of Duty: Ghosts',2,7,56,72),
(32,'Tom Clancy\'s The Division',2,7,61,87),
(33,'Star Wars Battlefront (2015)',2,7,45,104),
(34,'Assassin\'s Creed: Unity',4,1,60,39),
(35,'Battlefield 4',3,7,55,89),
(36,'Metal Gear Solid V: The Phantom Pain',2,1,53,77),
(37,'Assassin\'s Creed Syndicate',3,1,52,119),
(38,'Destiny',3,7,53,56),
(39,'FIFA 16',1,8,65,102),
(40,'Madden NFL 16',4,8,66,58),
(41,'Super Mario Maker',2,4,54,114),
(42,'Halo: The Master Chief Collection',4,7,55,47),
(43,'Gears of War: Ultimate Edition',1,7,64,90),
(44,'Middle-Earth: Shadow of Mordor',2,1,53,127),
(45,'FIFA 14',2,8,66,31),
(46,'Titanfall',3,7,49,1141),
(47,'Call of Duty: Ghosts',2,7,45,55);



INSERT INTO `cart` (`ID`,`ID_Cart`,`ID_Product`,`Product_Rating`) values
(1,1,5,4),
(2,1,10,5),
(3,2,7,4),
(4,2,8,5),
(5,2,7,3),
(6,2,9,1),
(7,3,8,2),
(8,4,30,1),
(9,5,41,4),
(10,5,45,3),
(11,6,22,5),
(12,6,25,1),
(13,7,21,3),
(14,8,12,4),
(15,8,24,5),
(16,9,26,2),
(17,10,33,1),
(18,10,25,4),
(19,10,37,5),
(20,11,47,2),
(21,11,5,5),
(22,11,7,4),
(23,11,32,2),
(24,13,47,5),
(25,14,27,5),
(26,14,33,5),
(27,15,1,1),
(28,16,39,5),
(29,17,46,4),
(30,18,11,2),
(31,18,33,3),
(32,19,5,4),
(33,20,16,5),
(34,21,25,1),
(35,22,38,2),
(36,22,39,4),
(37,23,42,2),
(38,23,12,3),
(39,23,28,2),
(40,24,41,1),
(41,25,28,3),
(42,26,17,3),
(43,26,45,2),
(44,26,30,5),
(45,27,31,2),
(46,27,29,1),
(47,28,47,3),
(48,28,18,2),
(49,29,28,1),
(50,30,44,5);



INSERT INTO `transactions` (`ID_Transaction`,`ID_Cart`,`ID_Employee`,`ID_Customer`,`ID_Payment`,`Date`) values
(1,1,12,1,1,'2020-01-09'),
(2,2,12,2,3,'2020-01-12'),
(3,3,4,3,1,'2020-01-13'),
(4,4,6,4,1,'2020-02-27'),
(5,5,11,5,2,'2020-02-29'),
(6,6,4,6,1,'2020-03-06'),
(7,7,11,7,1,'2020-03-19'),
(8,8,13,8,3,'2020-04-03'),
(9,9,5,9,3,'2020-04-26'),
(10,10,1,51,1,'2020-05-08'),
(11,11,5,29,1,'2020-06-10'),
(12,12,12,14,1,'2020-06-28'),
(13,13,5,13,2,'2020-07-17'),
(14,14,4,14,1,'2020-07-31'),
(15,15,12,15,3,'2020-08-29'),
(16,16,15,16,3,'2020-09-09'),
(17,17,10,17,1,'2020-09-10'),
(18,18,7,18,3,'2020-09-27'),
(19,19,11,19,3,'2020-11-02'),
(20,20,11,20,2,'2020-11-23'),
(21,21,17,12,3,'2020-11-30'),
(22,22,18,7,3,'2020-12-14'),
(23,23,1,19,1,'2020-12-16'),
(24,24,16,1,3,'2020-12-21'),
(25,25,5,20,3,'2021-01-16'),
(26,26,13,45,2,'2021-02-18'),
(27,27,8,18,2,'2021-03-08'),
(28,28,14,40,3,'2021-03-15'),
(29,29,5,3,1,'2021-04-25'),
(30,30,4,31,1,'2021-05-01');




-- -----------------------------------------------------
-- Triggers 1
-- -----------------------------------------------------
DELIMITER $$
USE `jb`$$
CREATE TRIGGER jb.products_Update 
AFTER INSERT ON jb.transactions for each row
BEGIN
-- Statement one
    UPDATE jb.products p
       INNER JOIN Cart c
       INNER JOIN Transactions t 
       on t.ID_Cart = c.ID_Cart
        SET p.stock = p.stock - (SELECT  COUNT(c.ID_Product) From  jb.Cart c where c.ID_Cart = new.ID_Cart and p.ID_Product = c.ID_Product );
		#p.Num_Sales = p.Num_Sales + (SELECT  COUNT(c.ID_Product) From  jb.Cart c where c.ID_Cart = new.ID_Cart and p.ID_Product = c.ID_Product );
END$$
DELIMITER ;


-- -----------------------------------------------------
-- Triggers 2
-- -----------------------------------------------------
delimiter $$
create trigger update_price
after update
on PRODUCTS
for each row
Begin
	insert into log(TS, USR, ID_PRODUCT, OLD_PRICE, NEW_PRICE) values
    (now(), user(), NEW.ID_PRODUCT, OLD.PRICE, NEW.PRICE);
End $$
delimiter ;


/*
#Example for Trigger 1 (delete comment format)
select * from products;
INSERT INTO `Cart` (`ID`,`ID_Cart`,`ID_Product`,`Product_Rating`) values
(51,32,1, 3),


INSERT INTO `transactions` (`ID_Transaction`,`ID_Cart`,`ID_Employee`,`ID_Customer`,`ID_Payment`,`Date`) values
(31,32,4,31,1,'2021-05-01');
/*


 

/*Example for Trigger 2 (delete comment format)
UPDATE PRODUCTS 
SET Price = 40
WHERE ID_Product = 1;
*/


-- -----------------------------------------------------
-- View 1
-- -----------------------------------------------------
#View example for Invoice with ID = 5 if we wanted to change the invoice, we could replace the INVOICE_ID on the where clause:

create view INVOICE_1 as 
select t.ID_TRANSACTION, t.`DATE`, 
			CONCAT(c.FIRST_NAME,' ', c.LAST_NAME) as 'Customer Name', c.ADDRESS as 'Customer Address',
            c.CITY as 'Customer City', c.ZIP_Customer as 'ZIP Customer',
			l.CITY as 'City Store', l.district as District, 'Portugal' as Country, l.ZIP_Store as 'ZIP Store',
            'JogaBonito Lda' as 'Company Name', 'info@jogabonito.com' as Email,
            'www.jogabonito.net' as Website,
            SUM(p.Price) as 'INVOICE TOTAL'
from transactions t
	INNER JOIN employees e ON t.ID_Employee = e.ID_Employee
    INNER JOIN customers c ON t.ID_CUSTOMER  = c.ID_CUSTOMER
    INNER JOIN stores s ON e.ID_STORE  = s.ID_STORE
    INNER JOIN location l ON s.ID_LOCATION  = l.ID_LOCATION
    INNER JOIN cart ct ON t.ID_CART = ct.ID_CART
    INNER JOIN products p ON ct.ID_Product = p.ID_Product
where t.ID_TRANSACTION=5;


-- -----------------------------------------------------
-- View 2
-- -----------------------------------------------------
#View example for Invoice with ID = 5 if we wanted to change the invoice, we could replace the INVOICE_ID on the where clause:

CREATE VIEW INVOICE_2 as 
SELECT p.PRODUCT_NAME as "Product Name", ROUND(p.PRICE*0.77,2) as Subtotal, 
	   (0) as Discount, ROUND(p.PRICE*0.23,2) as Tax , p.PRICE as Total
FROM transactions t
	INNER JOIN cart ct ON t.ID_CART = ct.ID_CART
    INNER JOIN products p ON ct.ID_Product = p.ID_Product
where t.ID_TRANSACTION=5;



