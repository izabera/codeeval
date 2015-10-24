#!/bin/bash
mapfile -t nums < "$1"
IFS=+
echo "$((${nums[*]}))"
