# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import rlang with context %}
{%- from tplroot ~ "/files/macros.jinja" import format_kwargs with context %}

rlang-package-repo-pkgrepo-managed:
  pkgrepo.managed:
    {{- format_kwargs(rlang.pkg.repo) }}
    - onlyif: {{ rlang.pkg.repo and rlang.pkg.use_upstream_repo }}
