#!/bin/bash
echo "Running basic HTML test..."
grep -q "<title>" index.html && echo "Test Passed" || exit 1
