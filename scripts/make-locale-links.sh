#!/bin/bash
# Takes a directory with a checked-out mozilla tree, and
# makes symbolic links in a different directory, which make up the
# exact same structure as that of the localization directory tree (the
# l10n tree is not the same as the mozilla tree)
#
# Usage:
#     make-locale-links.sh source_dir dest_dir
#
# $1 source_dir
# $2 dest_dir

rm -fr $2
mkdir -p $2

# Browser
mkdir -p $2/en-US
ln -s $1/comm-central/mozilla/browser/locales/en-US $2/en-US/browser

# DOM
mkdir -p $2/en-US/dom
ln -s $1/comm-central/mozilla/dom/locales/en-US/chrome $2/en-US/dom/chrome

# Editor
mkdir -p $2/en-US/editor/ui
ln -s $1/comm-central/editor/ui/locales/en-US/chrome $2/en-US/editor/ui/chrome

# Extensions
mkdir -p $2/en-US/extensions
mkdir -p $2/en-US/extensions/cck
mkdir -p $2/en-US/extensions/cview
mkdir -p $2/en-US/extensions/signonviewer
mkdir -p $2/en-US/extensions/wallet

# ln -s $1/comm-central/extensions/cck/browser/locales/en-US $2/en-US/extensions/cck/browser
# ln -s $1/comm-central/extensions/cview/resources/locale/en-US $2/en-US/extensions/cview/resources
ln -s $1/comm-central/mozilla/extensions/irc/locales/en-US $2/en-US/extensions/irc
ln -s $1/comm-central/mozilla/extensions/metrics/locale/en-US $2/en-US/extensions/metrics
ln -s $1/comm-central/mozilla/extensions/reporter/locales/en-US $2/en-US/extensions/reporter
ln -s $1/comm-central/mozilla/extensions/spellcheck/locales/en-US $2/en-US/extensions/spellcheck
ln -s $1/comm-central/mozilla/extensions/venkman/locales/en-US $2/en-US/extensions/venkman

mkdir -p $2/en-US/extensions/wallet/editor
mkdir -p $2/en-US/extensions/wallet/src

ln -s $1/comm-central/mozilla/extensions/wallet/src/resources/locale/en-US $2/en-US/extensions/wallet/src/resources
ln -s $1/comm-central/mozilla/extensions/wallet/resources/locale/en-US $2/en-US/extensions/wallet/resources

# Mail
ln -s $1/comm-central/mail/locales/en-US $2/en-US/mail

# Netwerk
ln -s $1/comm-central/mozilla/netwerk/locales/en-US $2/en-US/netwerk

# Other-licenses
mkdir -p $2/en-US/other-licenses/branding

ln -s $1/comm-central/other-licenses/branding/thunderbird/locales/en-US $2/en-US/other-licenses/branding/thunderbird
ln -s $1/comm-central/mozilla/other-licenses/branding/firefox/locales/en-US $2/en-US/other-licenses/branding/firefox

# Security
mkdir -p $2/en-US/security
ln -s $1/comm-central/mozilla/security/manager/locales/en-US $2/en-US/security/manager

# Toolkit
ln -s $1/comm-central/mozilla/toolkit/locales/en-US $2/en-US/toolkit

# Fennec (mobile browser)
ln -s $1/mobile-browser/locales/en-US $2/en-US/mobile
