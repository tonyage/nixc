{ lib }:

let
  docker = {
    dcid = "docker ps -l -q"; # latest container ID
    dps = "docker ps"; # running containers
    dpa = "docker ps -a"; # all containers, including stopped
    di = "docker images";
    dkd = "docker run -d -P"; # run daemonized container, e.g. `dkd base /bin/echo hello`
    dki = "docker run -i -t -P"; # run interactive container, e.g. `dki base /bin/bash`
    dex = "docker exec -it"; # exec into a container, e.g. `dex base /bin/bash`
    dripf = "docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)"; # stop and remove all containers
    dnuke = "dripf && drmi && dspf && drmv"; # remove all containers, images and volumes, then prune
  };
in
{
  directory = {
    ls = "eza --icons";
    ll = "ls -lah --git --group-directories-first";
    tree = "ls -T";
    ".." = "cd ../";
    "..." = "cd ../../";
    "...." = "cd ../../../";
    "....." = "cd ../../../../";
    rip = "rm -rf";
    vi = "nvim";
    vim = "nvim";
  }
  // docker;

  functions = {
    # Docker
    # Container IP, e.g. `dip <container>`
    dip = "docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' \"$@\"";
    dstop = "docker stop $(docker ps -a -q)"; # stop all containers
    drip = "docker rm $(docker ps -a -q)"; # remove all containers
    drmi = "docker rmi -f $(docker images -q)"; # remove all images
    dspf = "docker system prune -f";
    drmv = "docker volume rm $(docker volume ls -q)"; # remove all volumes
    dbu = "docker buildx build -t=\"$1\" ."; # build ./Dockerfile, e.g. `dbu tcnksm/test`
    dbash = "docker exec -it $(docker ps -aqf \"name=$1\") bash"; # bash into a running container by name

    # List the docker aliases
    dalias = ''
      cat <<'EOF'
      ${lib.concatStringsSep "\n" (lib.mapAttrsToList (name: cmd: "${name} = ${cmd}") docker)}
      EOF
    '';
  };
}
