FILENAME=
ENCODING=
TMPDIR=
LANGUAGE=

SOURCE="$0"
while [ -h "$SOURCE"  ]; do # 循环查找SOURCE直到它不再是一个symlink
	DIR="$( cd -P "$( dirname "$SOURCE"  )" && pwd  )"
	SOURCE="$(readlink "$SOURCE")"
	[[ $SOURCE != /*  ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE"  )" && pwd  )"


while getopts "l:p:e:t:h" OPTION
do
     case $OPTION in
         h)
             echo 'help'
             exit 1
             ;;
         p)
             FILENAME=$OPTARG
             ;;
         e)
             ENCODING=$OPTARG
             ;;
         l)
             LANGUAGE=$OPTARG
             ;;
         t)
             TMPDIR=$OPTARG
             ;;
         ?)
             echo 'param error'
             exit
             ;;
     esac
done

export CR_FILENAME=${FILENAME}
if [[ ${LANGUAGE} == "applescript" ]]; then
    osascript ${FILENAME}
elif [[ ${LANGUAGE} == "c" ]]; then
  `${DIR}/c.sh -std=c99`
elif [[ ${LANGUAGE} == "cs" ]]; then
   PATH="/Library/Frameworks/Mono.framework/Versions/Current/bin:$PATH"
  `mono ${DIR}/cs.sh`
elif [[ ${LANGUAGE} == "cpp" ]]; then
  `${DIR}/cpp.sh`
elif [[ ${LANGUAGE} == "lua" ]]; then
  lua ${FILENAME}
elif [[ ${LANGUAGE} == "objc" ]]; then
  `${DIR}/objc.sh -fobjc-arc`
elif [[ ${LANGUAGE} == "py" ]]; then
    python3 ${FILENAME}
elif [[ ${LANGUAGE} == "rb" ]]; then
    ruby ${FILENAME}
elif [[ ${LANGUAGE} == "pl" ]]; then
    perl ${FILENAME}
elif [[ ${LANGUAGE} == "sh" ]]; then
    bash ${FILENAME}
else
    echo "Can not support file type: "${LANGUAGE}
fi

exit 0


