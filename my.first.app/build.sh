#!/bin/bash

set -Eev

json=my.first.App.json

# Ubuntu 18.04 LTS, flatpak 1.4.x and flatpak-builder 1.0.8 from PPA
# flatpak search org.freedesktop.Platform
# flatpak install flathub org.freedesktop.Platform//18.08 org.freedesktop.Sdk//18.08
rm -rf target repo
flatpak-builder target $json
flatpak-builder --run target $json hello.sh
flatpak-builder --repo=repo --force-clean target $json
flatpak --user remote-delete tutorial-repo || :
flatpak --user remote-add --no-gpg-verify tutorial-repo repo
flatpak --user install -y tutorial-repo ${json%.json}
flatpak run ${json%.json}
flatpak --user remove -y ${json%.json}
flatpak --user remote-delete tutorial-repo

