### First Normal Form
Here, I have checked and ensured repeating groups are eliminated. No columns repeated and no changes needed

### Second Normal Form (2NF)
I have cheked to ensure no partial dependencies.
Tables have single-column Primary Keys (PK) which makes partial dependencies impossible
Therefore, all is compliant

### Third Normal Form (3NF)

Adjust Booking Table
- `total_price` could be derived from `Property.price_per_night` and date range (`end_date - start_date`).
- Remove `total_price` and **calculate it dynamically** in queries, for instance:
     ```sql
     SELECT
       (end_date - start_date) * price_per_night AS total_price
     FROM Booking
     JOIN Property ON Booking.property_id = Property.property_id;
     ```
