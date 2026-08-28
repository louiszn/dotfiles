#!/bin/sh

SOURCE_HOOK="$MODULE_DIR/20-ukigen"
KERNEL_HOOK_DIR="/etc/kernel.d/post-install"

LEGACY_HOOK="$KERNEL_HOOK_DIR/20-initramfs"
UKIGEN_HOOK="$KERNEL_HOOK_DIR/20-ukigen"

if [ ! -f "$SOURCE_HOOK" ]; then
    echo "error: hook not found: $SOURCE_HOOK" >&2
    exit 1
fi

if [ ! -d "$KERNEL_HOOK_DIR" ]; then
    echo "error: kernel hook directory not found: $KERNEL_HOOK_DIR" >&2
    exit 1
fi

sudo rm -f "$LEGACY_HOOK"
sudo install -m 755 "$SOURCE_HOOK" "$UKIGEN_HOOK"

echo "Installed kernel hook: $UKIGEN_HOOK"
echo 
echo "Note: to restore the default initramfs hook, symlink 20-initramfs" 
echo "to /usr/libexec/dracut/kernel-hook-postinst, then remove 20-ukigen:" 
echo 
echo "  sudo ln -s /usr/libexec/dracut/kernel-hook-postinst '$LEGACY_HOOK'" 
echo "  sudo rm -f '$UKIGEN_HOOK'"