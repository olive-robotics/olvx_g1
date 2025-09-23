#!/usr/bin/env bash
set -euo pipefail

# Kill child processes on exit (e.g. Ctrl+C)
trap "kill 0" SIGINT SIGTERM EXIT

MAP_FILE=""

print_usage() {
  cat <<EOF
Usage: $(basename "$0") --map /path/to/map.yaml

--map   Path to a Nav2-compatible YAML map file (required)
EOF
}

# Parse args
while [[ $# -gt 0 ]]; do
  case "$1" in
    --map)
      MAP_FILE="${2:-}"; shift 2 ;;
    -h|--help)
      print_usage; exit 0 ;;
    *)
      echo "Unknown argument: $1"; print_usage; exit 1 ;;
  esac
done

if [[ -z "${MAP_FILE}" ]]; then
  echo "Error: no map provided. Use --map /path/to/map.yaml"
  exit 1
fi
if [[ ! -f "${MAP_FILE}" ]]; then
  echo "Error: map file not found: ${MAP_FILE}"
  exit 1
fi

echo "Launching navigation with map: ${MAP_FILE}"

# Start the navigation launch (in the foreground)
exec ros2 launch linorobot2_navigation navigation.launch.py \
  map:="${MAP_FILE}"

