# Login shells: runs after /etc/zprofile (path_helper), which reshuffles PATH.
# Re-apply our PATH ordering and environment on top of it.
[[ -f ~/.profile ]] && source ~/.profile
