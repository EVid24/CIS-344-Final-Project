
CREATE DATABASE restaurant_reservations;
USE restaurant_reservations;
CREATE TABLE Customers (
    customerId INT NOT NULL UNIQUE AUTO_INCREMENT,
    customerName VARCHAR(45) NOT NULL,
    contactInfo VARCHAR(200),
    PRIMARY KEY (customerId)
);
CREATE TABLE Reservations (
    reservationId INT NOT NULL UNIQUE AUTO_INCREMENT,
    customerId INT NOT NULL,
    reservationTime DATETIME NOT NULL,
    numberOfGuests INT NOT NULL,
    specialRequests VARCHAR(200),
    PRIMARY KEY (reservationId),
    FOREIGN KEY (customerId) REFERENCES Customers(customerId)
);
CREATE TABLE DiningPreferences (
    preferenceId INT NOT NULL UNIQUE AUTO_INCREMENT,
    customerId INT NOT NULL,
    favoriteTable VARCHAR(45),
    dietaryRestrictions VARCHAR(200),
    PRIMARY KEY (preferenceId),
    FOREIGN KEY (customerId) REFERENCES Customers(customerId)
);
INSERT INTO Customers (customerName, contactInfo) VALUES
('Alice Smith', 'alice@example.com'),
('Bob Johnson', 'bob@example.com'),
('Charlie Brown', 'charlie@example.com');

INSERT INTO Reservations (customerId, reservationTime, numberOfGuests, specialRequests) VALUES
(1, '2024-12-20 18:30:00', 4, 'Window seat'),
(2, '2024-12-21 19:00:00', 2, 'Allergic to peanuts'),
(3, '2024-12-22 20:00:00', 6, 'Celebration - Cake on table');

INSERT INTO DiningPreferences (customerId, favoriteTable, dietaryRestrictions) VALUES
(1, 'Table 5', 'Vegan'),
(2, 'Table 2', 'Nut-free'),
(3, 'Table 8', 'No shellfish');

-- Stored Procedures
DELIMITER //
CREATE PROCEDURE findReservations(IN customer INT)
BEGIN
    SELECT * FROM Reservations WHERE customerId = customer;
END //
DELIMITER ;
DELIMITER //
CREATE PROCEDURE addSpecialRequest(IN reservation INT, IN requests TEXT)
BEGIN
    UPDATE Reservations SET specialRequests = requests WHERE reservationId = reservation;
END //
DELIMITER ;
DELIMITER //
CREATE PROCEDURE addReservation(
    IN customerName VARCHAR(45),
    IN contactInfo VARCHAR(200),
    IN reservationTime DATETIME,
    IN numberOfGuests INT,
    IN specialRequests TEXT
)
BEGIN
    DECLARE customerId INT;
    SET customerId = (SELECT customerId FROM Customers WHERE customerName = customerName AND contactInfo = contactInfo);
    
    IF customerId IS NULL THEN
        INSERT INTO Customers (customerName, contactInfo) VALUES (customerName, contactInfo);
        SET customerId = LAST_INSERT_ID();
    END IF;

    INSERT INTO Reservations (customerId, reservationTime, numberOfGuests, specialRequests)
    VALUES (customerId, reservationTime, numberOfGuests, specialRequests);
END //
DELIMITER ;
