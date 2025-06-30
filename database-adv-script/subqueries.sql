-- Non-Correlated
SELECT p.property_id, p.name, p.price_per_night

FROM
    property p
WHERE
    p.property_id IN (
        -- Non-correlated subquery: Independent of outer query
        SELECT r.property_id
        FROM review r
        GROUP BY r.property_id
        HAVING AVG(r.rating) > 4.0
    )
ORDER BY
    p.price_per_night DESC;

-- Correlated Subquery

SELECT
    u.user_id,
    u.email,
    u.role
FROM
    user u
WHERE
    (
        -- Correlated subquery: Depends on outer query's u.user_id
        SELECT COUNT(*)
        FROM booking b
        WHERE b.user_id = u.user_id
    ) > 3
ORDER BY
    u.email;
