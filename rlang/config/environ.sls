# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import rlang with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

{%- if rlang.environ or rlang.config.path %}

       {%- if rlang.pkg.use_upstream_macapp %}
           {%- set sls_package_install = tplroot ~ '.macapp.install' %}
       {%- else %}
           {%- set sls_package_install = tplroot ~ '.package.install' %}
       {%- endif %}
include:
  - {{ sls_package_install }}

rlang-config-file-managed-environ_file:
  file.managed:
    - name: {{ rlang.environ_file }}
    - source: {{ files_switch(['environ.sh.jinja'],
                              lookup='rlang-config-file-managed-environ_file'
                 )
              }}
    - mode: 640
    - user: {{ rlang.rootuser }}
    - group: {{ rlang.rootgroup }}
    - makedirs: True
    - template: jinja
    - context:
        environ: {{ rlang.environ|json }}
    - require:
      - sls: {{ sls_package_install }}

{%- endif %}
