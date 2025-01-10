if status is-interactive
    # Commands to run in interactive sessions can go here
end

if status --is-login; and uwsm check may-start
    exec uwsm start hyprland.desktop
end

# pnpm
set -gx PNPM_HOME "/home/litheos/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
