# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import rlang with context %}

    {%- if grains.os_family == 'Debian' and rlang.pkg.use_upstream_repo %}

include:
  - .repo.clean

    {%- endif %}

rlang-package-clean-pkg-cleaned:
  pkg.removed:
    - name: {{ rlang.pkg.name }}
    - reload_modules: true
    - runas: {{ rlang.rootuser }}
