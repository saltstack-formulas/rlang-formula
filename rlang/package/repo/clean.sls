# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import rlang with context %}

rlang-package-repo-pkgrepo-absent:
  pkgrepo.absent:
    - name: {{ rlang.pkg.repo.name }}
    - onlyif: {{ rlang.pkg.repo and rlang.pkg.use_upstream_repo }}
