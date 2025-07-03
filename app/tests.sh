#!/bin/bash
echo "Running basic HTML test..."
grep -q "<title>" ./app/index.html && echo "Test Passed" || exit 1
