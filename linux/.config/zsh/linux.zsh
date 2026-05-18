# Start keychain and load your SSH key
#
# This allows to enter the SSH key passphrase only once, up until the next
# reboot.

# if [[ -r /usr/bin/keychain ]]; then
#     /usr/bin/keychain --eval --quiet ~/.ssh/id_ed25519
#     source ~/.keychain/${HOSTNAME}-sh
# fi


# Make sure `sbin` directories are in the path to use with sudo
path=(
  $path
  /usr/sbin(N)
  /sbin(N)
)
