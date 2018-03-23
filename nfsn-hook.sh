#!/usr/bin/env bash
set -o errexit -o nounset -o pipefail


function deploy_challenge {
	local DOMAIN="${1}" TOKEN_FILENAME="${2}" TOKEN_VALUE="${3}"
	#echo " + No hook enabled for deploying challenges."
}


function clean_challenge {
	local DOMAIN="${1}" TOKEN_FILENAME="${2}" TOKEN_VALUE="${3}"
	#echo " + No hook enabled for cleaning challenges."
}


function deploy_cert {
	local DOMAIN="${1}" KEYFILE="${2}" CERTFILE="${3}" FULLCHAINFILE="${4}" CHAINFILE="${5}" TIMESTAMP="${6}"
	echo " + Installing new certificate for ${DOMAIN}..."
	cat "$KEYFILE" "$CERTFILE" "$CHAINFILE" | nfsn -i set-tls
}


function exit_hook {
	true
	#echo " + No hook enabled for exit_hook."
}


function invalid_challenge {
	local DOMAIN="${1}" RESULT="${2}"
	echo " + Certificate for ${DOMAIN} had invalid challenge. Result follows:"
	printf '%s\n' "${RESULT}"
}


function unchanged_cert {
	local DOMAIN="${1}" KEYFILE="${2}" CERTFILE="${3}" FULLCHAINFILE="${4}" CHAINFILE="${5}"
	echo " + Certificate for ${DOMAIN} unchanged."
	# echo " + Resetting dead man's switch..."
	# curl -fsS -o /dev/null --data-binary "${DOMAIN} UNCHANGED" https://totmann.danielfett.de/check/{UUID}/log
}

function startup_hook {
	true
}

function function_exists() {
	declare -f "${1}"
	return $?
}

HANDLER="$1"; shift;

if function_exists "$HANDLER"
then
	"$HANDLER" "$@"
fi


