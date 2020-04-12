# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import rlang with context %}

    {%- if grains.os_family == 'Debian' and rlang.pkg.use_upstream_repo %}

include:
  - .repo

    {%- endif %} 
    {%- if grains.os_family == 'MacOS' %}

rlang-package-install-cmd-run-homebrew:
  cmd.run:
    - name: brew install {{ rlang.pkg.name }}
    - runas: {{ rlang.rootuser }}
    - onlyif: test -x /usr/local/bin/brew

    {%- else %}

rlang-package-install-pkg-installed:
  pkg.installed:
    - name: {{ rlang.pkg.name }}
    - reload_modules: true

    {%- endif %}
