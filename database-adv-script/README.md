The ![joins_queries](/database-adv-script/joins_queries.sql) codes present in this folder uses advanced SQL queries to join different tables.

### Inner Join Breakdown

In the inner join codes, I used bookings and users.
1. The booking was aliased as b while user was aliased as p

2. The join condition I used: b.user_id = user_id. This ,atches user_id by linking each booking to the user who made it.

3. The column I used were:
    - booking_id
    - start_date
    - end_date
    - total_price
    ### For user, I used:
    - user_id
    - email which was renamed as guest_email)
    - role

The logic for this inner join function now returns:
1. Only rows where the tables matched
2. Excluding bookings where there are no linked users

### LEFT JOIN Breakdown
1. For the left join code:
    - I included properties and reviews (including properties not reviewed yet)
    - This allows listing properties and their reviews (if available)

Tables used here are:
1. Property table (aliased as p)
2. Review Table (aliased as r)
2. The join function which I used is p.property_id = r.property_id
This links each property to its review

3. The columns I selected for left join:
    - property:
    - property_id
    - name (renamed as property_name)
    - price_per_night

    - Review:
    - review_id
    - rating
    - comment
My left join logic therefore returns the properties table regardless of review presence
Properties not reviewed displaay NULL in review columns

### Full Outer Join for All Users and Bookings
This is used to retrieve all users and all bookings (it does not matter if users have bookings or not)
1. I used the tables:
    - user (aliased - u)
    - booking (aliased - b)
2. My join condition:
    u-user_id = b.user_id
3. The Union Logic:
    **Query1**: Left Join gets all users and their bookings
    **Query2**: Right Join and WHERE find bookings with no linked user
    Results are merged and duplicates excluded
4. The columns I used are:
    - user_id
    - email
    - booking_id
    - start_date
5. Users who have no bookings scuh as the hosts who are yet to boo have NULL in booking fields
6. Bookings without valid users show NULL for user fields
