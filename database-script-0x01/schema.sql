-- The User Table
CREATE TABLE `user` (
    `user_id` CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    `first_name` VARCHAR(50) NOT NULL,
    `last_name` VARCHAR(50) NOT NULL,
    `email` VARCHAR(100) UNIQUE NOT NULL,
    `password_hash` VARCHAR(255) NOT NULL,
    `phone_number` VARCHAR(20),
    `role` ENUM('guest', 'host', 'admin') NOT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- The Property Table
CREATE TABLE `property` (
    `property_id` CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    `host_id` CHAR(36) NOT NULL,
    `name` VARCHAR(100) NOT NULL,
    `description` TEXT NOT NULL,
    `location` VARCHAR(100) NOT NULL,
    `price_per_night` DECIMAL(10, 2) NOT NULL CHECK (`price_per_night` > 0),
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (`host_id`) REFERENCES `user`(`user_id`)
);

-- The Booking Table
CREATE TABLE `booking` (
    `booking_id` CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    `property_id` CHAR(36) NOT NULL,
    `user_id` CHAR(36) NOT NULL,
    `start_date` DATE NOT NULL,
    `end_date` DATE NOT NULL,
    `total_price` DECIMAL(10, 2) NOT NULL CHECK (`total_price` > 0),
    `status` ENUM('pending', 'confirmed', 'canceled') NOT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CHECK (`end_date` > `start_date`),
    FOREIGN KEY (`property_id`) REFERENCES `property`(`property_id`),
    FOREIGN KEY (`user_id`) REFERENCES `user`(`user_id`)
);

-- The Payment Table
CREATE TABLE `payment` (
    `payment_id` CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    `booking_id` CHAR(36) NOT NULL UNIQUE,
    `amount` DECIMAL(10, 2) NOT NULL CHECK (`amount` > 0),
    `payment_date` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `payment_method` ENUM('credit_card', 'paypal', 'stripe') NOT NULL,
    FOREIGN KEY (`booking_id`) REFERENCES `booking`(`booking_id`)
);

-- The Review Table
CREATE TABLE `review` (
    `review_id` CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    `property_id` CHAR(36) NOT NULL,
    `user_id` CHAR(36) NOT NULL,
    `rating` TINYINT NOT NULL CHECK (`rating` BETWEEN 1 AND 5),
    `comment` TEXT NOT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (`property_id`) REFERENCES `property`(`property_id`),
    FOREIGN KEY (`user_id`) REFERENCES `user`(`user_id`)
);

-- The Message Table
CREATE TABLE `message` (
    `message_id` CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    `sender_id` CHAR(36) NOT NULL,
    `recipient_id` CHAR(36) NOT NULL,
    `message_body` TEXT NOT NULL,
    `sent_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CHECK (`sender_id` != `recipient_id`),
    FOREIGN KEY (`sender_id`) REFERENCES `user`(`user_id`),
    FOREIGN KEY (`recipient_id`) REFERENCES `user`(`user_id`)
);

-- Indexes for Performance Optimization
CREATE INDEX `idx_user_email` ON `user`(`email`);
CREATE INDEX `idx_property_host` ON `property`(`host_id`);
CREATE INDEX `idx_property_location` ON `property`(`location`);
CREATE INDEX `idx_booking_property` ON `booking`(`property_id`);
CREATE INDEX `idx_booking_user` ON `booking`(`user_id`);
CREATE INDEX `idx_booking_dates` ON `booking`(`start_date`, `end_date`);
CREATE INDEX `idx_review_property` ON `review`(`property_id`);
CREATE INDEX `idx_message_participants` ON `message`(`sender_id`, `recipient_id`);
