-- AGGREGATION WITH COUNT AND GROUP BY
SELECT
    u.user_id,
    u.email,
    u.role,
    COUNT(b.booking_id) AS total_bookings
FROM
    user u
LEFT JOIN
    booking b ON u.user_id = b.user_id
GROUP BY
    u.user_id, u.email, u.role
ORDER BY
    total_bookings DESC;


-- PROPERTY RANKING BY BOOKINGS

SELECT
    p.property_id,
    p.name,
    p.location,
    COUNT(b.booking_id) AS booking_count,
    RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS popularity_rank,
    ROW_NUMBER() OVER (ORDER BY COUNT(b.booking_id) DESC) AS row_num,
    DENSE_RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS dense_rank
FROM
    property p
LEFT JOIN
    booking b ON p.property_id = b.property_id
GROUP BY
    p.property_id, p.name, p.location
ORDER BY
    booking_count DESC;
