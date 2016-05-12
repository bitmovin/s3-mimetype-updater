#!/bin/bash

usage () {
	echo ""
	echo "Usage:     $0 S3URI accesskey secretkey"
	echo ""
	echo "S3URI:     URI of your S3 bucket to recursively fix the MIME types in (must start with s3://)"
	echo "accesskey: S3 access key of your user"
	echo "secretkey: S3 secret key of your user"
	echo ""
}

get_mime_type () {
	if [[ "$1" == "jpe"  ]]; then echo "image/jpeg"; return; fi
	if [[ "$1" == "jpeg" ]]; then echo "image/jpeg"; return; fi
	if [[ "$1" == "jpg"  ]]; then echo "image/jpeg"; return; fi
	if [[ "$1" == "m3u8" ]]; then echo "application/vnd.apple.mpegurl"; return; fi
	if [[ "$1" == "m4s"  ]]; then echo "video/mp4"; return; fi
	if [[ "$1" == "mp4"  ]]; then echo "video/mp4"; return; fi
	if [[ "$1" == "mpd"  ]]; then echo "application/dash+xml"; return; fi
	if [[ "$1" == "png"  ]]; then echo "image/png"; return; fi
	if [[ "$1" == "ts"   ]]; then echo "video/mp2t"; return; fi

	echo "unknown"
}

process_dir () {
	LISTING="$(s3cmd --access_key=$2 --secret_key=$3 -r -F ls s3://$1)"

	while read -r item; do
		for token in $item; do
			if [[ $token == s3://* ]]
				then if ! [[ $token == */ ]]
					then filename=$(basename "$token")
						extension="${filename##*.}"
						mime_type="$(get_mime_type $extension)"
						if [[ "$mime_type" == "unknown"  ]]
							then echo "No known MIME type applies to $token. Leaving it unchanged."
						else
							echo "Setting MIME type of $token to $mime_type ..."
							s3cmd --access_key=$2 --secret_key=$3 --mime-type="$mime_type" modify $token && echo "Done." || echo "Fail. Return code: $?"
						fi
				fi
			fi
		done
	done <<< "${LISTING}"
}

echo ""

if [[ "$3" == "" ]]; then echo "Insufficient number of arguments supplied."; usage; exit; fi

process_dir $1 $2 $3

