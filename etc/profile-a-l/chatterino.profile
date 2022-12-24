# Firejail profile for Chatterino
# Description: Chat client for https://twitch.tv
# This file is overwritten after every install/update
# Persistent local customizations
include chatterino.local
# Persistent global definitions
include globals.local

# Also allow access to mpv/vlc, they're usable via streamlink.
noblacklist ${HOME}/.cache/vlc
noblacklist ${HOME}/.config/aacs
noblacklist ${HOME}/.config/mpv
noblacklist ${HOME}/.config/pulse
noblacklist ${HOME}/.config/vlc
noblacklist ${HOME}/.local/share/chatterino
noblacklist ${HOME}/.local/share/vlc
# To upload images, whitelist/noblacklist their path in chatterino.local.
#noblacklist ${HOME}/Pictures/
# For custom notification sounds, whitelist/noblacklist their path in chatterino.local.
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

# Also allow access to mpv/vlc, they're usable via streamlink.
mkdir ${HOME}/.cache/vlc
mkdir ${HOME}/.config/aacs
mkdir ${HOME}/.config/mpv
mkdir ${HOME}/.config/pulse
mkdir ${HOME}/.config/vlc
mkdir ${HOME}/.local/share/chatterino
mkdir ${HOME}/.local/share/vlc
whitelist ${HOME}/.cache/vlc
whitelist ${HOME}/.config/aacs
whitelist ${HOME}/.config/mpv
whitelist ${HOME}/.config/pulse
whitelist ${HOME}/.config/vlc
whitelist ${HOME}/.local/share/chatterino
whitelist ${HOME}/.local/share/vlc
# To upload images, whitelist/noblacklist their path in chatterino.local.
#whitelist ${HOME}/Pictures/
# For custom notification sounds, whitelist/noblacklist their path in chatterino.local.
#whitelist ${HOME}/Music/
# Allow common.
include whitelist-common.inc

# Streamlink+VLC doesn't seem to close properly with apparmor enabled.
#apparmor
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
# Seccomp may break browser integration.
seccomp
seccomp.block-secondary
tracelog

disable-mnt
# Add more private-bin lines for browsers or video players to chatterino.local if wanted.
private-bin chatterino,pgrep
private-bin streamlink,python*,ffmpeg
private-bin cvlc,nvlc,qvlc,rvlc,svlc,vlc
private-bin mpv,env,python*,waf,youtube-dl,yt-dlp
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
private-opt none
private-srv none
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
restrict-namespaces
