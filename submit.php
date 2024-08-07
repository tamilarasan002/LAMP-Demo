<?php
// Database connection parameters
$host = '/cloudsql/studious-nature-396016:us-central1:postgres';
$db = 'postgres';
$user = 'postgres';
$pass = '12qwaszx';


// Create connection
$conn = pg_connect("host=$host dbname=$db user=$user password=$pass");

if (!$conn) {
    die("Connection failed: " . pg_last_error());
}

$name = $_POST['name'];
$email = $_POST['email'];

// Insert data into the database
$query = "INSERT INTO users (name, email) VALUES ($1, $2)";
$result = pg_query_params($conn, $query, array($name, $email));

if ($result) {
    echo "Details submitted successfully!";
} else {
    echo "Error: " . pg_last_error($conn);
}

// Close the connection
pg_close($conn);
?>
