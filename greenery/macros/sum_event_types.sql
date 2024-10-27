{% macro sum_event_types(event_column, event_type) %}
    sum(case when {{ event_column }} = '{{ event_type }}' then 1 else 0 end)
{% endmacro %}
