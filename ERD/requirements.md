1. Identifying Entities and their Attributes

| Entity |  Attributes  |
|:-----|:--------:|
| User   | user_id (PK), email (UQ), role, password_hash, created_at |
| Property   |  property_id (PK), host_id (FK→User), name, price_per_night, location  |
| Booking   | booking_id (PK), property_id (FK→Property), user_id (FK→User), dates |
| Payment   | payment_id (PK), booking_id (FK→Booking), amount, payment_method  |
| Review    | review_id (PK), property_id (FK→Property), user_id (FK→User), rating  |
| Message   | message_id (PK), sender_id/recipient_id (FK→User), message_body  |

2. Relationships
    - User to Property relationship: A user can own as many propterties as possible (one to many relationship)
    - User to Booking Relationship: A user can also have many bookings (one to many relationship)
    - Property to Booking Relationship: One property can have many bookings (One to many relationship)
    - Booking to Payment Relationship: Only one booking to one payment (one to one relationship)
    - Property to Review Relationship: One property can get as many reviews as possible (one to many relationship)
    - User to Message Relationship: Users can you send message feature to send and receive messages. A user can send many messages (one to many relationship)

3. Visual Representation of ER Diagram
![ER-DIAGRAM](images/ER%20Diagram.png)
