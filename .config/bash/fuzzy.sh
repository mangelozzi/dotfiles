fuzzy_get() {
    search_type=$1  # --type 'file'/'directory'/'both'
    search_scope=$2 # -- scope 'home'/'extended'

    case $search_type in
        file)
            fd_type='--type file'
            ;;
        directory)
            fd_type='--type directory'
            ;;
        both)
            fd_type=''
            ;;
        *)
            echo "Invalid search type"
            return 1
            ;;
    esac


    case $search_scope in
        home)
            dirs=(/home/$(whoami))
            ;;
        extended)
            dirs=(/home/$(whoami) /var/log /var/www /etc)
            ;;
        *)
            echo "Invalid search scope"
            return 1
            ;;
    esac

    existing_dirs=()
    for dir in "${dirs[@]}"; do
        [ -d "$dir" ] && existing_dirs+=("$dir")
    done

    if [ ${#existing_dirs[@]} -eq 0 ]; then
        echo "No valid directories found."
        return 1
    fi

    fd . $fd_type --hidden "${existing_dirs[@]}" | fzf
}

# cd
fuzzy_cd_home() {
    cd "$(fuzzy_get directory home)"
}

fuzzy_cd_extended() {
    cd "$(fuzzy_get directory extended)"
}

# open a file
fuzzy_open_home() {
    file_path=$(fuzzy_get file home)
    [ -n "$file_path" ] && xdg-open "$file_path" &
}

fuzzy_open_extended() {
    file_path=$(fuzzy_get file extended)
    [ -n "$file_path" ] && xdg-open "$file_path" &
}

# neovim
fuzzy_nvim_home() {
    file_path=$(fuzzy_get file home)
    [ -n "$file_path" ] && nvim "$file_path"
}

fuzzy_nvim_extended() {
    file_path=$(fuzzy_get file extended)
    [ -n "$file_path" ] && nvim "$file_path"
}

# list
fuzzy_ll_home() {
    path=$(fuzzy_get both home)
    [ -n "$path" ] && ll "$path"
}

fuzzy_ll_extended() {
    path=$(fuzzy_get both extended)
    [ -n "$path" ] && ll "$path"
}

# Copy path
fuzzy_copy_path_home() {
    path=$(fuzzy_get both home)
    if [ -n "$path" ]; then
        echo -n "$path" | xclip -selection clipboard
        echo "Path copied to clipboard: $path"
    fi
}

fuzzy_copy_path_extended() {
    path=$(fuzzy_get both extended)
    if [ -n "$path" ]; then
        echo -n "$path" | xclip -selection clipboard
        echo "Path copied to clipboard: $path"
    fi
}

# Run executable
fuzzy_run_home() {
    cmd=$(fuzzy_get executable home)
    if [[ -n $cmd ]]; then
        "$cmd" &
    fi
}

fuzzy_run_extended() {
    cmd=$(fuzzy_get executable extended)
    if [[ -n $cmd ]]; then
        "$cmd" &
    fi
}

# Define aliases
alias cdh=fuzzy_cd_home
alias cdf=fuzzy_cd_extended

alias open=fuzzy_open_home
alias openf=fuzzy_open_extended

alias fn=fuzzy_nvim_home
alias fnf=fuzzy_nvim_extended

alias list=fuzzy_ll_home
alias listf=fuzzy_ll_extended

alias copy=fuzzy_copy_path_home
alias copyf=fuzzy_copy_path_extended

alias run=fuzzy_run_home
alias runf=fuzzy_run_extended

# # Fuzzy get
# # e.g. if relying on word splitting: ls $(get)
# # or ls "$(get)"
# get() {
#     # fd --hidden | fzf
#     # since filenames can contain newline
#     # fd -0 terminates with null instead of newline
#     # fzf --read0 = Read input delimited by ASCII NUL characters instead of newline characters
#     fd -0 --hidden | fzf --read0
# }

# # Fuzzy find file/dir and copy to the clipboard
# copy() {
#     if [ ${#fzf_existing_dirs[@]} -eq 0 ]; then
#         echo "No valid directories found."
#         return 1
#     fi
#     echo -n $(fd . --hidden "${fzf_existing_dirs[@]}" | fzf) | xclip -selection c
#     echo "Copied to clipboard: $(xclip -o -selection c)"
# }
