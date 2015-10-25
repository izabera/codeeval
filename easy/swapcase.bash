#!/bin/bash
mapfile lines < "$1"
printf %s "${lines[@]~~}"
