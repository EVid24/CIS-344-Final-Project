private $host = "localhost";
private $port = "3306";
private $database = "restaurant_reservations";
private $user = "root";
private $password = "YourPassword";
public function addReservation($customerName, $reservationTime, $numberOfGuests, $specialRequests) {
    $stmt = $this->connection->prepare(
        "CALL addReservation(?, ?, ?, ?, ?)"
    );
    $stmt->bind_param("sssis", $customerName, $contactInfo, $reservationTime, $numberOfGuests, $specialRequests);
    $stmt->execute();
    $stmt->close();
    echo "Reservation successfully added!";
}
public function addCustomer($customerName, $contactInfo) {
    $stmt = $this->connection->prepare(
        "INSERT INTO Customers (customerName, contactInfo) VALUES (?, ?)"
    );
    $stmt->bind_param("ss", $customerName, $contactInfo);
    $stmt->execute();
    $stmt->close();
    echo "Customer added successfully!";
}
public function getCustomerPreferences($customerId) {
    $stmt = $this->connection->prepare(
        "SELECT * FROM DiningPreferences WHERE customerId = ?"
    );
    $stmt->bind_param("i", $customerId);
    $stmt->execute();
    $result = $stmt->get_result();
    return $result->fetch_all(MYSQLI_ASSOC);
}
public function addSpecialRequest($reservationId, $requests) {
    $stmt = $this->connection->prepare(
        "CALL addSpecialRequest(?, ?)"
    );
    $stmt->bind_param("is", $reservationId, $requests);
    $stmt->execute();
    $stmt->close();
    echo "Special request updated successfully!";
}
public function findReservations($customerId) {
    $stmt = $this->connection->prepare(
        "CALL findReservations(?)"
    );
    $stmt->bind_param("i", $customerId);
    $stmt->execute();
    $result = $stmt->get_result();
    return $result->fetch_all(MYSQLI_ASSOC);
}
public function deleteReservation($reservationId) {
    $stmt = $this->connection->prepare(
        "DELETE FROM Reservations WHERE reservationId = ?"
    );
    $stmt->bind_param("i", $reservationId);
    $stmt->execute();
    $stmt->close();
    echo "Reservation successfully deleted!";
}
public function searchPreferences($customerId) {
    $stmt = $this->connection->prepare(
        "SELECT * FROM DiningPreferences WHERE customerId = ?"
    );
    $stmt->bind_param("i", $customerId);
    $stmt->execute();
    $result = $stmt->get_result();
    return $result->fetch_all(MYSQLI_ASSOC);
}
