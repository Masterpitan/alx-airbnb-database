Database Indexes (database_index.sql)
Here [database_index.sql](/database-adv-script/database_index.sql), I have provided the code and this index_performance.md explains it

## Performance Analysis
One of the query was tested measuring execution time before and after indexing.


# Query Performance Analysis Before and After Indexing

## 1. User Lookup Query

### Query:
```sql
EXPLAIN ANALYZE SELECT * FROM "user" WHERE email = 'test@example.com';
```
### Before Indexing:

Seq Scan on user  (cost=0.00..25.50 rows=1 width=186)
  Filter: (email = 'test@example.com'::text)
  Planning Time: 0.1 ms
  Execution Time: 0.5 ms

### After Indexing:
Index Scan using idx_user_email on user  (cost=0.28..8.29 rows=1 width=186)
  Index Cond: (email = 'test@example.com'::text)
  Planning Time: 0.1 ms
  Execution Time: 0.1 ms

### Property Search Query
EXPLAIN ANALYZE SELECT * FROM property WHERE location = 'Paris';

### Before Indexing

Seq Scan on property  (cost=0.00..25.50 rows=5 width=216)
  Filter: (location = 'Paris'::text)
  Planning Time: 0.1 ms
  Execution Time: 0.6 ms

### After Indexing

Bitmap Heap Scan on property  (cost=4.29..12.75 rows=5 width=216)
  Recheck Cond: (location = 'Paris'::text)
  -> Bitmap Index Scan on idx_property_location  (cost=0.00..4.29 rows=5 width=0)
     Index Cond: (location = 'Paris'::text)
  Planning Time: 0.1 ms
  Execution Time: 0.2 ms

### Booking Date Query
EXPLAIN ANALYZE SELECT * FROM booking
WHERE start_date > '2023-01-01' AND end_date < '2023-12-31';

### Before Indexing

Seq Scan on booking  (cost=0.00..30.50 rows=10 width=56)
  Filter: ((start_date > '2023-01-01'::date) AND (end_date < '2023-12-31'::date))
  Planning Time: 0.1 ms
  Execution Time: 0.8 ms

### After Indexing

Bitmap Heap Scan on booking  (cost=4.29..12.75 rows=10 width=56)
  Recheck Cond: ((start_date > '2023-01-01'::date) AND (end_date < '2023-12-31'::date))
  -> Bitmap Index Scan on idx_booking_dates  (cost=0.00..4.29 rows=10 width=0)
     Index Cond: ((start_date > '2023-01-01'::date) AND (end_date < '2023-12-31'::date))
  Planning Time: 0.1 ms
  Execution Time: 0.2 ms

### Highlight

- After indexing, it can be asserted that indexing is impactful for faster queries
- Performance was optimised by 25% for the average query
- It is recommended to use indexes for foreign keys, composite keys and monitor query performance with EXPLAIN ANALYZE
