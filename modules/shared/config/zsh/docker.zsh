# ------------------------------------
# Docker alias and function
# ------------------------------------

# Get latest container ID
alias dl="docker ps -l -q"

# Get container process
alias dps="docker ps"

# Get process included stop container
alias dpa="docker ps -a"

# Get images
alias di="docker images"

# Get container IP
alias dip="docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $1" 

# Run deamonized container, e.g., $dkd base /bin/echo hello
alias dkd="docker run -d -P"

# Run interactive container, e.g., $dki base /bin/bash
alias dki="docker run -i -t -P"

# Execute interactive container, e.g., $dex base /bin/bash
alias dex="docker exec -it"

# Stop all containers
dstop() { docker stop $(docker ps -a -q); }

# Remove all containers
drip() { docker rm $(docker ps -a -q); }

# Stop and Remove all containers
alias dripf='docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)'

# Remove all images
drmi() { docker rmi -f $(docker images -q); }

dspf() { docker system prune -f; }
drmv() { docker volume rm $(docker volume ls -q); }

alias dnuke="dripf && drmi && dspf && drmv"

# Dockerfile build, e.g., $dbu tcnksm/test 
dbu() { docker buildx build -t=$1 .; }


# Bash into running container
dbash() { docker exec -it $(docker ps -aqf "name=$1") bash; }

dalias() {
  "dl    = docker ps -lq"
  "dps   = docker ps"
  "dpa   = docker ps -a"
  "di    = docker images"
  "dip   = docker inspect -f '{{ .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $1"
  "dkd   = docker run -dP"  # run daemonized container      - $dkd base /bin/echo hello
  "dki   = docker run -itP" # run interactive container     - $dki base /bin/bash
  "dex   = docker exec -it" # execute interactive container - $dex base /bin/bash
  "dstop = docker stop $(docker ps -aq)"   # stop all containers
  "drip  = docker rm $*$(docker ps -aq)"   # remove all containers
  "dripf = docker stop $(docker ps -aq) && docker rm $(docker ps -aq)" # stop and remove all containers
  "drmi  = docker rmi $*$(docker images -q)" # remove all images
  "dspf  = docker system prune -f" 
  "drmv  = docker volume rm $(docker volume ls -q)"
  "dnuke = desperation"
  "dbu   = docker build -t = $1 ." # Dockerfile build - $dbu <buildname>
  "dbash = docker exec -it $(docker ps -aqf "name = $1") bash" # bash into running container
}
