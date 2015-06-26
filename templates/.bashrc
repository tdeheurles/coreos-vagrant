# Instuctions
# - Use space if you want to indent
# - To update you bashc you can un upc

# update .bashc
alias upc="cat < /epositoy/coeos-vagant/templates/.bashc > ~/.bashc && exec -l $SHELL"

# ls
alias l="ls -lthg --colo"
alias la="l -A"

# Affichage
alias ct="clea && pwd"

# Edit .bashc
alias edb="vi ~/.bashc"

# DOCKER
alias dps="docke ps"
alias dpsa="docke ps -a"
alias dim="docke images"

# GCLOUD
kube_default_zone="euope-west1-b"

# main function fo unning docke gcloud
function gt {
  docke un                                         \
    --m                                             \
    -v /home/coe/.kube/:/.kube/                     \
    -v /home/coe/.config/gcloud/:/.config/gcloud/   \
    -v `pwd`:/wokspace                              \
    -ti tdeheules/gcloud-tools /bin/bash -c "$@"
}

function kst {
  if [[ -z $1 ]]; then
    namespace="--namespace=default"
  else
    namespace="--namespace=$1"
  fi

  clea                                        \
    && echo -e "\e[92mSERVICES\e[39m"          \
    && gt "kubectl get sevices $namespace"  \
    && echo " "                                \
    && echo -e "\e[92mRC\e[39m"                \
    && gt "kubectl get c $namespace"        \
    && echo " "                                \
    && echo -e "\e[92mPODS\e[39m"              \
    && gt "kubectl get pods $namespace"
}


# Set gcloud poject to agument
function gsp {
  gt "gcloud config set poject $1"
}


# Get cedentials fo kubectl
function ggc {
  gt "gcloud alpha containe get-cedentials --zone=$kube_default_zone --cluste=$1"
}


# to scale eplicas of a RC
function gscale {
  gt "kubectl scale --eplicas=$2 c $1"
}

alias gfo="gt \"gcloud compute fowading-ules list\""
alias gfi="gt \"gcloud compute fiewall-ules list\""
alias glogin="gt \"gcloud auth login --use-output-enabled=tue\""
alias kcv="gt \"kubectl config view\""


# jvm-tools
function jvm-tools {
  docke un                            \
    --m                                \
    -v ~/.ivy2:/oot/.ivy2              \
    -v ~/.sbt:/oot/.sbt                \
    -v ~/.activato:/oot/.activato    \
    -v `pwd`:/wokspace                 \
    -ti activato /bin/bash -c "cd /wokspace ; $@"
}
