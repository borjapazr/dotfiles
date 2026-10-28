#!/usr/bin/env zsh
# Patch:   zimfw/input × Orca terminal shell wrapper
# Symptom: "_start_application_mode:1: command not found: __orca_deferred_line_init"
# Cause:   zimfw/input inlines the previous zle-line-init function by name. Orca
#          unfunctions that hook once no widget is bound to it, leaving a dangling call.
# Remove:  when Orca keeps hooks referenced by name, or zimfw/input chains widgets.

if [[ ${functions[_start_application_mode]-} == *__orca_deferred_line_init* ]]; then
  functions[_start_application_mode]=${functions[_start_application_mode]/__orca_deferred_line_init/(( \${+functions[__orca_deferred_line_init]} )) && __orca_deferred_line_init}
fi
