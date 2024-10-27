{% macro count_event_types(table_alias, event_column) %}
    {%- set event_types = ['page_view', 'add_to_cart', 'checkout', 'package_shipped'] -%}
    {%- for event_type in event_types -%}
        {{ sum_event_types(table_alias ~ '.' ~ event_column, event_type) }} as {{ event_type }}
        {% if not loop.last %}, {% endif %}
    {%- endfor -%}
{% endmacro %}
