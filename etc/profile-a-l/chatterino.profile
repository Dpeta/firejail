# Firejail profile for Chatterino
# Description: Chat client for https://twitch.tv
# This file is overwritten after every install/update
# Persistent local customizations
include chatterino.local
# Persistent global definitions
include globals.local

# Allow access to Chatterino config/logs
noblacklist ${HOME}/.local/share/chatterino
# Allow access to pulse config
noblacklist ${HOME}/.config/pulse
# Config folders for common media players for streamlink integration, VLC is the default.
noblacklist ${HOME}/.config/vlc
noblacklist ${HOME}/.config/aacs
noblacklist ${HOME}/.local/share/vlc
noblacklist ${HOME}/.config/mpv
# Image uploading and custom notification sounds require the path to the relevant files to be accessible.
#noblacklist ${HOME}/Pictures/
#noblacklist ${HOME}/Music/

# Allow Python for Streamlink integration (blacklisted by disable-interpreters.inc)
include allow-python3.inc

# Allow Lua for mpv (blacklisted by disable-interpreters.inc)
include allow-lua.inc

# disable-*.inc includes
include disable-common.inc
include disable-devel.inc
include disable-exec.inc
include disable-interpreters.inc
include disable-proc.inc
include disable-programs.inc
include disable-xdg.inc

# Allow access to Chatterino config/logs
mkdir ${HOME}/.local/share/chatterino
whitelist ${HOME}/.local/share/chatterino
# Allow access to pulse config
mkdir ${HOME}/.config/pulse
whitelist ${HOME}/.config/pulse
# Config folders for common media players for streamlink integration, VLC is the default.
mkdir ${HOME}/.config/vlc
mkdir ${HOME}/.config/aacs
mkdir ${HOME}/.local/share/vlc
mkdir ${HOME}/.config/mpv
whitelist ${HOME}/.config/vlc
whitelist ${HOME}/.config/aacs
whitelist ${HOME}/.local/share/vlc
whitelist ${HOME}/.config/mpv
# Allow access to desktop enviroment preferences/themes
include whitelist-common.inc
# Image uploading and custom notification sounds require the path to the relevant files to be accessible.
#whitelist ${HOME}/Pictures/
#whitelist ${HOME}/Music/

apparmor
caps.drop all
netfilter
nodvd
nogroups
nonewprivs
noprinters
noroot
notv
nou2f
# Netlink is required for streamlink integration.
protocol unix,inet,inet6,netlink
# Secomp may break browser integration.
seccomp
seccomp.block-secondary
shell none
tracelog

disable-mnt
# Add more private-bin lines for browsers or video players to chatterino.local if wanted.
private-bin chatterino,pgrep
private-bin streamlink,python*
private-bin mpv,env,python*,waf
private-bin cvlc,nvlc,qvlc,rvlc,svlc,vlc
# private-cache may cause issues with mpv (see #2838)
private-cache
private-dev
private-etc alternatives,ld.so.cache,ld.so.conf,ld.so.conf.d,ld.so.preload,locale,locale.alias,locale.conf,localtime,mime.types,xdg
private-etc group,magic,magic.mgc,passwd
private-etc bumblebee,drirc,glvnd,nvidia
private-etc alsa,asound.conf,machine-id,pulse
private-etc dbus-1,machine-id
private-etc fonts,pango,X11
private-etc dconf,gconf,gtk-2.0,gtk-3.0,gtk-4.0
private-etc kde4rc,kde5rc
private-etc ca-certificates,crypto-policies,host.conf,hostname,hosts,nsswitch.conf,pki,protocols,resolv.conf,rpc,services,ssl
private-etc Trolltech.conf
private-tmp

dbus-user filter
dbus-user.own com.chatterino.chatterino
dbus-user.own com.chatterino.chatterino.*
# Session Bus Policy from flatpak
dbus-user.talk com.canonical.AppMenu.Registrar
dbus-user.talk org.kde.kconfig.notify
dbus-user.talk org.kde.KGlobalSettings
dbus-user.talk org.freedesktop.Flatpak
# Allow notifications.
dbus-user.talk org.freedesktop.Notifications
# For media player integration.
dbus-user.talk org.freedesktop.ScreenSaver
?ALLOW_TRAY: dbus-user.talk org.kde.StatusNotifierWatcher
dbus-user.talk org.mpris.MediaPlayer2.Player
dbus-system none

# Prevents browsers/players from lingering after Chatterino is closed.
#deterministic-shutdown
# Add to chatterino.local to force Qt to use its wayland QPA plugin.
#env QT_QPA_PLATFORM=wayland
# memory-deny-write-execute may break streamlink and browser integration.
#memory-deny-write-execute
