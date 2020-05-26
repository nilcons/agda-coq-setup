FROM haskell:8.8.3
LABEL maintainer="klao@nilcons.com"

RUN apt-get update -q \
        && apt-get install -y -q --no-install-recommends procps less emacs-lucid sudo m4 opam \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/*

################################################################################
## Create the user

ARG guest=demo
ARG guest_uid=1000
ARG guest_gid=${guest_uid}

RUN groupadd -g ${guest_gid} ${guest} \
        && useradd --no-log-init -m -s /bin/bash -g ${guest} -G sudo -p '' -u ${guest_uid} ${guest} \
        && mkdir -p -v /home/${guest}/.local/bin \
        && chown -R ${guest}:${guest} /home/${guest} \
        && sed -i -e '/%sudo/s/)/) NOPASSWD:/' /etc/sudoers

WORKDIR /home/${guest}
USER ${guest}

################################################################################
## Environment

ARG GHC=8.8.3
ARG CABAL_INSTALL=3.2

ENV PATH /home/${guest}/.local/bin:/opt/cabal/${CABAL_INSTALL}/bin:/opt/ghc/${GHC}/bin:/usr/local/bin:/usr/bin:/bin
ENV LC_ALL=C.UTF-8

################################################################################
## Coq

ARG coq_version=8.11.1

RUN opam init --auto-setup --dot-profile=~/.bashrc --yes --jobs=1 --disable-sandboxing \
        && opam pin --yes add coq ${coq_version} \
        && opam clean -a -c -s --logs

################################################################################
## Agda

ADD agda_install.sh ./
RUN ./agda_install.sh

################################################################################
## Emacs setup

ADD dot-emacs.el .emacs
ADD emacs-install-pkgs.sh ./
RUN ./emacs-install-pkgs.sh

CMD bash
