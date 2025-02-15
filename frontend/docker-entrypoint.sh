#!/usr/bin/env sh

set -eu

urlencode() {
    # urlencode <string>
    # blatantly pinched from https://gist.github.com/cdown/1163649

    local length="${#1}"
    for i in $(seq 0 $((length-1))); do
        local c="${1:i:1}"
        case $c in
            [a-zA-Z0-9.~_-]) printf "$c" ;;
            *) printf '%%%02X' "'$c" ;;
        esac
    done
}

sed -i \
  -e "s/sso-client-id/$(urlencode ${OIDC_CLIENT})/g" \
  /usr/share/nginx/html/index.html

exec "$@"
