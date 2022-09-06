# firefox sandbox ecaping...
noblacklist ~/.mozilla
whitelist ~/.mozilla/firefox/profiles.ini
read-only ~/.mozilla/firefox/profiles.ini
ignore dbus-user none
dbus-user.talk org.mozilla.firefox.*
dbus-user.talk org.mozilla.firefox_esr.*
