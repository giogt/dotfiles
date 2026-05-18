# Start keychain and load your SSH key
if [[ -r /usr/bin/keychain ]]; then
    /usr/bin/keychain --eval --quiet ~/.ssh/id_ed25519
    source ~/.keychain/${HOSTNAME}-sh
fi
