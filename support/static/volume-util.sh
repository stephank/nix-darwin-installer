get_root_disk() {
    diskutil info -plist /
}

get_apfs_volumes_for() {
    disk="$1"
    diskutil apfs list -plist "$disk"
}

get_disk_identifier() {
    xpath "/plist/dict/key[text()='ParentWholeDisk']/following-sibling::string[1]/text()" 2>/dev/null
}

get_volume_string() {
    key="$1" i="$2"
    xpath "/plist/dict/array/dict/key[text()='Volumes']/following-sibling::array/dict[$i]/key[text()='$key']/following-sibling::string[1]/text()" 2> /dev/null
}

find_nix_volume() {
    disk="$1"
    i=1
    volumes="$(get_apfs_volumes_for "$disk")"
    while true; do
        name=$(echo "$volumes" | get_volume_string "Name" "$i")
        if [ -z "$name" ]; then
            break
        fi
        case "$name" in
            [Nn]ix*)
                echo "$name"
                break
                ;;
        esac
        i=$((i+1))
    done
}

configure_fstab() {
    volume="$1"
    label=$(echo "$volume" | sed "s/ /\\040/g")
    printf "\$a\nLABEL=%s /nix apfs rw,nobrowse\n.\nwq\n" "$label" | EDITOR=ed vifs
}
