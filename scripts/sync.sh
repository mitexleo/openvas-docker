#!/usr/bin/env bash
# Sync the notus feed from the mitexleo feed server.
echo "Synchronizing the Notus feed from mitexleo Cybersecurity"
echo "And all others from the GB Community feed"
/usr/local/bin/greenbone-feed-sync --notus-url "rsync://rsync.mitexleo.com/feeds/notus/"  --verbose 