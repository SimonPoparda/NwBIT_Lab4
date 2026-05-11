#!/bin/bash

# Skrypt zarządzający logami i datą

show_help() {
    cat << EOF
Użycie: skrypt.sh [opcja]

Opcje:
  --date           Wyświetl dzisiejszą datę
  --logs [liczba]  Utwórz pliki log (domyślnie 100)
  --help           Wyświetl tę pomoc
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

# Obsługa argumentów
case "$1" in
    --date)
        show_date
        ;;
    --logs)
        create_logs "$2"
        ;;
    --help)
        show_help
        ;;
    *)
        echo "Nieznana opcja: $1"
        echo "Użyj: skrypt.sh --help"
        exit 1
        ;;
esac
