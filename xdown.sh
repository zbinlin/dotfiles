function xdown() {
    link=$1
    if [[ -z "$link" ]];
    then
        echo Usage: xdown {DOWNLOAD_LINK} >&2
        return 1
    fi
    download_link=$(curl -sSLf -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:66.0) Gecko/20100101 Firefox/66.0' "${link}" | grep -Po '(?:var flashvars_\d+\s*=\s*).+(?=;$)' | sed -E 's/^var flashvars_[0-9]+\s*=\s*//' | jq -r '[.mediaDefinitions[] | select(.videoUrl != "" and (.quality | type == "string"))] | max_by(.quality) | .videoUrl')
    if [[ -n "$download_link" ]];
    then
        filename=$(grep -Po '(?<=viewkey=)(.+)' <<<$link)_$(basename ${download_link%%\?*})
        aria2c --out "${filename}" "$download_link"
    else
        echo Could not find download link! >&2
        return 1
    fi
}
