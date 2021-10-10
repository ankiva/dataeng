{% snapshot actormovieprices_snapshot %}

{{
        config(
                target_database='dellstore',
                target_schema='public',
                strategy='check',
                unique_key='firstname',
                check_cols=['number_of_movies', 'sum_of_price']
        )
}}

select * from {{source('dellstore_dataset', 'task1')}}

{% endsnapshot %}
