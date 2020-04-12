# -*- coding: utf-8 -*-
# vim: ft=sls

  {%- if grains.os_family == 'MacOS' %}

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import rlang with context %}

rlang-macos-app-install-curl:
  file.directory:
    - name: {{ rlang.dir.tmp }}
    - makedirs: True
    - clean: True
  pkg.installed:
    - name: curl
  cmd.run:
    - name: curl -Lo {{ rlang.dir.tmp }}/rlang-{{ rlang.version }} {{ rlang.pkg.macapp.source }}
    - unless: test -f {{ rlang.dir.tmp }}/rlang-{{ rlang.version }}
    - require:
      - file: rlang-macos-app-install-curl
      - pkg: rlang-macos-app-install-curl
    - retry: {{ rlang.retry_option }}

      # Check the hash sum. If check fails remove
      # the file to trigger fresh download on rerun
rlang-macos-app-install-checksum:
  module.run:
    - onlyif: {{ rlang.pkg.macapp.source_hash }}
    - name: file.check_hash
    - path: {{ rlang.dir.tmp }}/rlang-{{ rlang.version }}
    - file_hash: {{ rlang.pkg.macapp.source_hash }}
    - require:
      - cmd: rlang-macos-app-install-curl
    - require_in:
      - macpackage: rlang-macos-app-install-macpackage
  file.absent:
    - name: {{ rlang.dir.tmp }}/rlang-{{ rlang.version }}
    - onfail:
      - module: rlang-macos-app-install-checksum

rlang-macos-app-install-macpackage:
  macpackage.installed:
    - name: {{ rlang.dir.tmp }}/rlang-{{ rlang.version }}
    - store: True
    - dmg: False
    - app: True
    - force: True
    - allow_untrusted: True
    - onchanges:
      - cmd: rlang-macos-app-install-curl

    {%- else %}

rlang-macos-app-install-unavailable:
  test.show_notification:
    - text: |
        The Rlang macpackage is only available on MacOS

    {%- endif %}
