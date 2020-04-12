# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import rlang with context %}

include:
             {%- if grains.os_family in ('MacOS',) %}
  -{{ ' .macapp' if rlang.pkg.use_upstream_macapp else ' .package' }}.clean

             {%- else %}
  - .package.clean
  - .config.clean

             {%- endif %}
