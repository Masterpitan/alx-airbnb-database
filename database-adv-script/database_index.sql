-- Indexes for User table
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
