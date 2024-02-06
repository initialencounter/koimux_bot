#! /bin/bash
apt install chromium ffmpeg --fix-missing -y && apt autoremove -y && apt clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*