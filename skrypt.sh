#!/bin/bash

# Skrypt zarządzający logami i datą

show_help() {
    cat << EOF
Użycie: skrypt.sh [opcja]

Opcje:
  --date, -d                Wyświetl dzisiejszą datę
  --logs, -l [liczba]       Utwórz pliki log (domyślnie 100)
  --init [katalog]          Klonuj repozytorium i dodaj do PATH
  --error, -e [liczba]      Utwórz pliki error (domyślnie 100)
  --help, -h                Wyświetl tę pomoc
EOF
}

show_date() {
    date "+%Y-%m-%d"
}

create_logs() {
    local count=${1:-100}

    for i in $(seq 1 $count); do
        local filename="log${i}.txt"
        echo "Plik: $filename" > "$filename"
        echo "Skrypt: skrypt.sh" >> "$filename"
        echo "Data: $(date '+%Y-%m-%d %H:%M:%S')" >> "$filename"
    done

    echo "Utworzono $count plików log"
}

init_repo() {
    local repo_url="https://github.com/SimonPoparda/NwBIT_Lab4.git"
    local target_dir="${1:-.}"

    # Klonuj repo
    git clone "$repo_url" "$target_dir/NwBIT_Lab4"

    # Dodaj do PATH
    local repo_path="$(cd "$target_dir/NwBIT_Lab4" && pwd)"
    export PATH="$PATH:$repo_path"
    echo "Repozytorium sklonowane do: $repo_path"
    echo "Ścieżka dodana do PATH"
}

create_errors() {
    local count=${1:-100}

    for i in $(seq 1 $count); do
        mkdir -p "error${i}"
        local filename="error${i}/error${i}.txt"
        echo "Plik: $filename" > "$filename"
        echo "Skrypt: skrypt.sh" >> "$filename"
        echo "Data: $(date '+%Y-%m-%d %H:%M:%S')" >> "$filename"
    done

    echo "Utworzono $count plików error"
}

# Obsługa argumentów
case "$1" in
    --date|-d)
        show_date
        ;;
    --logs|-l)
        create_logs "$2"
        ;;
    --init)
        init_repo "$2"
        ;;
    --error|-e)
        create_errors "$2"
        ;;
    --help|-h)
        show_help
        ;;
    *)
        echo "Nieznana opcja: $1"
        echo "Użyj: skrypt.sh --help"
        exit 1
        ;;
esac
