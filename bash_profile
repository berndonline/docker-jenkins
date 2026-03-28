if [ -f /etc/bash_completion ]; then
 . /etc/bash_completion
fi

if command -v kubectl >/dev/null 2>&1; then
 source <(kubectl completion bash)
fi
