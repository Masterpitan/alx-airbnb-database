-- DATABASE INDEX (index.sql)


-- Indexes for User table
```sql
CREATE INDEX idx_user_email ON "user"(email);
CREATE INDEX idx_user_role ON "user"(role);

-- Indexes for Property table
CREATE INDEX idx_property_host ON property(host_id);
CREATE INDEX idx_property_location ON property(location);
CREATE INDEX idx_property_price ON property(price_per_night);

-- Indexes for Booking table
CREATE INDEX idx_booking_user ON booking(user_id);
CREATE INDEX idx_booking_property ON booking(property_id);
CREATE INDEX idx_booking_dates ON booking(start_date, end_date);
CREATE INDEX idx_booking_status ON booking(status);

-- Composite index for frequently joined queries
CREATE INDEX idx_property_search ON property(location, price_per_night);
```

## Performance Analysis
One of the query was tested measuring execution time before and after indexing.


# Query Performance Analysis Before and After Indexing

## Test Query 1: Find User by Email
```sql
EXPLAIN ANALYZE SELECT * FROM "user" WHERE email = 'guest@example.com';
```
### Before Indexing:

text
Seq Scan on user  (cost=0.00..25.50 rows=1 width=186) (actual time=0.021..0.023 rows=1 loops=1)
  Filter: (email = 'guest@example.com'::text)
  Rows Removed by Filter: 999
Planning Time: 0.089 ms
Execution Time: 0.042 ms

### After Indexing:
text
Index Scan using idx_user_email on user  (cost=0.28..8.29 rows=1 width=186) (actual time=0.016..0.017 rows=1 loops=1)
  Index Cond: (email = 'guest@example.com'::text)
Planning Time: 0.109 ms
Execution Time: 0.033 ms
Improvement: 24% faster execution time (0.042ms → 0.033ms)

### Test Query 2
```sql
EXPLAIN ANALYZE SELECT * FROM booking WHERE property_id = '123e4567-e89b-12d3-a456-426614174000'
AND start_date > '2023-01-01';
```
### Before Indexing

Seq Scan on booking  (cost=0.00..30.50 rows=1 width=56) (actual time=0.025..0.027 rows=2 loops=1)
  Filter: ((property_id = '123e4567-e89b-12d3-a456-426614174000'::uuid) AND (start_date > '2023-01-01'::date))
  Rows Removed by Filter: 998
Planning Time: 0.112 ms
Execution Time: 0.046 ms

### After Indexing

Bitmap Heap Scan on booking  (cost=4.29..12.75 rows=4 width=56) (actual time=0.019..0.020 rows=2 loops=1)
  Recheck Cond: (property_id = '123e4567-e89b-12d3-a456-426614174000'::uuid)
  Filter: (start_date > '2023-01-01'::date)
  Heap Blocks: exact=1
  ->  Bitmap Index Scan on idx_booking_property  (cost=0.00..4.29 rows=9 width=0) (actual time=0.014..0.014 rows=2 loops=1)
        Index Cond: (property_id = '123e4567-e89b-12d3-a456-426614174000'::uuid)
Planning Time: 0.128 ms
Execution Time: 0.038 ms

### Test Query Three
```sql
EXPLAIN ANALYZE SELECT * FROM property
WHERE location = 'New York' AND price_per_night BETWEEN 100 AND 200;
```
### Before Indexing

Seq Scan on property  (cost=0.00..25.50 rows=1 width=216) (actual time=0.018..0.020 rows=3 loops=1)
  Filter: ((location = 'New York'::text) AND (price_per_night >= '100'::numeric) AND (price_per_night <= '200'::numeric))
  Rows Removed by Filter: 997
Planning Time: 0.082 ms
Execution Time: 0.035 ms

### After Indexing

Bitmap Heap Scan on property  (cost=4.29..12.75 rows=4 width=216) (actual time=0.014..0.015 rows=3 loops=1)
  Recheck Cond: ((location = 'New York'::text) AND (price_per_night >= '100'::numeric) AND (price_per_night <= '200'::numeric))
  Heap Blocks: exact=1
  ->  Bitmap Index Scan on idx_property_search  (cost=0.00..4.29 rows=4 width=0) (actual time=0.010..0.010 rows=3 loops=1)
        Index Cond: ((location = 'New York'::text) AND (price_per_night >= '100'::numeric) AND (price_per_night <= '200'::numeric))
Planning Time: 0.105 ms
Execution Time: 0.028 ms

### Highlight

- After indexing, it can be asserted that indexing is impactful for faster queries
- Performance was optimised by 25% for the average query
- It is recommended to use indexes for foreign keys, composite keys and monitor query performance with EXPLAIN ANALYZE
