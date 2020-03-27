FROM archlinux/base

RUN pacman -Sy && \
    pacman -Sy --noconfirm openssh \
      git fakeroot binutils go-pie gcc awk binutils xz \
      libarchive bzip2 coreutils file findutils \
      gettext grep gzip sed ncurses

RUN useradd -ms /bin/bash builder && \
    mkdir -p /home/builder/.ssh

COPY ssh_config /home/builder/.ssh/config
COPY gitconfig /home/builder/.gitconfig

RUN chown builder:builder /home/builder -R && \
    chmod 600 /home/builder/.ssh/* -R

COPY entrypoint.sh /entrypoint.sh

USER builder
WORKDIR /home/builder

ENTRYPOINT ["/entrypoint.sh"]

