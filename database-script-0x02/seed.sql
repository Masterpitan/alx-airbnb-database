-- Sample Data for Airbnb Clone Database

-- 1. Users (4 users: 2 hosts, 1 guest, 1 admin)
INSERT INTO `user` (`user_id`, `first_name`, `last_name`, `email`, `password_hash`, `phone_number`, `role`, `created_at`) VALUES
-- Hosts
(UUID_TO_BIN(UUID()), 'Adepitan', 'Adetunji', 'adepitan.cinqa@gmail.com', '$2a$10$xJwL5vxJZzO7rUfVQhT5NuR9z7JGbJXvLcJg7K8mYbW1dL2kZs5aG', '+2348165943407', 'host', '2025-07-15 09:30:00'),
(UUID_TO_BIN(UUID()), 'Kolade', 'Ayinde', 'koladeayinde@gmail.com', '$2a$10$yH9eL3vRqKjT7rFfVQhT5NuR9z7JGbJXvLcJg7K8mYbW1dL2kZs5aG', '+2348101292199', 'host', '2025-07-16 14:15:00'),
-- Guest
(UUID_TO_BIN(UUID()), 'Maryam', 'Adelayo', 'maryamadelayo@gmail.com', '$2a$10$zJwL5vxJZzO7rUfVQhT5NuR9z7JGbJXvLcJg7K8mYbW1dL2kZs5aG', '+2348160033932', 'guest', '2025-07-17 11:00:00'),
-- Admin
(UUID_TO_BIN(UUID()), 'Admin', 'User', 'admin@example.com', '$2a$10$aJwL5vxJZzO7rUfVQhT5NuR9z7JGbJXvLcJg7K8mYbW1dL2kZs5aG', '+15554567890', 'admin', '2023-01-01 00:00:00');

-- 2. Properties (3 properties by the hosts)
INSERT INTO `property` (`property_id`, `host_id`, `name`, `description`, `location`, `price_per_night`, `created_at`) VALUES
-- Adepitan's properties
(
  UUID_TO_BIN(UUID()),
  (SELECT `user_id` FROM `user` WHERE `email` = 'adepitan.cinqa@gmail.com'),
  'Premium Stars Apartment',
  'A rustic cabin with stunning mountain views. Perfect for nature lovers.',
  'Bodija, Ibadan',
  175.00,
  '2025-07-15 10:00:00'
),
(
  UUID_TO_BIN(UUID()),
  (SELECT `user_id` FROM `user` WHERE `email` = 'adepitan.cinqa@gmail.com'),
  'Downtown Loft',
  'Modern loft in the heart of the city with rooftop access.',
  'Denver, Colorado',
  225.00,
  '2025-07-12 16:30:00'
),
-- Kolade's property
(
  UUID_TO_BIN(UUID()),
  (SELECT `user_id` FROM `user` WHERE `email` = 'koladeayinde@gmail.com'),
  'Beachfront Villa',
  'Luxury villa with private beach access and infinity pool.',
  'Miami, Florida',
  450.00,
  '2023-02-25 12:00:00'
);

-- 3. Bookings (2 confirmed, 1 pending, 1 canceled)
INSERT INTO `booking` (`booking_id`, `property_id`, `user_id`, `start_date`, `end_date`, `total_price`, `status`, `created_at`) VALUES
-- Maryam's bookings
(
  UUID_TO_BIN(UUID()),
  (SELECT `property_id` FROM `property` WHERE `name` = 'Cozy Mountain Cabin'),
  (SELECT `user_id` FROM `user` WHERE `email` = 'maryamadelayo@gmail.com'),
  '2025-07-15',
  '2025-07-20',
  875.00, -- 5 nights * $175
  'confirmed',
  '2023-04-10 08:45:00'
),
(
  UUID_TO_BIN(UUID()),
  (SELECT `property_id` FROM `property` WHERE `name` = 'Beachfront Villa'),
  (SELECT `user_id` FROM `user` WHERE `email` = 'maryamadelayo@gmail.com'),
  '2023-07-10',
  '2023-07-17',
  3150.00, -- 7 nights * $450
  'pending',
  '2023-05-01 14:20:00'
),
-- 4. Payments (for confirmed bookings)
INSERT INTO `payment` (`payment_id`, `booking_id`, `amount`, `payment_method`, `payment_date`) VALUES
(
  UUID_TO_BIN(UUID()),
  (SELECT `booking_id` FROM `booking` WHERE `status` = 'confirmed' LIMIT 1),
  875.00,
  'credit_card',
  '2023-04-10 09:00:00'
);

-- 5. Reviews (for completed stays)
INSERT INTO `review` (`review_id`, `property_id`, `user_id`, `rating`, `comment`, `created_at`) VALUES
(
  UUID_TO_BIN(UUID()),
  (SELECT `property_id` FROM `property` WHERE `name` = 'Cozy Mountain Cabin'),
  (SELECT `user_id` FROM `user` WHERE `email` = 'maryamadelayo@gmail.com'),
  5,
  'Absolutely magical! The cabin had everything we needed and the views were breathtaking.',
  '2023-06-21 10:30:00'
);

-- 6. Messages (host-guest communication)
INSERT INTO `message` (`message_id`, `sender_id`, `recipient_id`, `message_body`, `sent_at`) VALUES
(
  UUID_TO_BIN(UUID()),
  (SELECT `user_id` FROM `user` WHERE `email` = 'maryamadelayo@gmail.com'),
  (SELECT `user_id` FROM `user` WHERE `email` = 'adepitan.cinqa@gmail.com'),
  'Hi Sarah! Is the cabin pet-friendly? We have a small well-behaved dog.',
  '2023-04-05 15:22:00'
),
(
  UUID_TO_BIN(UUID()),
  (SELECT `user_id` FROM `user` WHERE `email` = 'adepitan.cinqa@gmail.com'),
  (SELECT `user_id` FROM `user` WHERE `email` = 'maryamadelayo@gmail.com'),
  'Hi Emma! Yes, we allow pets for a small $50 cleaning fee.',
  '2023-04-05 16:45:00'
);
