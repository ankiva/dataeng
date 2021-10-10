{{
        config(materialized="table")
}}

select split_part(actor, ' ', 1) as firstname, count(title) number_of_movies, sum(price) sum_of_price from {{source("dellstore_dataset", "products")}}
group by firstname
