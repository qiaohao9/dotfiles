export INPUT_METHOD=fcitx5
export GTK_IM_MODULE=fcitx5
export QT_IM_MODULE=fcitx5
export XMODIFIERS=@im=fcitx5

numlockx &
fcitx5 &
flameshot &
xrdb -merge ~/.Xresources
exec i3
