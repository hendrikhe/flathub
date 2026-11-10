#!/bin/sh
# Notebook com Intel/AMD + NVIDIA (driver do Flatpak): OpenGL da cor na NVIDIA (~3x mais rapido no 4K). Antes da JVM.
if [ -z "$DIVEPILOT_NO_GPU_SWITCH" ] && [ -e /dev/nvidia0 ]; then
  v=$(cat /sys/class/drm/card*/device/vendor 2>/dev/null | sort -u)
  if echo "$v" | grep -q 0x10de && echo "$v" | grep -qE '0x8086|0x1002'; then
    export __NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia __VK_LAYER_NV_optimus=NVIDIA_only
  fi
fi
export DIVEPILOT_GPU_RELAUNCHED=1
exec /app/opt/dive-astronaut/bin/DivePilot "$@"
