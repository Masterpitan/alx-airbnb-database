-- Initial inefficient query
SELECT
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    p.property_id,
    p.name AS property_name,
    p.location,
    p.price_per_night,
    py.payment_id,
    py.payment_method,
    py.amount,
    py.payment_date
FROM
    booking b
JOIN
    user u ON b.user_id = u.user_id
JOIN
    property p ON b.property_id = p.property_id
LEFT JOIN
    payment py ON b.booking_id = py.booking_id
ORDER BY
    b.start_date DESC;

-- ANALYZE PERFORMANCE
-- Analyze the query performance
EXPLAIN ANALYZE
SELECT
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    p.property_id,
    p.name AS property_name,
    p.location,
    p.price_per_night,
    py.payment_id,
    py.payment_method,
    py.amount,
    py.payment_date
FROM
    booking b
JOIN
    user u ON b.user_id = u.user_id
JOIN
    property p ON b.property_id = p.property_id
LEFT JOIN
    payment py ON b.booking_id = py.booking_id
ORDER BY
    b.start_date DESC;

-- REFACTORED QUERY
SELECT
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    u.user_id,
    u.email,
    p.property_id,
    p.name AS property_name,
    p.location,
    py.payment_method,
    py.amount
FROM
    booking b
JOIN
    user u ON b.user_id = u.user_id
JOIN
    property p ON b.property_id = p.property_id
LEFT JOIN
    payment py ON b.booking_id = py.booking_id
WHERE
    b.start_date > CURRENT_DATE - INTERVAL '6 months'
ORDER BY
    b.start_date DESC
LIMIT 100;


-- INDEXES ADDED
CREATE INDEX idx_booking_user ON booking(user_id);
CREATE INDEX idx_booking_property ON booking(property_id);
CREATE INDEX idx_booking_start_date ON booking(start_date);
CREATE INDEX idx_payment_booking ON payment(booking_id);
