CREATE DATABASE restaurant_reservations;
USE restaurant_reservations;
CREATE TABLE customers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    contact_info VARCHAR(255)
);
CREATE TABLE reservations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    customerId INT,
    reservationTime DATETIME,
    numberOfGuests INT,
    specialRequests TEXT,
    FOREIGN KEY (customerId) REFERENCES customers(id) ON DELETE CASCADE
);
CREATE TABLE customer_preferences (
    id INT AUTO_INCREMENT PRIMARY KEY,
    customerId INT,
    preference TEXT,
    FOREIGN KEY (customerId) REFERENCES customers(id) ON DELETE CASCADE
);

public function addCustomer($customerName, $contactInfo) {
    $stmt = $this->connection->prepare(
        "INSERT INTO customers (name, contact_info) VALUES (?, ?)"
    );
    $stmt->bind_param("ss", $customerName, $contactInfo);
    $stmt->execute();
    $stmt->close();
    echo "Customer added successfully";
}

<form method="POST" action="index.php?action=addCustomer">
    <label for="name">Customer Name:</label>
    <input type="text" name="name" required>
    <label for="contact_info">Contact Info:</label>
    <input type="text" name="contact_info" required>
    <button type="submit">Add Customer</button>
</form>

<form method="POST" action="index.php?action=addCustomer">
    <label for="name">Customer Name:</label>
    <input type="text" name="name" required>
    <label for="contact_info">Contact Info:</label>
    <input type="text" name="contact_info" required>
    <button type="submit">Add Customer</button>
</form>

public function getCustomerPreferences($customerId) {
    $stmt = $this->connection->prepare(
        "SELECT preference FROM customer_preferences WHERE customerId = ?"
    );
    $stmt->bind_param("i", $customerId);
    $stmt->execute();
    $result = $stmt->get_result();
    $preferences = $result->fetch_all(MYSQLI_ASSOC);
    $stmt->close();
    return $preferences;
}

public function updateCustomerPreference($customerId, $preference) {
    $stmt = $this->connection->prepare(
        "INSERT INTO customer_preferences (customerId, preference) VALUES (?, ?)"
    );
    $stmt->bind_param("is", $customerId, $preference);
    $stmt->execute();
    $stmt->close();
    echo "Preference updated successfully";
}

public function cancelReservation($reservationId) {
    $stmt = $this->connection->prepare(
        "DELETE FROM reservations WHERE id = ?"
    );
    $stmt->bind_param("i", $reservationId);
    $stmt->execute();
    $stmt->close();
    echo "Reservation cancelled successfully";
}

<a href="index.php?action=cancelReservation&id=<?= $reservation['id'] ?>">Cancel</a>

<h1>Welcome to Restaurant Management System</h1>
<ul>
    <li><a href="index.php?action=addCustomer">Add Customer</a></li>
    <li><a href="index.php?action=addReservation">Add Reservation</a></li>
    <li><a href="index.php?action=viewReservations">View Reservations</a></li>
</ul>

