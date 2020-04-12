# -*- coding: utf-8 -*-
# vim: ft=sls

    {%- if grains.os_family == 'MacOS' %}

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import rlang with context %}

rlang-macos-app-clean-files:
  file.absent:
    - names:
      - {{ rlang.dir.tmp }}
      - /Applications/R.app

    {%- else %}

rlang-macos-app-clean-unavailable:
  test.show_notification:
    - text: |
        The Rlang macpackage is only available on MacOS

    {%- endif %}
