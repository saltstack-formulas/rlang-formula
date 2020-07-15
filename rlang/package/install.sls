# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import rlang with context %}

        {%- if grains.os_family == 'Debian' and rlang.pkg.use_upstream_repo %}
include:
  - .repo
        {%- endif %}
        {%- if grains.os_family == 'RedHat' %}
rlang-package-install-redhat-enable-powertools:
  cmd.run:
    - name: (test -f /usr/bin/dnf && dnf config-manager --enable PowerTools) || true
    - onlyif: {{ 'osfinger' in grains and grains.osfinger == 'CentOS Linux-8' }}
        {%- endif %}
        {%- if 'deps' in rlang.pkg and rlang.pkg.deps %}

rlang-package-install-pkg-deps-installed:
  pkg.installed:
    - names: {{ rlang.pkg.deps|json }}
    - reload_modules: true
    - runas: {{ rlang.rootuser }}

        {%- endif %}

rlang-package-install-pkg-installed:
  pkg.installed:
    - name: {{ rlang.pkg.name }}
    - reload_modules: true
    - runas: {{ rlang.rootuser }}
