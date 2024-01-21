#!/bin/bash

function Set-ScriptingBackend {
    projectSettingsPath=$1
    platform=$2
    num=$3

    if [[ $platform == "Standalone"* ]]; then
        platform="Standalone"
    fi

    IFS=$'\n'
    mapfile -t contentsList < "$projectSettingsPath"

    for ((i=0; i<${#contentsList[@]}; i++)); do
        if [[ ${contentsList[i]} =~ "scriptingBackend:" ]]; then
            unset 'contentsList[i]'
            ((i++))
            while [[ $i -lt ${#contentsList[@]} && ${contentsList[i]} =~ "    " ]]; do
                unset 'contentsList[i]'
                ((i++))
            done
            break
        fi
    done

    contentsList+=("  scriptingBackend:" "    $platform: $num")
    printf "%s\n" "${contentsList[@]}" > "$projectSettingsPath"
}

Set-ScriptingBackend "$1" "$2" "$3"