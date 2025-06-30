-- 1. Inner Join
SELECT b.booking_id, b.start_date, b.end_date,
    b.total_price, u.user_id, u.email AS guest_email, u.role
FROM
    booking b
INNER JOIN
    user u ON b.user_id = u.user_id;

-- 2. Left Join
SELECT
    p.property_id,
    p.name AS property_name,
    p.price_per_night,
    r.review_id,
    r.rating,
    r.comment
FROM
    property p
LEFT JOIN
    review r ON p.property_id = r.property_id;
ORDER BY
    p.price_per_night ASC;

-- Full Outer Join
SELECT
    u.user_id,
    u.email,
    b.booking_id,
    b.start_date
FROM
    user u
FULL OUTER JOIN
    booking b ON u.user_id = b.user_id
LEFT JOIN
    booking b ON u.user_id = b.user_id

UNION

SELECT
    u.user_id,
    u.email,
    b.booking_id,
    b.start_date
FROM
    user u
RIGHT JOIN
    booking b ON u.user_id = b.user_id
WHERE
    u.user_id IS NULL;
