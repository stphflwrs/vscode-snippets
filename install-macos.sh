#/usr/bin/env bash
set -e
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

snippets_path="${HOME?}/Library/Application Support/Code/User/snippets"
snippets_state=$(file -hb "${snippets_path}" | cut -f1 -d " ")

case "${snippets_state}" in
  "directory")
    read -p "This will overwrite existing snippets. Continue? " -n 1 -r
    ;;
  "symbolic")
    read -p "Snippets may already be setup. Continue anyways?" -n 1 -r
    ;;
  *)
    echo "VSCode snippets currently in an invalid state."
    exit 1
esac

echo
[[ ${REPLY} =~ ^[Yy]$ ]] || (echo "No changes made." && exit 1)
rm -r "${snippets_path}"
ln -s "${script_dir}/snippets" "${snippets_path}"
echo "Snippets installed!"
