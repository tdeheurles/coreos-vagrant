
# Instructions
# - Use space if you want to indent
# - To update your bashrc you can run uprc

# update .bashrc
alias uprc="cat < /repository/coreos-vagrant/templates/.bashrc > ~/.bashrc && exec -l $SHELL"

# ls
alias l="ls -lthg --color"
alias la="l -A"

# Affichage
alias ct="clear && pwd"

# Edit .bashrc
alias edb="vi ~/.bashrc"

# DOCKER
alias dps="docker ps"
alias dpsa="docker ps -a"
alias dim="docker images"

# GCLOUD
kube_default_zone="europe-west1-b"

function gt {
  docker run                                         \
    --rm                                             \
    -v /home/core/.kube/:/.kube/                     \
    -v /home/core/.config/gcloud/:/.config/gcloud/   \
    -v `pwd`:/workspace                              \
    -ti tdeheurles/gcloud-tools /bin/bash -c "$@"
}

function kst {
  if [[ -z $1 ]]; then
    namespace="--namespace=default"
  else
    namespace="--namespace=$1"
  fi

  clear                                        \
    && echo -e "\e[92mSERVICES\e[39m"          \
    && gt "kubectl get services $namespace"  \
    && echo " "                                \
    && echo -e "\e[92mRC\e[39m"                \
    && gt "kubectl get rc $namespace"        \
    && echo " "                                \
    && echo -e "\e[92mPODS\e[39m"              \
    && gt "kubectl get pods $namespace"
}


# Set gcloud project to argument
function gsp {
  gt "gcloud config set project $1"
}


# Get credentials for kubectl
function ggc {
  gt "gcloud alpha container get-credentials --zone=$kube_default_zone --cluster=$1"
}


# to scale replicas of a RC
function gscale {
  gt "kubectl scale --replicas=$2 rc $1"
}

alias gfor="gt \"gcloud compute forwarding-rules list\""
alias gfir="gt \"gcloud compute firewall-rules list\""
alias glogin="gt \"gcloud auth login --user-output-enabled=true\""
alias kcv="gt \"kubectl config view\""


# jvm-tools
function jvm-tools {
  docker run                            \
    --rm                                \
    -v ~/.ivy2:/root/.ivy2              \
    -v ~/.sbt:/root/.sbt                \
    -v ~/.activator:/root/.activator    \
    -v `pwd`:/workspace                 \
    -ti activator /bin/bash -c "cd /workspace ; $@"
}