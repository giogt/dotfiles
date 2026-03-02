# Podman - Docker compatibility
alias docker=podman
export PODMAN_HOST="${HOME}/.local/share/containers/podman/machine/podman.sock"
# export DOCKER_HOST="unix:///var/run/docker.sock"
# export DOCKER_HOST="unix://$(podman machine inspect --format '{{.ConnectionInfo.PodmanSocket.Path}}')"

# Podman zsh completion
# if they are out of date, you can generate the completions again using the following command
# podman completion zsh -f ${HOME}/.zim/modules/zsh-completions/src/_podman

