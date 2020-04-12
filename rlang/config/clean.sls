# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import rlang with context %}

{%- if 'config' in rlang and rlang.config %}

       {%- if rlang.pkg.use_upstream_macapp %}
              {%- set sls_package_clean = tplroot ~ '.macapp.clean' %}
       {%- else %}
              {%- set sls_package_clean = tplroot ~ '.package.clean' %}
       {%- endif %}
include:
  - {{ sls_package_clean }}

rlang-config-clean-file-absent:
  file.absent:
    - names:
      - {{ rlang.environ_file }}
    - require:
      - sls: {{ sls_package_clean }}

{%- endif %}
