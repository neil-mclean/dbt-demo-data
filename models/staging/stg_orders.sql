
with 

source as (

    select * from {{ source('ecommerce', 'orders') }}

    --- truncate timespan to desired range, current time as default
    where ordered_at <= {{ var('truncate_timespan_to') }}

),

renamed as (

    select

        ----------  ids
        id as order_id,
        location_id,
        customer_id,

        ---------- properties
        (order_total / 100.0)::float as order_total,
        (tax_paid / 100.0)::float as tax_paid,

        ---------- timestamps
        ordered_at

    from source

)

select * from renamed
