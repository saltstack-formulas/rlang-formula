# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import rlang with context %}

    {%- if grains.os_family == 'Debian' and rlang.pkg.use_upstream_repo %}

include:
  - .repo.clean

    {%- endif %} 
    {%- if grains.os_family == 'MacOS' %}

rlang-package-clean-cmd-run-homebrew:
  cmd.run:
    - name: brew remove {{ rlang.pkg.name }}
    - runas: {{ rlang.rootuser }}
    - onlyif: test -x /usr/local/bin/brew

    {%- else %}

rlang-package-clean-pkg-cleaned:
  pkg.cleaned:
    - name: {{ rlang.pkg.name }}
    - reload_modules: true

    {%- endif %}
