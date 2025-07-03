-- 1. Create partitioned table structure
CREATE TABLE booking_partitioned (
    booking_id UUID PRIMARY KEY,
    user_id UUID NOT NULL,
    property_id UUID NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES "user"(user_id),
    FOREIGN KEY (property_id) REFERENCES property(property_id)
) PARTITION BY RANGE (start_date);

-- 2. Create partitions by year
CREATE TABLE booking_y2022 PARTITION OF booking_partitioned
    FOR VALUES FROM ('2022-01-01') TO ('2023-01-01');

CREATE TABLE booking_y2023 PARTITION OF booking_partitioned
    FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');

CREATE TABLE booking_y2024 PARTITION OF booking_partitioned
    FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

-- 3. Create default partition for future dates
CREATE TABLE booking_future PARTITION OF booking_partitioned
    FOR VALUES FROM ('2025-01-01') TO (MAXVALUE);

-- 4. Migrate data from original table
INSERT INTO booking_partitioned
SELECT * FROM booking;

-- 5. Create indexes on partitioned table
CREATE INDEX idx_booking_partitioned_user ON booking_partitioned(user_id);
CREATE INDEX idx_booking_partitioned_property ON booking_partitioned(property_id);
CREATE INDEX idx_booking_partitioned_dates ON booking_partitioned(start_date, end_date);

-- PERFORMANCE TESTING QUERIES

-- Query on original table
EXPLAIN ANALYZE
SELECT * FROM booking
WHERE start_date BETWEEN '2023-06-01' AND '2023-06-30';

-- Query on partitioned table
EXPLAIN ANALYZE
SELECT * FROM booking_partitioned
WHERE start_date BETWEEN '2023-06-01' AND '2023-06-30';
